#!/usr/bin/env bash
# CachyOS.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="${SCRIPT_DIR}/apps.log"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
log_info() { echo -e "${CYAN}[INFO]${NC}  $*"; }
log_ok()   { echo -e "${GREEN}[OK]${NC}   $*"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC}  $*"; }
log_err()  { echo -e "${RED}[ERROR]${NC} $*"; }

if [[ -f "$LOG_FILE" ]]; then
    mv "$LOG_FILE" "${LOG_FILE}.old.$(date +%Y%m%d%H%M%S)"
fi
exec > >(tee -a "$LOG_FILE") 2>&1
trap 'log_err "Failed at line ${LINENO}: ${BASH_COMMAND}"' ERR

detect_os() {
    [[ -f /etc/os-release ]] && . /etc/os-release
    case "${ID:-}" in arch|cachyos) return 0 ;; esac
    log_err "This script is for CachyOS/Arch only."; exit 1
}

preflight_checks() {
    [[ "$(id -u)" -ne 0 ]] || { log_err "Do not run as root."; exit 1; }
    detect_os
    sudo -n true 2>/dev/null || sudo -v
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

remove_cachyos_defaults() {
    log_info "Removing CachyOS pre-installed packages (not needed)..."
    sudo pacman -Rns --noconfirm micro alacritty meld cachyos-micro-settings 2>/dev/null || true
    log_ok "Removed micro, alacritty, meld."

    log_info "Hiding unused desktop entries..."
    local entries="avahi-discover.desktop bssh.desktop bvnc.desktop qv4l2.desktop qvidcap.desktop footclient.desktop foot-server.desktop rofi.desktop rofi-theme-selector.desktop"
    for f in $entries; do
        if [ -f "/usr/share/applications/$f" ]; then
            cp -n "/usr/share/applications/$f" ~/.local/share/applications/ 2>/dev/null || true
            grep -qx "Hidden=true" ~/.local/share/applications/"$f" 2>/dev/null || \
                echo "Hidden=true" >> ~/.local/share/applications/"$f"
        fi
    done
    log_ok "Desktop entries hidden."
}

install_core_app_support() {
    log_info "Installing desktop app support..."

    pacman_install \
        nautilus gvfs gvfs-smb libmtp nautilus-open-any-terminal \
        yazi btop mpv imv gnome-calculator \
        qt6-declarative qt6-svg qt6-multimedia qt6-multimedia-ffmpeg pavucontrol \
        imagemagick \
        xdg-desktop-portal-gtk xdg-utils xdg-user-dirs python-gobject wtype wdisplays \
        cava \
        ffmpegthumbnailer nautilus-image-converter \
        gdu qt6-5compat \
        mpv-mpris gpu-screen-recorder satty tldr \
        font-manager \
        gamemode lib32-gamemode faugus-launcher protonplus \
        easyeffects

  command -v xdg-user-dirs-update &>/dev/null && xdg-user-dirs-update 2>/dev/null || true

    if command -v nautilus &>/dev/null; then
        gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal foot 2>/dev/null || true
    fi
    log_ok "Core desktop app support installed."
}

fix_terminal_desktop() {
    local apps=(btop yazi)
    local app src dst
    mkdir -p ~/.local/share/applications
    for app in "${apps[@]}"; do
        src="/usr/share/applications/${app}.desktop"
        dst="$HOME/.local/share/applications/${app}.desktop"
        [[ -f "$src" ]] || { log_warn "Source desktop not found: ${src}"; continue; }
        grep -q "foot" "$dst" 2>/dev/null && continue
        cp "$src" "$dst"
        sed -i 's|^Exec=\(.*\)$|Exec=foot -e \1|; s/^Terminal=true/Terminal=false/' "$dst"
        log_ok "Fixed desktop: ${app} (foot)"
    done
}

deploy_custom_desktop_entries() {
    local src="${SCRIPT_DIR}/dotfiles/hypr/applications"
    local dst="$HOME/.local/share/applications"
    if [[ -d "$src" ]]; then
        mkdir -p "$dst"
        cp -r "$src"/. "$dst/" 2>/dev/null || true
        log_ok "Custom desktop entries deployed."
    fi
    local icon_src="${SCRIPT_DIR}/dotfiles/hypr/icons"
    local icon_dst="$HOME/.local/share/icons/hicolor/48x48/apps"
    if [[ -d "$icon_src" ]]; then
        mkdir -p "$icon_dst"
        cp -r "$icon_src"/. "$icon_dst/" 2>/dev/null || true
        gtk-update-icon-cache "$HOME/.local/share/icons/hicolor" 2>/dev/null || true
        log_ok "Custom desktop icons deployed."
    fi
}

deploy_tmux_config() {
    local src="${SCRIPT_DIR}/dotfiles/tmux/tmux.conf"
    local dst="$HOME/.config/tmux/tmux.conf"
    [[ -f "$dst" ]] && return 0
    mkdir -p "$(dirname "$dst")"
    cp "$src" "$dst"
    log_ok "tmux config deployed."
}

apply_icon_cursor_settings() {
    command -v gsettings &>/dev/null || { log_warn "gsettings not available."; return 0; }

    log_info "Setting Tela-nord-dark as default icon theme..."
    if gsettings set org.gnome.desktop.interface icon-theme "Tela-nord-dark" 2>/dev/null; then
        log_ok "Tela-nord-dark set as default."
    else
        log_warn "Failed to apply Tela-nord-dark icon theme (session may be inactive)."
    fi

    log_info "Setting Bibata-Modern-Ice as default cursor..."
    if gsettings set org.gnome.desktop.interface cursor-theme "Bibata-Modern-Ice" 2>/dev/null; then
        log_ok "Bibata cursor set as default."
    else
        log_warn "Failed to apply Bibata cursor theme (session may be inactive)."
    fi
}

main() {
    preflight_checks
    remove_cachyos_defaults
    install_core_app_support
    fix_terminal_desktop
    deploy_custom_desktop_entries
    deploy_tmux_config
    apply_icon_cursor_settings
    log_ok "CachyOS app support complete. Log: ${LOG_FILE}"
}

main "$@"
