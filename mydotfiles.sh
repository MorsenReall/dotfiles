#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="${SCRIPT_DIR}/mydotfiles.log"

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

HYPR_SRC="${SCRIPT_DIR}/dotfiles/hypr"
HYPR_DST="${HOME}/.config/hypr"

preflight() {
    [[ "$(id -u)" -ne 0 ]] || { log_err "Do not run as root."; exit 1; }
}

copy_dotfiles() {
    log_info "Copying hypr dotfiles..."
    mkdir -p "$HYPR_DST"
    cp -r "$HYPR_SRC"/. "$HYPR_DST/"
    log_ok "Hypr dotfiles copied to ${HYPR_DST}"
    hyprctl reload 2>/dev/null && log_ok "Hyprland reloaded." || log_warn "Hyprland not running, reload skipped."
}

setup_chaotic_aur() {
    if pacman -Qi chaotic-keyring &>/dev/null; then
        log_ok "Chaotic-AUR already configured."
        return 0
    fi
    log_info "Setting up Chaotic-AUR (binary repo mirror)..."
    sudo -n true 2>/dev/null || sudo -v
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

install_gaming() {
    echo ""
    echo -e "${YELLOW}Install gaming mode (DeckShift session switch)?${NC}"
    echo -e "  Gaming mode butuh Chaotic-AUR repo + gamescope-session-git."
    echo -e "  Semua akan diinstall otomatis."
    echo -e "  ${RED}Wajib pake SDDM${NC} sebagai display manager."
    read -r -p "$(echo -e "${CYAN}[INPUT]${NC}  Lanjut? (y/N): ")" ans
    case "$ans" in
        [yY]|[yY][eE][sS])
            log_info "Installing gaming mode..."
            setup_chaotic_aur
            if [[ -x "${SCRIPT_DIR}/gaming.sh" ]]; then
                "${SCRIPT_DIR}/gaming.sh"
                log_ok "Gaming mode installed."
            else
                log_err "gaming.sh not found!"
                return 1
            fi
            ;;
        *)
            log_info "Skipping gaming mode."
            ;;
    esac
}

main() {
    preflight
    [[ -d "$HYPR_SRC" ]] || { log_err "hypr dotfiles not found at $HYPR_SRC"; exit 1; }
    copy_dotfiles
    install_gaming
    echo ""
    log_ok "All done! Log: ${LOG_FILE}"
}

main "$@"
