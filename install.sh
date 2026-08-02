#!/usr/bin/env bash
# CachyOS Setup — minimal package installer
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="${SCRIPT_DIR}/install.log"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
log_info() { echo -e "${CYAN}[INFO]${NC}  $*"; }
log_ok()   { echo -e "${GREEN}[OK]${NC}   $*"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC}  $*"; }
log_err()  { echo -e "${RED}[ERROR]${NC} $*"; }

if [[ -f "$LOG_FILE" ]]; then
    mv "$LOG_FILE" "${LOG_FILE}.old.$(date +%Y%m%d%H%M%S)"
fi
exec > >(tee -a "$LOG_FILE") 2>&1
log_info "Logging to: ${LOG_FILE}"
trap 'log_err "Failed at line ${LINENO}: ${BASH_COMMAND}"' ERR

detect_os() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        case "${ID:-}" in
            arch|cachyos) log_ok "Detected: ${PRETTY_NAME:-$ID}" ;;
            *) log_err "Unsupported: ${ID:-unknown}. This script is for CachyOS/Arch only."; exit 1 ;;
        esac
    else
        log_err "Cannot detect OS."
        exit 1
    fi
}

preflight_checks() {
    log_info "Running preflight checks..."
    detect_os
    if [[ "$(id -u)" -eq 0 ]]; then
        log_err "Do not run as root."
        exit 1
    fi
    if ! sudo -n true 2>/dev/null; then
        log_warn "Sudo required."
        sudo -v
    fi
    log_ok "Preflight passed."
}

pacman_install() {
    local pkgs=("$@") pkg
    for pkg in "${pkgs[@]}"; do
        if pacman -Q "$pkg" &>/dev/null || command -v "$pkg" &>/dev/null; then
            log_ok "${pkg} already installed."
            continue
        fi
        log_info "Installing ${pkg}..."
        sudo pacman -S --needed --noconfirm "$pkg" || log_warn "${pkg} FAILED to install."
    done
}

install_packages() {
    log_info "Installing packages..."

    # Development tools
    pacman_install base-devel

    # Essentials
    pacman_install \
        git curl wget rsync \
        foot \
        python \
        openssh

    # CLI tools
    pacman_install \
        bat fzf zoxide fastfetch jq tmux ripgrep fd tree unzip zip bc lsof pciutils usbutils hwinfo \
        grim slurp wl-clipboard playerctl \
        eza wlsunset \
        lm_sensors ddcutil

    # Fonts
    pacman_install \
        ttf-jetbrains-mono noto-fonts noto-fonts-emoji adobe-source-code-pro-fonts \
        ttf-jetbrains-mono-nerd ttf-meslo-nerd-font-powerlevel10k \
        otf-comicshanns-nerd ttf-ms-fonts

    # GTK/Qt themes & libs
    pacman_install \
        qt6ct qt5ct gtk3 gtk4 libadwaita adwaita-icon-theme papirus-icon-theme \
        nordic-theme \
        bibata-cursor-theme tela-icon-theme

    # GStreamer codecs + encoders
    pacman_install \
        gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav \
        x264 x265

    # gnome-keyring
    pacman_install gnome-keyring

    # Filesystem tools
    pacman_install \
        exfatprogs dosfstools smartmontools

    if command -v sensors-detect &>/dev/null; then
        sudo sensors-detect --auto 2>/dev/null || true
    fi
    log_ok "Packages installed."
}

apply_icon_settings() {
    command -v gsettings &>/dev/null || { log_warn "gsettings not available."; return 0; }
    log_info "Setting Tela-nord-dark as default icon theme..."
    gsettings set org.gnome.desktop.interface icon-theme "Tela-nord-dark" 2>/dev/null && log_ok "Tela-nord-dark set." || log_warn "Failed to set Tela-nord-dark"
    log_info "Setting Bibata-Modern-Ice as cursor..."
    gsettings set org.gnome.desktop.interface cursor-theme "Bibata-Modern-Ice" 2>/dev/null && log_ok "Bibata cursor set." || log_warn "Failed to set Bibata cursor"
}

setup_zsh() {
    pacman_install zsh
    command -v zsh &>/dev/null || { log_warn "Zsh not installed."; return 0; }

    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        log_info "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended 2>/dev/null || true
    else
        log_ok "Oh My Zsh already installed."
    fi

    local p10k_dir="$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
    if [[ ! -d "$p10k_dir" ]]; then
        log_info "Installing Powerlevel10k..."
        git clone --depth 1 https://github.com/romkatv/powerlevel10k.git "$p10k_dir" 2>/dev/null || true
    else
        log_ok "Powerlevel10k already installed."
    fi

    local plugin
    for plugin in zsh-autosuggestions zsh-syntax-highlighting zsh-completions; do
        local pdir="$HOME/.oh-my-zsh/custom/plugins/$plugin"
        if [[ ! -d "$pdir" ]]; then
            log_info "Installing $plugin..."
            git clone --depth 1 "https://github.com/zsh-users/$plugin.git" "$pdir" 2>/dev/null || true
        else
            log_ok "$plugin already installed."
        fi
    done

    local zsh_dotfiles="${SCRIPT_DIR}/dotfiles/zsh"
    if [[ -d "$zsh_dotfiles" ]]; then
        [[ -f "$HOME/.zshrc" ]] && cp "$HOME/.zshrc" "$HOME/.zshrc.bak" 2>/dev/null
        cp "$zsh_dotfiles/.zshrc" "$HOME/.zshrc" && log_ok ".zshrc copied (overwrite)."
        [[ -f "$zsh_dotfiles/.p10k.zsh" ]] && cp "$zsh_dotfiles/.p10k.zsh" "$HOME/.p10k.zsh" && log_ok ".p10k.zsh copied"
    fi

    local zsh_path
    zsh_path="$(command -v zsh)"
    if [[ "$SHELL" != "$zsh_path" ]]; then
        sudo chsh -s "$zsh_path" "$(whoami)" 2>/dev/null || log_warn "chsh failed"
    fi
    log_ok "Zsh configured."
}

set_foot_default() {
    command -v foot &>/dev/null || { log_warn "Foot not installed."; return 0; }
    xdg-mime default foot.desktop x-scheme-handler/terminal 2>/dev/null || true
    log_ok "Foot set as default terminal."
}

copy_dotfiles() {
    log_info "Copying dotfiles..."

    local -A config_map=(
        ["fontconfig"]=".config/fontconfig"
        ["foot"]=".config/foot"
        ["imv"]=".config/imv"
        ["gtk-3.0"]=".config/gtk-3.0"
        ["gtk-4.0"]=".config/gtk-4.0"
        ["qt5ct"]=".config/qt5ct"
        ["qt6ct"]=".config/qt6ct"
        ["btop"]=".config/btop"
        ["cava"]=".config/cava"
        ["yazi"]=".config/yazi"
        ["easyeffects"]=".config/easyeffects"
        ["environment.d"]=".config/environment.d"
    )
    # Deploy noctalia config to XDG_STATE_HOME
    mkdir -p "$HOME/.local/state/noctalia/sounds"
    if [[ -f "${SCRIPT_DIR}/dotfiles/noctalia/settings.toml" ]]; then
        cp "${SCRIPT_DIR}/dotfiles/noctalia/settings.toml" "$HOME/.local/state/noctalia/settings.toml" && log_ok "noctalia settings.toml copied."
    fi
    if [[ -d "${SCRIPT_DIR}/dotfiles/noctalia/sounds" ]]; then
        cp "${SCRIPT_DIR}/dotfiles/noctalia/sounds"/* "$HOME/.local/state/noctalia/sounds/" 2>/dev/null || true
        log_ok "noctalia sounds copied."
    fi

    for src_dir in "${!config_map[@]}"; do
        local src="${SCRIPT_DIR}/dotfiles/${src_dir}"
        local dst="$HOME/${config_map[$src_dir]}"
        if [[ -d "$src" ]]; then
            mkdir -p "$dst"
            cp -r "$src"/. "$dst/" 2>/dev/null || true
            log_ok "${src_dir} copied."
        else
            log_warn "${src_dir} not found, skipping."
        fi
    done

    if [[ -f "${SCRIPT_DIR}/dotfiles/clean/clean.sh" ]]; then
        mkdir -p "$HOME/.config/clean" && cp "${SCRIPT_DIR}/dotfiles/clean/clean.sh" "$HOME/.config/clean/clean.sh" 2>/dev/null && chmod +x "$HOME/.config/clean/clean.sh" && log_ok "clean.sh copied."
    fi

    log_ok "Dotfiles copied."
}

copy_wallpapers() {
    local src="${SCRIPT_DIR}/Wallpapers"
    local dst="$HOME/Pictures/Wallpapers"
    [[ -d "$src" ]] || { log_warn "Wallpapers dir not found."; return 0; }
    mkdir -p "$dst"
    cp -r "$src"/* "$dst/" 2>/dev/null || true
    log_ok "Wallpapers copied."
}

setup_chaotic_aur() {
    log_info "Setting up Chaotic-AUR (binary repo mirror, via pacman)..."
    if pacman -Qi chaotic-keyring &>/dev/null; then
        log_ok "Chaotic-AUR already configured."
        return 0
    fi
    sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com 2>/dev/null || true
    sudo pacman-key --lsign-key 3056513887B78AEB 2>/dev/null || true
    sudo pacman -U --noconfirm \
        'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' \
        'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' 2>/dev/null
    if ! grep -q '\[chaotic-aur\]' /etc/pacman.conf 2>/dev/null; then
        echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf >/dev/null
    fi
    sudo pacman -Sy --noconfirm 2>/dev/null
    log_ok "Chaotic-AUR configured."
}

setup_gnome_keyring() {
    log_info "Enabling gnome-keyring systemd user service..."
    if systemctl --user enable --now gnome-keyring-daemon.service 2>/dev/null; then
        log_ok "gnome-keyring enabled & started."
    else
        log_warn "gnome-keyring enable failed."
    fi
}

main() {
    preflight_checks
    setup_chaotic_aur
    install_packages
    apply_icon_settings
    set_foot_default
    setup_zsh
    copy_dotfiles
    setup_gnome_keyring
    copy_wallpapers
    echo ""
    log_ok "Setup complete."
    log_info "Log saved to: ${LOG_FILE}"
}

main "$@"
