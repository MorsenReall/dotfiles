# CachyOS My Dotfiles

Personal dotfiles for **ASUS TUF Gaming A15 FA506ICB** — AMD Renoir + NVIDIA RTX 3050.

Current: **Hyprland** (stable, Lua API) + **Noctalia Shell v5**

---

## Dotfiles

### Requirements

Sudah terinstall di system:
- **Hyprland** (dari repo official/chaotic-aur)
- **Noctalia** (shell)
- **rofi** (untuk preset switcher)
- **Foot** (terminal)
- Font: **JetBrainsMono Nerd Font**, **ComicShannsMono Nerd Font**
- Theme: **Bibata-Modern-Ice** cursor, **Tela-nord-dark** icons, **Nordic** GTK

> Kalau belum punya, jalanin installer step 1-3 di bagian bawah.

### mydotfiles.sh — Copy Hypr Config

Aman, gak perlu sudo, gak install package, cuma copy file.

```bash
git clone https://github.com/tofan79/cachyos-mydotfiles.git && cd cachyos-mydotfiles
chmod +x mydotfiles.sh
./mydotfiles.sh
```

Nanti di-prompt: **Install gaming mode? (y/N)** — jawab `y` kalo mau, `n` kalo skip.

**Yang di-copy:**
- `dotfiles/hypr/` → `~/.config/hypr/` (full config: keybinds, layouts, monitor, rules, gestures, env, presets, scripts)
- Kalau gaming mode Yes → jalanin `gaming.sh` untuk setup DeckShift session switch

---

## Installer (Fresh OS)

Buat yang install dari awal — jalanin step by step:

```bash
git clone https://github.com/tofan79/cachyos-mydotfiles.git && cd cachyos-mydotfiles
chmod +x *.sh
```

| Step | Script | What it does |
|------|--------|-------------|
| 1 | `./install.sh` | Core OS: packages, fonts, themes, Nerd Fonts, Oh My Zsh + Powerlevel10k, mise, opencode, Flatpak, dotfiles (foot/gtk/qt/btop/cava/zsh/dll), wallpapers |
| 2 | `./hyprland-noctalia.sh` | Hyprland + Noctalia + SDDM + rofi + switcheroo-control + polkit fix + dotfiles (hypr/rofi/xdg-desktop-portal/fastfetch/MangoHud/nvim/) |
| 3 | `./apps.sh` | Apps: Nautilus, Zen browser, Neovim + AstroNvim, tmux, Yazi, MPV, Telegram, LocalSend, PHP dev stack, Docker, ASUS tools, desktop fixes |
| 4 | `./gaming.sh` | Gaming session: DeckShift (gamescope-session-git via chaotic-aur) + Steam gamescope session switch |
| 5 | `sudo ./firewall.sh` | UFW: deny incoming, allow LocalSend (53317/udp+tcp), enable |

---

### `install.sh`

**Packages:**
- **Dev:** `base-devel git curl wget rsync libva-utils cmake meson ninja python python-pip shellcheck openssh flatpak`
- **Display/WM:** `foot`
- **CLI:** `bat fzf zoxide fastfetch jq tmux ripgrep fd tree unzip zip bc lsof pciutils usbutils hwinfo grim slurp wl-clipboard brightnessctl playerctl eza pamixer wlsunset lm_sensors ddcutil dua-cli`
- **Fonts:** `ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-meslo-nerd-font-powerlevel10k noto-fonts noto-fonts-emoji adobe-source-code-pro-fonts otf-comicshanns-nerd ttf-ms-fonts`
- **Theming:** `qt6ct qt5ct gtk3 gtk4 libadwaita adwaita-icon-theme papirus-icon-theme nordic-theme bibata-cursor-theme tela-icon-theme`
- **GStreamer:** `gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav x264 x265`
- **FS tools:** `exfatprogs ntfs-3g btrfs-progs cifs-utils dosfstools smartmontools logrotate tcpdump`

**Setup:**
- Flatpak + Flathub remote + OBS Studio (+ PipeWire plugin) + Karere
- Tela icon theme (`tela-icon-theme` → `Tela-nord-dark`)
- Bibata cursor (`bibata-cursor-theme` → `Bibata-Modern-Ice`)
- JetBrainsMono + FiraCode Nerd Fonts (manual download)
- Oh My Zsh + Powerlevel10k + zsh-autosuggestions + zsh-syntax-highlighting + zsh-completions
- `.zshrc` backup existing then overwrite; `.p10k.zsh` overwrites
- `chsh` to zsh, pacman aliases
- fastfetch config
- mise (runtime manager), opencode
- Foot as default terminal (`xdg-mime`, foot.ini)
- Fontconfig: ComicShannsMono Nerd Font monospace
- Git config: aliases, pull.rebase, push.autoSetupRemote, diff histogram, rerere, defaultBranch=main
- Sensors auto-detect
- `gnome-keyring` package + enable systemd user service

**Copied:**
- `dotfiles/foot/` → `~/.config/foot/`
- `dotfiles/fontconfig/` → `~/.config/fontconfig/`
- `dotfiles/git/` → `~/.config/git/`
- `dotfiles/gtk-3.0/` → `~/.config/gtk-3.0/`
- `dotfiles/gtk-4.0/` → `~/.config/gtk-4.0/`
- `dotfiles/imv/` → `~/.config/imv/`
- `dotfiles/qt5ct/` → `~/.config/qt5ct/`
- `dotfiles/qt6ct/` → `~/.config/qt6ct/`
- `dotfiles/btop/` → `~/.config/btop/`
- `dotfiles/cava/` → `~/.config/cava/`
- `dotfiles/yazi/` → `~/.config/yazi/`
- `dotfiles/zed/` → `~/.config/zed/`
- `dotfiles/zsh/.zshrc` → `~/`, `.p10k.zsh` → `~/`
- `dotfiles/noctalia/settings.toml` + `sounds/` → `~/.local/state/noctalia/`
- `Wallpapers/` → `~/Pictures/Wallpapers/`
- `dotfiles/clean/clean.sh` → `~/.config/clean/`
- `dotfiles/easyeffects/` → `~/.config/easyeffects/` (audio EQ presets)
- `dotfiles/environment.d/` → `~/.config/environment.d/` (Steam/gamescope env vars)
- `docker-db/` → `~/Projects/docker-db/`

---

### `hyprland-noctalia.sh`

**Packages:** `hyprland rofi cliphist xdg-desktop-portal-hyprland hyprpicker nvidia-utils lib32-nvidia-utils sddm switcheroo-control noctalia gnome-keyring`

**Setup:**
- SDDM enabled as display manager
- `switcheroo-control` service enabled for NVIDIA dGPU switching
- Session file: `/usr/share/wayland-sessions/hyprland.desktop` → "Hyprland (Noctalia)"
- Polkit fix: `/etc/polkit-1/rules.d/49-networkmanager.rules`
- `gnome-keyring-daemon.service` enabled
- Noctalia state: `sed "s|/home/mindset|$HOME|g"` pada `settings.toml` + copy sounds

**Copied:**
- `dotfiles/hypr/` → `~/.config/hypr/`
- `dotfiles/rofi/` → `~/.config/rofi/`
- `dotfiles/xdg-desktop-portal/` → `~/.config/xdg-desktop-portal/`
- `dotfiles/fastfetch/` → `~/.config/fastfetch/`
- `dotfiles/MangoHud/` → `~/.config/MangoHud/`
- `dotfiles/nvim/` → `~/.config/nvim/`

---

### `apps.sh`

**Packages:**
- **Desktop:** `nautilus gvfs gvfs-afc gvfs-gphoto2 gvfs-smb libmtp nautilus-open-any-terminal yazi neovim btop mpv mpv-mpris imv evince gnome-disk-utility gnome-calculator easyeffects`
- **Qt:** `qt6-declarative qt6-svg qt6-multimedia qt6-multimedia-ffmpeg qt6-5compat pavucontrol`
- **Utils:** `tesseract tesseract-data-eng imagemagick xdg-desktop-portal-gtk xdg-utils xdg-user-dirs python-gobject wtype wdisplays cava satty tldr gum lazydocker gpu-screen-recorder dua-cli bat eza fd`
- **Network:** `ncdu httpie bind whois traceroute mtr socat nmap github-cli strace python-pipx`
- **Apps:** `telegram-desktop localsend zen-browser-bin zed font-manager protonplus ab-download-manager faugus-launcher android-studio intellij-idea-community-edition zoom`
- **Gaming:** `gamemode lib32-gamemode`
- **Dev:** `ffmpegthumbnailer nautilus-image-converter lazygit nodejs bottom gdu docker docker-buildx docker-compose`
- **PHP:** `php php-gd php-intl php-pgsql php-sqlite php-fpm php-tidy php-imagick php-redis php-memcached php-mongodb php-apcu composer php-igbinary php-xsl`

**Setup:**
- ASUS hardware auto-detected: `asusctl` + `rog-control-center` (hanya ASUS)
- ASUS daemon (`asusd`) enabled
- Desktop file fixes: btop, nvim, yazi → run inside Foot
- Nautilus: right-click → Open in Terminal (foot)
- Docker service enabled + user to docker group
- Desktop entries + icons for lazydocker + dua
- Neovim AstroNvim config (`dotfiles/nvim/`)
- tmux config (`dotfiles/tmux/`)
- Icon/cursor theme via `gsettings`
- PHP: install packages + deploy `dotfiles/php/php.ini` + `conf.d/*` ke `/etc/php/`
- Laravel installer via Composer
- CachyOS bloat removal: micro, alacritty, meld, cachyos-micro-settings
- Hide unused desktop entries

---

### `gaming.sh`

**Gaming session (DeckShift):**

Instalasi:
- `gamescope-session-git` via pacman (chaotic-aur binary repo)
- Script session ke `/usr/local/bin/`
- SDDM gaming session entry + autologin config
- Sudoers rules + polkit NetworkManager + user groups (input/video)
- Performance tuning: udev rules, memlock limits, pipewire latency, shader cache, NVIDIA env

> Note: `gamescope-session-steam-git` di-skip karena duplikat entry di SDDM.

**Keybind:**
- `SUPER + SHIFT + G` → Switch ke gaming session
- `SUPER + SHIFT + R` → Balik ke desktop

---

### `firewall.sh`

```bash
ufw default deny incoming
ufw default allow outgoing
ufw allow 53317/udp
ufw allow 53317/tcp
ufw --force enable
systemctl enable ufw
```

---

## Hyprland Config (`~/.config/hypr/`)

Entry point: `hyprland.lua`

```lua
require("monitor")
require("env")
require("noctalia")
dofile("colors.lua")
dofile("windows/glass.lua")
dofile("decorations/rounding-all-blur.lua")
dofile("animations/wipe-meta.lua")
require("keybinds")
require("rules")
require("layouts")
require("gestures")
require("startup")
```

### `monitor.lua`
```lua
hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@144",
    position = "auto",
    scale    = 1,
    vrr      = 1,
})
```

### `env.lua`
```lua
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "24")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
```

### `noctalia.lua`
Generated by Noctalia. Uses `local` variables.

### `layouts.lua`
- Dwindle: `preserve_split = true`, `force_split = 2`
- Scrolling: `fullscreen_on_one_column = false`
- Persistent workspaces 1-9
- Default: dwindle

### `rules.lua`
| App | Behavior |
|-----|----------|
| Steam | Floating (1200x800) + idle inhibit |
| Zen Browser | Idle inhibit |
| Zoom | Idle inhibit |
| LocalSend | Floating (800x600) |
| GNOME Calculator | Floating (400x500) |
| Pavucontrol | Floating (800x600) |
| Btop | Floating (1200x700) |
| imv | Floating (900x700) |
| mpv | Floating (900x600) + idle inhibit fullscreen |
| XWayland empty drag fix | `no_focus = true` |

### `gestures.lua`
| Gesture | Action |
|---------|--------|
| 3-finger vertical | Workspace switch |
| 3-finger horizontal | Scroll move (0.9 scale) |
| 4-finger pinch out | Fullscreen on |
| 4-finger pinch in | Fullscreen off |
| 4-finger vertical | Workspace switch |

### `startup.lua`
```lua
hl.on("hyprland.start", function()
    hl.exec_cmd("sleep 1 && dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland >/dev/null 2>&1 &")
    hl.exec_cmd("/usr/lib/xdg-desktop-portal-gtk >/dev/null 2>&1 &")
    hl.exec_cmd("sleep 1 && /usr/lib/xdg-desktop-portal >/dev/null 2>&1 &")
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("noctalia")
end)
```

---

## Keybindings

All binds use `SUPER`. View at runtime: `SUPER + SHIFT + K`

### Core
| Key | Action |
|-----|--------|
| `SUPER + Q` | Close window |
| `SUPER + CTRL + R` | Reload Hyprland |
| `SUPER + Escape` | Session menu |
| `SUPER + SHIFT + L` | Lock screen |
| `SUPER + /` | btop |

### Noctalia Shell
| Key | Action |
|-----|--------|
| `SUPER + Space` | App launcher |
| `SUPER + ALT + Space` | Control center |
| `SUPER + CTRL + Space` | Settings |
| `SUPER + CTRL + W` | Wallpaper picker |
| `SUPER + CTRL + C` | Caffeine toggle |
| `SUPER + CTRL + period` | Clear notifications |
| `SUPER + CTRL + comma` | Clear clipboard |
| `SUPER + CTRL + slash` | Wallhaven browser |
| `SUPER + CTRL + backslash` | Video wallpaper picker |
| `SUPER + CTRL + P` | Color picker |

### Focus & Swap
| Key | Action |
|-----|--------|
| `SUPER + arrows` | Move focus |
| `SUPER + SHIFT + arrows` | Swap window |
| `SUPER + CTRL + up/down` | Prev/Next workspace |

### Window States
| Key | Action |
|-----|--------|
| `SUPER + F` | Fullscreen toggle |
| `SUPER + SHIFT + F` | Maximize toggle |
| `SUPER + SHIFT + T` | Float toggle |
| `SUPER + ALT + T` | Float + pin toggle |

### Scratchpad
| Key | Action |
|-----|--------|
| `SUPER + S` | Toggle special workspace |
| `SUPER + SHIFT + S` | Send to special |
| `SUPER + SHIFT + CTRL + S` | Move out |

### Layout
| Key | Action |
|-----|--------|
| `SUPER + CTRL + L` | Cycle layout |
| `SUPER + CTRL + K` | Swap split |
| `SUPER + CTRL + J` | Toggle split |

### Groups
| Key | Action |
|-----|--------|
| `SUPER + CTRL + G` | Toggle group |
| `SUPER + CTRL + Bracketleft/right` | Into group l/r |
| `SUPER + ALT + Bracketleft/right` | Into group u/d |
| `SUPER + SHIFT + G` | Out of group |
| `SUPER + Tab` / `SHIFT + Tab` | Next/prev group |

### Presets (Rofi)
| Key | Action |
|-----|--------|
| `SUPER + CTRL + A` | Switch animation preset |
| `SUPER + CTRL + D` | Switch decoration preset |
| `SUPER + CTRL + S` | Switch window preset |
| `SUPER + SHIFT + A` | Toggle animations on/off |

### App Launchers
| Key | App |
|-----|-----|
| `SUPER + Enter` | Foot terminal |
| `SUPER + E` | Nautilus |
| `SUPER + B` | Zen browser |
| `SUPER + N` | Zed editor |
| `SUPER + L` | LocalSend |
| `SUPER + T` | Telegram |
| `SUPER + W` | Karere |
| `SUPER + D` | Vesktop (Discord) |
| `SUPER + G` | Steam |
| `SUPER + A` | AionUI |
| `SUPER + U` | AB Download Manager |
| `SUPER + P` | ProtonPlus |
| `SUPER + ALT + G` | Gaming mode switch |

### Workspaces
| Key | Action |
|-----|--------|
| `SUPER + 1-9` | Switch to workspace |
| `SUPER + SHIFT + 1-9` | Move window to workspace |
| `SUPER + scroll` | Prev/Next workspace |

### Media Keys
Volume/brightness/playback via Noctalia. Sleep → lock & suspend.

### Multi-Monitor
`SUPER + CTRL + ALT + arrows` → focus monitor. `+ SHIFT` → move to monitor.

### Resize & Move
`CTRL + ALT + arrows` → resize. `CTRL + SHIFT + arrows` → move floating.

---

## Presets

### Animations (`~/.config/hypr/animations/*.lua`)
16 presets via `SUPER + CTRL + A`:
`animations-classic`, `animations-dynamic`, `animations-end4`, `animations-fast`, `animations-high`, `animations-moving`, `animations-smooth`, `default`, `disabled`, `metamorphosis`, `moving-meta`, `slide`, `smooth-meta`, `standard`, `wipe`, `wipe-meta`

Default: `wipe-meta.lua` — borderangle wipe, speed 20

### Decorations (`~/.config/hypr/decorations/*.lua`)
10 presets via `SUPER + CTRL + D`:
`blur`, `default`, `gamemode`, `no-blur`, `no-rounding`, `no-rounding-more-blur`, `rounding-all-blur`, `rounding-all-blur-no-shadows`, `rounding`, `rounding-more-blur`

Default: `rounding-all-blur.lua` — rounding 10px, opacity 0.9/0.7, blur 2/2, shadow range 30

### Windows (`~/.config/hypr/windows/*.lua`)
14 presets via `SUPER + CTRL + W`:
`border-1..4`, `border-1..4-reverse`, `default`, `gamemode`, `glass`, `no-border`, `no-border-more-gaps`, `transparent`

Default: `glass.lua` — gaps_in 5, gaps_out 10, border 2px, gradient active border

---

## Gaming

### game-launch.sh

```bash
export NVPRESENT_ENABLE_SMOOTH_MOTION=1
export DXVK_NVAPI_VKREFLEX=1
export PROTON_ENABLE_NGX_UPDATER=1
exec switcherooctl launch -- gamemoderun mangohud "$@"
```

Steam launch option: `~/.config/hypr/scripts/game-launch.sh %command%`

### MangoHud
```
position=top-center | gpu_stats gpu_temp gpu_name | cpu_stats cpu_temp | ram fps frame_timing
```

---

## Scripts (`~/.config/hypr/scripts/`)

| Script | Bind | Function |
|--------|------|----------|
| `keybindings.sh` | `SUPER + SHIFT + K` | Interactive keybind viewer |
| `switch-animations.sh` | `SUPER + CTRL + A` | Rofi selector animation presets |
| `switch-decorations.sh` | `SUPER + CTRL + D` | Rofi selector decoration presets |
| `switch-windows.sh` | `SUPER + CTRL + W` | Rofi selector window presets |
| `toggle-animations.sh` | `SUPER + SHIFT + A` | Toggle animations on/off |
| `text-extractor.sh` | `SUPER + ALT + A` | OCR selected region |
| `game-launch.sh` | — | NVIDIA optimizations + gamemode + MangoHud |
| `lock-and-suspend.sh` | `XF86Sleep` | Lock then suspend |

---

## Theme Stack

| Layer | Theme |
|-------|-------|
| Icons | Tela-nord-dark |
| Cursor | Bibata-Modern-Ice 24px |
| GTK | Nordic |
| Qt5/Qt6 | Fusion + Noctalia palette |
| Terminal | Foot + ComicShannsMono Nerd 10pt |
| Shell | Zsh + Powerlevel10k |
| Rofi | Noctalia, centered, rounded 24px |

---

## Complete Dotfiles Reference

| Dir | Copied by | Contents |
|-----|-----------|----------|
| `hypr/` | `mydotfiles.sh` / `hyprland-noctalia.sh` | Full Hyprland Lua config + presets + scripts |
| `rofi/` | `hyprland-noctalia.sh` | Noctalia theme |
| `xdg-desktop-portal/` | `hyprland-noctalia.sh` | default=hyprland |
| `fastfetch/` | `hyprland-noctalia.sh` | Custom Omarchy layout |
| `MangoHud/` | `hyprland-noctalia.sh` | Gaming overlay |
| `nvim/` | `hyprland-noctalia.sh` + `apps.sh` | AstroNvim v6 |
| `foot/` | `install.sh` | ComicShannsMono Nerd Font 10pt |
| `fontconfig/` | `install.sh` | Font fallbacks |
| `git/` | `install.sh` | Git config |
| `imv/` | `install.sh` | Keybinds |
| `gtk-3.0/` | `install.sh` | Tela-nord-dark, Bibata, Nordic |
| `gtk-4.0/` | `install.sh` | Nordic theme |
| `qt5ct/` | `install.sh` | Fusion + Noctalia palette |
| `qt6ct/` | `install.sh` | Fusion + Noctalia palette |
| `btop/` | `install.sh` | noctalia theme |
| `cava/` | `install.sh` | Noctalia theme |
| `yazi/` | `install.sh` | noctalia flavor |
| `zed/` | `install.sh` | Noctalia Dark Transparent |
| `zsh/` | `install.sh` | .zshrc + .p10k.zsh |
| `noctalia/` | `install.sh` + `hyprland-noctalia.sh` | settings.toml + sounds |
| `easyeffects/` | `install.sh` | Audio EQ presets |
| `environment.d/` | `install.sh` | Steam/gamescope env vars |
| `clean/` | `install.sh` | clean.sh system cleanup |
| `php/` | `apps.sh` | php.ini + conf.d/* (installed to /etc/php/) |
| `gaming-mode/` | `gaming.sh` | DeckShift session configs + scripts |
| `tmux/` | `apps.sh` | C-Space prefix, vi mode |
| `Wallpapers/` | `install.sh` | Copied to ~/Pictures/Wallpapers/ |
| `docker-db/` | `install.sh` | MariaDB + PostgreSQL dev DB |

---

## Maintenance

```bash
~/.config/clean/clean.sh
```

Cleans: pacman cache, orphans, Flatpak unused, Go/pip/npm/Cargo caches, mise, temp, journal (>3d), trash, browser caches, shader caches, Qt/GTK caches, Zed cache, zsh history, thumbnails.

---

## Notes

- `hyprctl eval "hl.config({...})"` — runtime config di Hyprland Lua API
- Noctalia regenerates `noctalia.lua` — `colors.lua` re-applies via text parsing
- Session name: **"Hyprland (Noctalia)"** in SDDM
- Audio fix: `fix-audio.sh` — portable, self-contained. Jalan standalone atau via `install.sh` (otomatis untuk ASUS)
- Sumber package: CachyOS official repos + Chaotic-AUR binary mirror (via pacman, bukan yay/paru)
