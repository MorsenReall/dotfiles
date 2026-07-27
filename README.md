# CachyOS My Dotfiles

Personal dotfiles + installer scripts for **ASUS TUF Gaming A15 FA506ICB** — AMD Renoir + NVIDIA RTX 3050.

**Current:** Hyprland (stable, Lua API) + Noctalia Shell v5

> **Version:** 2.0 | Updated: 2026-07-27

---

## Daftar Isi

- [Dotfiles — Config Saja (Aman)](#dotfiles--config-saja-aman)
- [Installer — Fresh OS](#installer--fresh-os)
- [Hyprland Config](#hyprland-config)
- [Keybindings](#keybindings)
- [Presets](#presets)
- [Gaming](#gaming)
- [Scripts](#scripts)
- [Theme Stack](#theme-stack)
- [Dotfiles Reference](#dotfiles-reference)
- [Maintenance](#maintenance)
- [Notes](#notes)

---

## Dotfiles — Config Saja (Aman)

> **Cuma copy file hypr ke `~/.config/hypr/`** — gak install package, gak perlu sudo, gak ubah system.
> Cocok buat yang udah punya Hyprland + Noctalia, tinggal pake config ini.

### Persyaratan

Yang harus udah terinstall di system:

| Kebutuhan | Contoh Package |
|-----------|---------------|
| Hyprland + Noctalia Shell | `hyprland noctalia` |
| Rofi (preset switcher) | `rofi` |
| Terminal | `foot` |
| Nerd Font | `ttf-jetbrains-mono-nerd`, `otf-comicshanns-nerd` |
| Cursor | `bibata-cursor-theme` (Bibata-Modern-Ice) |
| Icon Theme | `tela-icon-theme` (Tela-nord-dark) |
| GTK Theme | `nordic-theme` |

### Cara Pakai

```bash
git clone https://github.com/tofan79/cachyos-mydotfiles.git
cd cachyos-mydotfiles
chmod +x mydotfiles.sh
./mydotfiles.sh
```

Nanti di-prompt: **Install gaming mode? (y/N)**
- `y` → auto-install **Chaotic-AUR** (kalo belum ada) → jalanin `gaming.sh` (butuh sudo)
- `n` atau Enter → skip, aman 100%

### Yang Di-copy

| Dari | Ke |
|------|----|
| `dotfiles/hypr/` | `~/.config/hypr/` |
| Default preset (animations, decorations, windows) | Langsung teraplikasi setelah `hyprctl reload` |

---

## Installer — Fresh OS

> **Buat yang install Arch/CachyOS dari awal.** Jalanin step by step biar system sama persis.

```bash
git clone https://github.com/tofan79/cachyos-mydotfiles.git
cd cachyos-mydotfiles
chmod +x *.sh
```

| Step | Script | Fungsi |
|------|--------|--------|
| 1 | `./install.sh` | **Core OS** — package dasar, fonts, themes, Zsh + P10k, mise, opencode, Flatpak, dotfiles non-Hyprland |
| 2 | `./hyprland-noctalia.sh` | **Desktop WM** — Hyprland, Noctalia, SDDM, rofi, polkit fix, dotfiles Hyprland |
| 3 | `./apps.sh` | **Aplikasi** — Nautilus, Zen, Neovim, tmux, Yazi, Docker, PHP stack, ASUS tools, bloat removal |
| 4 | `./gaming.sh` | **Gaming** — DeckShift session switch, performance tuning |
| 5 | `sudo ./firewall.sh` | **Firewall** — UFW deny incoming, allow LocalSend |
| 6 | `./fix-audio.sh` (opsional) | **ASUS audio fix** — ALC256 mic/audio, WirePlumber + systemd. Khusus ASUS TUF/ROG. Skip kalo bukan ASUS. |

---

### Step 1: `install.sh` — Core OS

**Package yang diinstall:**

| Kategori | Package |
|----------|---------|
| Dev Tools | `base-devel git curl wget rsync libva-utils cmake meson ninja python python-pip shellcheck openssh flatpak` |
| Display/WM | `foot` |
| CLI | `bat fzf zoxide fastfetch jq tmux ripgrep fd tree unzip zip bc lsof pciutils usbutils hwinfo grim slurp wl-clipboard brightnessctl playerctl eza pamixer wlsunset lm_sensors ddcutil dua-cli` |
| Fonts | `ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-meslo-nerd-font-powerlevel10k noto-fonts noto-fonts-emoji adobe-source-code-pro-fonts otf-comicshanns-nerd ttf-ms-fonts` |
| Theme | `qt6ct qt5ct gtk3 gtk4 libadwaita adwaita-icon-theme papirus-icon-theme nordic-theme bibata-cursor-theme tela-icon-theme` |
| Multimedia | `gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav x264 x265` |
| FS Tools | `exfatprogs ntfs-3g btrfs-progs cifs-utils dosfstools smartmontools logrotate tcpdump` |
| Lain | `gnome-keyring` |

**Yang di-setup:**
- Flatpak + Flathub + OBS Studio + Karere
- Tela icon theme → Tela-nord-dark
- Bibata cursor → Bibata-Modern-Ice
- JetBrainsMono + FiraCode Nerd Font (manual download)
- Oh My Zsh + Powerlevel10k + autosuggestions + syntax-highlighting + completions
- `.zshrc` (backup dulu kalo ada) + `.p10k.zsh`
- `chsh` ke zsh, pacman aliases
- mise, opencode
- Foot sebagai default terminal
- Fontconfig: ComicShannsMono Nerd Font monospace
- Git config: aliases, pull.rebase, push.autoSetupRemote, defaultBranch=main
- Sensors auto-detect
- `gnome-keyring-daemon.service` enable

**Yang di-copy ke `~/.config/`:**

| Dotfiles | Isi |
|----------|-----|
| `foot/` | Font, alpha, grapheme-shaping |
| `fontconfig/` | Font fallbacks |
| `git/` | Git config |
| `gtk-3.0/` + `gtk-4.0/` | Nordic theme, Tela icons, Bibata cursor |
| `qt5ct/` + `qt6ct/` | Fusion style + Noctalia palette |
| `btop/` | Noctalia theme |
| `cava/` | Noctalia theme |
| `yazi/` | Noctalia flavor |
| `zed/` | Noctalia Dark Transparent theme |
| `zsh/` | .zshrc + .p10k.zsh |
| `easyeffects/` | Audio EQ presets |
| `environment.d/` | Steam/gamescope env vars |
| `noctalia/` | settings.toml + sounds → `~/.local/state/noctalia/` |
| `Wallpapers/` | → `~/Pictures/Wallpapers/` |
| `docker-db/` | → `~/Projects/docker-db/` |

> **Catatan:** `fix-audio.sh` otomatis jalan untuk ASUS laptop. Bisa jalan standalone: `./fix-audio.sh [--force|--uninstall]`

---

### Step 2: `hyprland-noctalia.sh` — Desktop WM

**Package:** `hyprland rofi cliphist xdg-desktop-portal-hyprland hyprpicker nvidia-utils lib32-nvidia-utils sddm switcheroo-control noctalia gnome-keyring`

**Yang dilakukan:**
- SDDM enable sebagai display manager
- `switcheroo-control` enable (NVIDIA dGPU switching)
- Session file: `/usr/share/wayland-sessions/hyprland.desktop` → "Hyprland (Noctalia)"
- Polkit fix: `/etc/polkit-1/rules.d/49-networkmanager.rules`
- Noctalia state: `settings.toml` path fix (`/home/mindset` → `$HOME`) + copy sounds

**Yang di-copy ke `~/.config/`:**

| Dotfiles | Isi |
|----------|-----|
| `hypr/` | Full Hyprland Lua config + presets + scripts |
| `rofi/` | Noctalia theme |
| `xdg-desktop-portal/` | default=hyprland |
| `fastfetch/` | Custom Omarchy layout |
| `MangoHud/` | Gaming overlay config |
| `nvim/` | AstroNvim v6 config |

---

### Step 3: `apps.sh` — Aplikasi

**Package:**

| Kategori | Package |
|----------|---------|
| Desktop | `nautilus gvfs gvfs-afc gvfs-gphoto2 gvfs-smb libmtp nautilus-open-any-terminal yazi neovim btop mpv mpv-mpris imv evince gnome-disk-utility gnome-calculator easyeffects` |
| Qt | `qt6-declarative qt6-svg qt6-multimedia qt6-multimedia-ffmpeg qt6-5compat pavucontrol` |
| Utilitas | `tesseract tesseract-data-eng imagemagick xdg-desktop-portal-gtk xdg-utils xdg-user-dirs python-gobject wtype wdisplays cava satty tldr gum lazydocker gpu-screen-recorder dua-cli bat eza fd` |
| Jaringan | `ncdu httpie bind whois traceroute mtr socat nmap github-cli strace python-pipx` |
| Apps | `telegram-desktop localsend zen-browser-bin zed font-manager protonplus ab-download-manager faugus-launcher android-studio intellij-idea-community-edition zoom` |
| Gaming | `gamemode lib32-gamemode` |
| Dev | `ffmpegthumbnailer nautilus-image-converter lazygit nodejs bottom gdu docker docker-buildx docker-compose` |
| PHP | `php php-gd php-intl php-pgsql php-sqlite php-fpm php-tidy php-imagick php-redis php-memcached php-mongodb php-apcu php-igbinary php-xsl composer` |

**Yang dilakukan:**
- ASUS hardware auto-detect → install `asusctl` + `rog-control-center`
- Desktop file fix: btop, nvim, yazi → jalan di Foot
- Nautilus → Open in Terminal (foot)
- Docker enable + user ke docker group
- Desktop entries + icons untuk lazydocker + dua
- tmux config (C-Space prefix, vi mode)
- PHP: deploy `dotfiles/php/php.ini` + `conf.d/*` ke `/etc/php/`
- Laravel installer via Composer
- Hapus bloat CachyOS: micro, alacritty, meld, cachyos-micro-settings
- Sembunyiin desktop entries gak kepake

---

### Step 4: `gaming.sh` — DeckShift

**Gaming session switch** — ala Steam Deck. Bisa ganti-ganti antara desktop Hyprland sama session gaming (gamescope + Steam Big Picture).

> **Kompatibel dengan:** SDDM, GDM, LightDM, greetd, Ly — auto-detect display manager.

**Yang diinstall:**
- `gamescope-session-git` (dari chaotic-aur binary repo)
- Script session ke `/usr/local/bin/`
- Autologin config sesuai display manager yang terdeteksi
- Performance: udev rules, memlock limits, pipewire latency, shader cache, NVIDIA env

**Cara pake:**
| Tombol | Fungsi |
|--------|--------|
| `SUPER + SHIFT + G` | Switch ke gaming session |
| `SUPER + SHIFT + R` | Balik ke desktop |

> `gamescope-session-steam-git` di-skip (duplikat entry di SDDM).

---

### Step 5: `firewall.sh` — Firewall

```bash
ufw default deny incoming
ufw default allow outgoing
ufw allow 53317/udp    # LocalSend
ufw allow 53317/tcp    # LocalSend
ufw --force enable
systemctl enable ufw
```

---

## Hyprland Config

Entry point: `~/.config/hypr/hyprland.lua`

```lua
package.path = os.getenv("HOME") .. "/.config/hypr/?.lua;" .. package.path

require("monitor")
require("env")
require("noctalia").apply_theme()
dofile(os.getenv("HOME") .. "/.config/hypr/colors.lua")
dofile(os.getenv("HOME") .. "/.config/hypr/windows/glass.lua")
dofile(os.getenv("HOME") .. "/.config/hypr/decorations/rounding-all-blur.lua")
dofile(os.getenv("HOME") .. "/.config/hypr/animations/wipe-meta.lua")
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
Generated by Noctalia. Uses `local` variables. `colors.lua` re-applies via text parsing.

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
| XWayland | `no_focus = true` (empty drag fix) |

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

Semua pake `SUPER` (Windows key). Lihat langsung di layar: `SUPER + SHIFT + K`

### Core
| Key | Fungsi |
|-----|--------|
| `SUPER + Q` | Tutup window |
| `SUPER + CTRL + R` | Reload Hyprland |
| `SUPER + Escape` | Session menu (Noctalia) |
| `SUPER + SHIFT + L` | Lock screen |
| `SUPER + /` | Btop (system monitor) |

### Noctalia Shell
| Key | Fungsi |
|-----|--------|
| `SUPER + Space` | App launcher |
| `SUPER + ALT + Space` | Control center |
| `SUPER + CTRL + Space` | Settings |
| `SUPER + CTRL + W` | Wallpaper picker |
| `SUPER + CTRL + C` | Caffeine toggle (keep awake) |
| `SUPER + CTRL + .` | Clear notifications |
| `SUPER + CTRL + ,` | Clear clipboard |
| `SUPER + CTRL + /` | Wallhaven wallpaper browser |
| `SUPER + CTRL + \` | Video wallpaper picker |
| `SUPER + CTRL + P` | Color picker |

### Focus & Swap
| Key | Fungsi |
|-----|--------|
| `SUPER + arrows` | Pindah fokus |
| `SUPER + SHIFT + arrows` | Tukar posisi window |
| `SUPER + CTRL + up/down` | Workspace sebelumnya/selanjutnya |

### Window States
| Key | Fungsi |
|-----|--------|
| `SUPER + F` | Fullscreen toggle |
| `SUPER + SHIFT + F` | Maximize toggle |
| `SUPER + SHIFT + T` | Float toggle |
| `SUPER + ALT + T` | Float + pin |

### Scratchpad
| Key | Fungsi |
|-----|--------|
| `SUPER + S` | Toggle special workspace |
| `SUPER + SHIFT + S` | Kirim window ke special |
| `SUPER + SHIFT + CTRL + S` | Keluarkan dari special |

### Layout
| Key | Fungsi |
|-----|--------|
| `SUPER + CTRL + L` | Ganti layout (dwindle/scrolling/master/monocle) |
| `SUPER + CTRL + K` | Swap split |
| `SUPER + CTRL + J` | Toggle split |

### Groups
| Key | Fungsi |
|-----|--------|
| `SUPER + SHIFT + G` | Toggle group |
| `SUPER + CTRL + G` | Keluar dari group |
| `SUPER + CTRL + [` / `]` | Masuk group kiri/kanan |
| `SUPER + ALT + [` / `]` | Masuk group atas/bawah |
| `SUPER + CTRL + 1-5` | Pilih group index |
| `SUPER + Tab` / `SHIFT + Tab` | Group berikutnya/sebelumnya |

### Presets (Rofi)
| Key | Fungsi |
|-----|--------|
| `SUPER + CTRL + A` | Ganti animasi |
| `SUPER + CTRL + D` | Ganti dekorasi |
| `SUPER + CTRL + S` | Ganti window style |
| `SUPER + SHIFT + A` | Animasi on/off |

### App Launchers
| Key | Aplikasi |
|-----|----------|
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
| Key | Fungsi |
|-----|--------|
| `SUPER + 1-9` | Pindah workspace |
| `SUPER + SHIFT + 1-9` | Pindahin window ke workspace |
| `SUPER + scroll` | Workspace sebelumnya/selanjutnya |

### Media Keys
Volume, brightness, playback lewat Noctalia. `XF86Sleep` → lock & suspend.

### Multi-Monitor
| Key | Fungsi |
|-----|--------|
| `SUPER + CTRL + ALT + arrows` | Fokus monitor |
| `+ SHIFT` + di atas | Pindahin window ke monitor |

### Resize & Move
| Key | Fungsi |
|-----|--------|
| `CTRL + ALT + arrows` | Resize window |
| `CTRL + SHIFT + arrows` | Gerakin floating window |

### Mouse
| Tombol | Fungsi |
|--------|--------|
| `SUPER + left click` | Drag window |
| `SUPER + right click` | Resize window |
| `Middle click` | Maximize toggle |

### Lain
| Key | Fungsi |
|-----|--------|
| `ALT + Tab` | Cycle tiled windows |

### Persiapan Apps untuk Keybind

Beberapa keybind panggil aplikasi tertentu. Kalo aplikasi belum terinstall, keybind gak bakal jalan:

| Keybind | Aplikasi | Package (Arch) | Install lewat |
|---------|----------|---------------|---------------|
| `SUPER + Enter` | Foot (terminal) | `foot` | `install.sh` step 1 |
| `SUPER + E` | Nautilus (file manager) | `nautilus` | `apps.sh` step 3 |
| `SUPER + B` | Zen Browser | `zen-browser-bin` | `apps.sh` step 3 |
| `SUPER + N` | Zed Editor | `zed` | `apps.sh` step 3 |
| `SUPER + L` | LocalSend | `localsend` | `apps.sh` step 3 |
| `SUPER + T` | Telegram | `telegram-desktop` | `apps.sh` step 3 |
| `SUPER + W` | Karere | Flatpak dari Flathub | `install.sh` step 1 |
| `SUPER + D` | Vesktop (Discord) | `vesktop` | `apps.sh` step 3 |
| `SUPER + G` | Steam | `steam` | `apps.sh` step 3 |
| `SUPER + A` | AionUI | `/opt/AionUi/AionUi` | `apps.sh` step 3 |
| `SUPER + U` | AB Download Manager | `ab-download-manager` | `apps.sh` step 3 |
| `SUPER + P` | ProtonPlus | `protonplus` | `apps.sh` step 3 |
| `SUPER + ALT + G` | Gaming mode switch | `gamescope-session-git` | `gaming.sh` step 4 |
| `SUPER + SHIFT + K` | Keybind viewer | (built-in script) | dotfiles aja |
| `SUPER + /` | Btop (system monitor) | `btop` | `install.sh` step 1 |

> Core keybind (focus, swap, window states, groups, layout, workspace, mouse) pake Hyprland built-in — gak butuh apps tambahan.
> Gaming mode auto-detect display manager (SDDM/GDM/LightDM/greetd/Ly) — gak wajib SDDM lagi.

---

## Presets

Ganti-ganti gaya window tanpa reload config — pake Rofi (`SUPER + CTRL + A/D/S`).

### Animations (`~/.config/hypr/animations/*.lua`)
**16 preset** — `SUPER + CTRL + A`

Default: **wipe-meta** — borderangle wipe, speed 20.

Tersedia:
`animations-classic` • `animations-dynamic` • `animations-end4` • `animations-fast` • `animations-high` • `animations-moving` • `animations-smooth` • `default` • `disabled` • `metamorphosis` • `moving-meta` • `slide` • `smooth-meta` • `standard` • `wipe` • `wipe-meta`

### Decorations (`~/.config/hypr/decorations/*.lua`)
**10 preset** — `SUPER + CTRL + D`

Default: **rounding-all-blur** — rounding 10px, opacity 0.9/0.7, blur 2/2, shadow range 30.

Tersedia:
`blur` • `default` • `gamemode` • `no-blur` • `no-rounding` • `no-rounding-more-blur` • `rounding` • `rounding-all-blur` • `rounding-all-blur-no-shadows` • `rounding-more-blur`

### Windows (`~/.config/hypr/windows/*.lua`)
**14 preset** — `SUPER + CTRL + S`

Default: **glass** — gaps_in 5, gaps_out 10, border 2px, gradient active border.

Tersedia:
`border-1..4` • `border-1..4-reverse` • `default` • `gamemode` • `glass` • `no-border` • `no-border-more-gaps` • `transparent`

---

## Gaming

### game-launch.sh

Launch option Steam: `~/.config/hypr/scripts/game-launch.sh %command%`

```bash
export NVPRESENT_ENABLE_SMOOTH_MOTION=1    # NVIDIA frame gen
export DXVK_NVAPI_VKREFLEX=1               # NVIDIA Reflex
export PROTON_ENABLE_NGX_UPDATER=1         # DLSS auto-update
exec switcherooctl launch -- gamemoderun mangohud "$@"
```

### MangoHud (`~/.config/MangoHud/MangoHud.conf`)
```
legacy_layout=false
position=top-center
gpu_stats gpu_temp gpu_name
cpu_stats cpu_temp
ram fps frame_timing
font_size=15
background_alpha=0
hud_no_margin
height=120
```

---

## Scripts

Script pembantu di `~/.config/hypr/scripts/`:

| Script | Panggilan | Fungsi |
|--------|-----------|--------|
| `keybindings.sh` | `SUPER + SHIFT + K` | Lihat semua keybind (rofi) |
| `switch-animations.sh` | `SUPER + CTRL + A` | Ganti animasi |
| `switch-decorations.sh` | `SUPER + CTRL + D` | Ganti dekorasi |
| `switch-windows.sh` | `SUPER + CTRL + S` | Ganti window style |
| `toggle-animations.sh` | `SUPER + SHIFT + A` | Animasi on/off |
| `text-extractor.sh` | `SUPER + ALT + A` | OCR area → clipboard |
| `game-launch.sh` | Steam launch option | NVIDIA optimasi + gamemode + MangoHud |
| `lock-and-suspend.sh` | `XF86Sleep` | Lock + suspend |

---

## Theme Stack

| Layer | Theme |
|-------|-------|
| Icons | Tela-nord-dark |
| Cursor | Bibata-Modern-Ice 24px |
| GTK | Nordic |
| Qt5/Qt6 | Fusion + Noctalia palette |
| Terminal | Foot + ComicShannsMono Nerd Font 10pt |
| Shell | Zsh + Powerlevel10k (rainbow) |
| Rofi | Noctalia, centered, rounded 24px, JetBrainsMono Nerd Font |

---

## Dotfiles Reference

Daftar lengkap folder dotfiles, di-copy oleh script mana, dan isinya:

| Folder | Script | Isi |
|--------|--------|-----|
| `hypr/` | `mydotfiles.sh` / `hyprland-noctalia.sh` | Full Hyprland Lua config + presets + scripts |
| `rofi/` | `hyprland-noctalia.sh` | Noctalia theme |
| `xdg-desktop-portal/` | `hyprland-noctalia.sh` | default=hyprland |
| `fastfetch/` | `hyprland-noctalia.sh` | Custom Omarchy layout |
| `MangoHud/` | `hyprland-noctalia.sh` | Gaming overlay |
| `nvim/` | `hyprland-noctalia.sh` + `apps.sh` | AstroNvim v6 |
| `foot/` | `install.sh` | Font, alpha, grapheme-shaping |
| `fontconfig/` | `install.sh` | Font fallbacks |
| `git/` | `install.sh` | Git config |
| `imv/` | `install.sh` | Image viewer keybinds |
| `gtk-3.0/` + `gtk-4.0/` | `install.sh` | Nordic, Tela, Bibata |
| `qt5ct/` + `qt6ct/` | `install.sh` | Fusion + Noctalia palette |
| `btop/` | `install.sh` | Noctalia system monitor theme |
| `cava/` | `install.sh` | Noctalia audio visualizer |
| `yazi/` | `install.sh` | Noctalia file manager flavor |
| `zed/` | `install.sh` | Noctalia Dark Transparent editor theme |
| `zsh/` | `install.sh` | .zshrc + .p10k.zsh |
| `noctalia/` | `install.sh` + `hyprland-noctalia.sh` | settings.toml + sounds |
| `easyeffects/` | `install.sh` | Audio EQ presets |
| `environment.d/` | `install.sh` | Steam/gamescope env vars |
| `clean/` | `install.sh` | System cleanup script |
| `php/` | `apps.sh` | php.ini + conf.d (ke /etc/php/) |
| `gaming-mode/` | `gaming.sh` | DeckShift session configs |
| `tmux/` | `apps.sh` | C-Space prefix, vi mode |
| `Wallpapers/` | `install.sh` | Background images |
| `docker-db/` | `install.sh` | MariaDB + PostgreSQL dev DB |

---

## Maintenance

```bash
~/.config/clean/clean.sh
```

Bersihin: pacman cache, orphans, Flatpak, Go/pip/npm/Cargo cache, mise, temp, journal (>3d), trash, browser cache, shader cache, Qt/GTK cache, Zed cache, zsh history, thumbnails.

---

## Notes

- **Runtime config:** `hyprctl eval "hl.config({...})"` — cara bener di Hyprland Lua API
- **Noctalia colors:** Noctalia regenerates `noctalia.lua` — `colors.lua` re-applies via text parsing
- **Session name:** "Hyprland (Noctalia)" di display manager manapun
- **Audio fix:** `fix-audio.sh` — portable, jalan standalone. Otomatis untuk ASUS.
- **Package sources:** CachyOS official repos + Chaotic-AUR binary mirror via pacman
