<p align="center">
  <a href="README.md">🇬🇧 English</a>
</p>

<h1 align="center">
  🖥️ CachyOS My Dotfiles
</h1>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue" alt="MIT"></a>
  <img src="https://img.shields.io/badge/ASUS-TUF%20A15%20FA506ICB-orange" alt="ASUS TUF">
  <img src="https://img.shields.io/badge/WM-Hyprland-ff69b4" alt="Hyprland">
  <img src="https://img.shields.io/badge/Shell-Noctalia%20v5-purple" alt="Noctalia">
  <img src="https://img.shields.io/badge/OS-CachyOS-cyan" alt="CachyOS">
  <img src="https://img.shields.io/badge/GPU-NVIDIA%20RTX%203050-brightgreen" alt="NVIDIA">
</p>

<p align="center">
  <b>Hyprland + Noctalia Shell v5</b> — AMD Renoir · NVIDIA RTX 3050 · Wayland
</p>

---

## 📸 Screenshots

<p align="center">
  <img src="assets/screenshots/desktop.png?v=2" width="800" alt="Desktop">
</p>

<p align="center">
  <img src="assets/screenshots/rofi.png?v=2" width="400" alt="Rofi Launcher">
  <img src="assets/screenshots/presets.png?v=2" width="400" alt="Rofi Presets">
  <br>
  <img src="assets/screenshots/btop.png?v=2" width="400" alt="Btop System Monitor">
  <img src="assets/screenshots/launcher.png?v=2" width="400" alt="App Launcher">
</p>

<p align="center">
  <sup>▶️ <i>Video demo menyusul di YouTube</i></sup>
</p>

---

## ✨ Highlights

| | |
|---|---|
| 🎨 **16 preset animasi** | Ganti dengan `SUPER + CTRL + A` |
| 🪟 **14 window + 10 dekorasi preset** | Pake Rofi — tanpa reload |
| 🎮 **Mode gaming** | DeckShift — toggle ala Steam Deck |
| 🔄 **DM-agnostic** | SDDM · GDM · LightDM · greetd · Ly |
| 🧹 **Bersihin 1 perintah** | `clean.sh` — cache, orphans, temp |

---

## 📋 Daftar Isi

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
- [Lisensi](#lisensi)

---

## 📁 Dotfiles — Config Saja (Aman)

> **Cuma copy file hypr ke `~/.config/hypr/`** — gak install package, gak perlu sudo, gak ubah system.
> Cocok buat yang udah punya Hyprland + Noctalia.

### Persyaratan

| Kebutuhan | Package |
|-----------|---------|
| Hyprland + Noctalia | `hyprland noctalia` |
| Rofi (preset switcher) | `rofi` |
| Terminal | `foot` |
| Nerd Font | `ttf-jetbrains-mono-nerd` |
| Cursor | `bibata-cursor-theme` (Bibata-Modern-Ice) |
| Icons | `tela-icon-theme` (Tela-nord-dark) |
| GTK | `nordic-theme` |

### Cara Pakai

```bash
git clone https://github.com/tofan79/cachyos-mydotfiles.git
cd cachyos-mydotfiles
chmod +x mydotfiles.sh
./mydotfiles.sh
```

**Install gaming mode? (y/N)**
- `y` → auto-install **Chaotic-AUR** (kalo belum ada) → jalanin `gaming.sh` (sudo)
- `n` / Enter → skip, aman

### Yang Di-copy

| Dari | Ke |
|------|----|
| `dotfiles/hypr/` | `~/.config/hypr/` |
| Default preset → `hyprctl reload` | Langsung teraplikasi |

---

## 💿 Installer — Fresh OS

> Buat yang install Arch/CachyOS dari awal. Jalanin step by step.

```bash
git clone https://github.com/tofan79/cachyos-mydotfiles.git
cd cachyos-mydotfiles
chmod +x *.sh
```

| Step | Script | Fungsi |
|------|--------|--------|
| 1 | `./install.sh` | **Core OS** — package, fonts, Zsh + P10k, mise, opencode, Flatpak, dotfiles non-Hyprland |
| 2 | `./hyprland-noctalia.sh` | **Desktop WM** — Hyprland, Noctalia, SDDM, rofi, polkit fix, dotfiles Hyprland |
| 3 | `./apps.sh` | **Aplikasi** — Nautilus, Zen, Neovim, tmux, Docker, PHP, ASUS tools, hapus bloat |
| 4 | `./gaming.sh` | **Gaming** — DeckShift session switch, tuning performa |
| 5 | `sudo ./firewall.sh` | **Firewall** — UFW deny incoming, allow LocalSend |
| 6 | `./fix-audio.sh` (opsional) | **ASUS audio fix** — ALC256 mic/audio. Khusus ASUS TUF/ROG. |

<details>
<summary><b>Detail step</b></summary>

### Step 1: `install.sh`

**Package:** `base-devel git curl wget rsync cmake meson python python-pip flatpack foot bat fzf zoxide fastfetch jq tmux ripgrep fd tree unzip zip bc lsof grim slurp wl-clipboard brightnessctl playerctl eza pamixer wlsunset lm_sensors ...`

**Setup:** Flatpak + Flathub · Ikon Tela-nord-dark · Kursor Bibata-Modern-Ice · JetBrainsMono + FiraCode Nerd Font · Oh My Zsh + P10k · mise · opencode · Foot default terminal · Fontconfig · Git aliases · Sensors · `gnome-keyring-daemon`

**Di-copy ke `~/.config/`:** `foot/` · `fontconfig/` · `git/` · `gtk-3.0/` · `gtk-4.0/` · `qt5ct/` · `qt6ct/` · `btop/` · `cava/` · `yazi/` · `zed/` · `zsh/` · `easyeffects/` · `environment.d/` · `noctalia/` · `Wallpapers/` · `docker-db/`

### Step 2: `hyprland-noctalia.sh`

**Package:** `hyprland rofi cliphist xdg-desktop-portal-hyprland hyprpicker nvidia-utils sddm switcheroo-control noctalia gnome-keyring`

**Ngapain:** SDDM enable · `switcheroo-control` · Session → "Hyprland (Noctalia)" · Polkit fix · Noctalia state fix

**Di-copy:** `hypr/` · `rofi/` · `xdg-desktop-portal/` · `fastfetch/` · `MangoHud/` · `nvim/`

### Step 3: `apps.sh`

**Package:** `nautilus yazi neovim btop mpv imv evince easyeffects tesseract imagemagick cava satty gum lazydocker telegram-desktop localsend zen-browser-bin zed protonplus ab-download-manager android-studio docker php ...`

**Ngapain:** ASUS auto-detect → `asusctl` + `rog-control-center` · Docker enable · tmux config · PHP deploy · Hapus bloat CachyOS · Sembunyiin desktop entries

### Step 4: `gaming.sh`

**Ngapain:** `gamescope-session-git` + script session + autologin (auto-detect DM) + tuning performa

**Kompatibel:** SDDM · GDM · LightDM · greetd · Ly

### Step 5: `firewall.sh`

```bash
ufw default deny incoming && ufw default allow outgoing
ufw allow 53317/udp && ufw allow 53317/tcp   # LocalSend
ufw --force enable && systemctl enable ufw
```
</details>

---

## ⚙️ Hyprland Config

**Entry:** `~/.config/hypr/hyprland.lua`

```lua
require("monitor")                  -- eDP-1 1920x1080@144
require("env")                      -- XDG, QT, cursor, NVIDIA
require("noctalia").apply_theme()
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

### Module Utama

| Module | Fungsi |
|--------|--------|
| `monitor.lua` | `1920x1080@144`, VRR, scale 1 |
| `env.lua` | Qt6ct, kursor Bibata, NVIDIA offload |
| `layouts.lua` | Dwindle (default), preserve_split, persistent 1-9 |
| `rules.lua` | Steam floating, Zen/Zoom idle inhibit, XWayland fix |
| `gestures.lua` | 3-finger workspace, 4-finger fullscreen |
| `startup.lua` | xdg-desktop-portal, cliphist, Noctalia |

---

## ⌨️ Keybindings

Semua pake `SUPER` (Windows key). Lihat di layar: `SUPER + SHIFT + K`

| Kategori | Tombol | Fungsi |
|----------|--------|--------|
| **Core** | `SUPER + Q` | Tutup window |
| | `SUPER + CTRL + R` | Reload Hyprland |
| | `SUPER + Escape` | Session menu (Noctalia) |
| | `SUPER + SHIFT + L` | Lock screen |
| | `SUPER + /` | Btop monitor sistem |
| **Shell** | `SUPER + Space` | App launcher |
| | `SUPER + ALT + Space` | Control center |
| | `SUPER + CTRL + Space` | Settings |
| | `SUPER + CTRL + W` | Wallpaper picker |
| | `SUPER + CTRL + C` | Caffeine toggle |
| | `SUPER + CTRL + /` | Wallhaven browser |
| | `SUPER + CTRL + P` | Color picker |
| **Focus** | `SUPER + arrows` | Pindah fokus |
| | `SUPER + SHIFT + arrows` | Tukar window |
| | `SUPER + CTRL + up/down` | Workspace sebelumnya/selanjutnya |
| **Window** | `SUPER + F` | Fullscreen |
| | `SUPER + SHIFT + F` | Maximize |
| | `SUPER + SHIFT + T` | Float toggle |
| | `SUPER + ALT + T` | Float + pin |
| **Scratchpad** | `SUPER + S` | Toggle special |
| | `SUPER + SHIFT + S` | Kirim ke special |
| **Layout** | `SUPER + CTRL + L` | Ganti layout |
| | `SUPER + CTRL + K` | Swap split |
| | `SUPER + CTRL + J` | Toggle split |
| **Groups** | `SUPER + SHIFT + G` | Toggle group |
| | `SUPER + Tab` / `SHIFT + Tab` | Group berikutnya/sebelumnya |
| **Presets** | `SUPER + CTRL + A` | Ganti animasi |
| | `SUPER + CTRL + D` | Ganti dekorasi |
| | `SUPER + CTRL + S` | Ganti window |
| | `SUPER + SHIFT + A` | Animasi on/off |
| **Apps** | `SUPER + Enter` | Foot terminal |
| | `SUPER + E` | Nautilus |
| | `SUPER + B` | Zen browser |
| | `SUPER + N` | Zed editor |
| | `SUPER + G` | Steam |
| | `SUPER + L` | LocalSend |
| | `SUPER + T` | Telegram |
| | `SUPER + D` | Vesktop (Discord) |
| | `SUPER + ALT + G` | Gaming mode switch |
| **Workspace** | `SUPER + 1-9` | Pindah workspace |
| | `SUPER + SHIFT + 1-9` | Pindahin window |
| **Mouse** | `SUPER + left click** | Drag window |
| | `SUPER + right click` | Resize window |
| **Media** | `XF86Sleep` | Lock + suspend |

> Beberapa keybind butuh aplikasi tertentu (Foot, Nautilus, Zen, dll.) — install lewat `apps.sh`.

---

## 🎨 Presets

Ganti gaya window tanpa reload — pake Rofi.

### Animasi
`SUPER + CTRL + A` — 16 preset

| Default | Lainnya |
|---------|---------|
| **wipe-meta** | classic · dynamic · end4 · fast · high · moving · smooth · default · disabled · metamorphosis · slide · standard · wipe · moving-meta · smooth-meta |

### Dekorasi
`SUPER + CTRL + D` — 10 preset

| Default | Lainnya |
|---------|---------|
| **rounding-all-blur** (10px, opacity 0.9/0.7, blur 2/2) | blur · default · gamemode · no-blur · no-rounding · no-rounding-more-blur · rounding · rounding-all-blur-no-shadows · rounding-more-blur |

### Window
`SUPER + CTRL + S` — 14 preset

| Default | Lainnya |
|---------|---------|
| **glass** (gaps 5/10, border 2px, gradient) | border-1..4 · border-1..4-reverse · default · gamemode · no-border · no-border-more-gaps · transparent |

---

## 🎮 Gaming

### game-launch.sh
Launch option Steam `~/.config/hypr/scripts/game-launch.sh %command%`

```bash
export NVPRESENT_ENABLE_SMOOTH_MOTION=1    # NVIDIA frame gen
export DXVK_NVAPI_VKREFLEX=1               # NVIDIA Reflex
export PROTON_ENABLE_NGX_UPDATER=1         # DLSS auto-update
exec switcherooctl launch -- gamemoderun mangohud "$@"
```

### MangoHud
```
legacy_layout=false  position=top-center  font_size=15
background_alpha=0   hud_no_margin        height=120
gpu_stats gpu_temp gpu_name  cpu_stats cpu_temp  ram fps frame_timing
```

---

## 📜 Scripts

| Script | Panggilan | Fungsi |
|--------|-----------|--------|
| `keybindings.sh` | `SUPER + SHIFT + K` | Lihat semua keybind |
| `switch-animations.sh` | `SUPER + CTRL + A` | Ganti animasi |
| `switch-decorations.sh` | `SUPER + CTRL + D` | Ganti dekorasi |
| `switch-windows.sh` | `SUPER + CTRL + S` | Ganti window |
| `toggle-animations.sh` | `SUPER + SHIFT + A` | Animasi on/off |
| `text-extractor.sh` | `SUPER + ALT + A` | OCR → clipboard |
| `game-launch.sh` | Steam option | NVIDIA + gamemode + MangoHud |
| `lock-and-suspend.sh` | `XF86Sleep` | Lock + suspend |

---

## 🎯 Theme Stack

| Layer | Theme |
|-------|-------|
| Icons | Tela-nord-dark |
| Cursor | Bibata-Modern-Ice 24px |
| GTK | Nordic |
| Qt5/Qt6 | Fusion + Noctalia palette |
| Terminal | Foot + ComicShannsMono Nerd Font 10pt |
| Shell | Zsh + Powerlevel10k (rainbow) |
| Rofi | Noctalia · centered · rounded 24px |

---

## 📦 Dotfiles Reference

| Folder | Script | Isi |
|--------|--------|-----|
| `hypr/` | `mydotfiles.sh` / `hyprland-noctalia.sh` | Full Lua config + presets + scripts |
| `rofi/` | `hyprland-noctalia.sh` | Noctalia theme |
| `xdg-desktop-portal/` | `hyprland-noctalia.sh` | default=hyprland |
| `fastfetch/` | `hyprland-noctalia.sh` | Custom Omarchy layout |
| `MangoHud/` | `hyprland-noctalia.sh` | Gaming overlay |
| `nvim/` | `hyprland-noctalia.sh` + `apps.sh` | AstroNvim v6 |
| `foot/` | `install.sh` | Font, alpha, grapheme-shaping |
| `fontconfig/` | `install.sh` | Font fallbacks |
| `git/` | `install.sh` | Git config |
| `gtk-3.0/` + `gtk-4.0/` | `install.sh` | Nordic · Tela · Bibata |
| `qt5ct/` + `qt6ct/` | `install.sh` | Fusion + Noctalia palette |
| `btop/` | `install.sh` | Noctalia theme |
| `cava/` | `install.sh` | Audio visualizer theme |
| `yazi/` | `install.sh` | Noctalia flavor |
| `zed/` | `install.sh` | Noctalia Dark Transparent |
| `noctalia/` | `install.sh` + `hyprland-noctalia.sh` | settings.toml + sounds |
| `easyeffects/` | `install.sh` | Audio EQ presets |
| `environment.d/` | `install.sh` | Steam/gamescope env vars |
| `gaming-mode/` | `gaming.sh` | DeckShift session configs |
| `php/` | `apps.sh` | php.ini + conf.d |
| `tmux/` | `apps.sh` | C-Space prefix, vi mode |
| `clean/` | `install.sh` | System cleanup script |
| `Wallpapers/` | `install.sh` | Background images |

---

## 🧼 Maintenance

```bash
~/.config/clean/clean.sh
```

Bersihin: pacman cache · orphans · Flatpak · Go/pip/npm/Cargo cache · mise · temp · journal (>3d) · trash · browser cache · shader cache · Qt/GTK cache · Zed cache · zsh history · thumbnails

---

## 📝 Notes

- **Runtime config:** `hyprctl eval "hl.config({...})"` — cara bener di Hyprland Lua API
- **Noctalia colors:** Noctalia regenerates `noctalia.lua` — `colors.lua` re-applies via text parsing
- **Session name:** "Hyprland (Noctalia)" di display manager manapun
- **Audio fix:** `fix-audio.sh` — portable, standalone. Otomatis untuk ASUS.
- **Package sources:** CachyOS official repos + Chaotic-AUR binary mirror

---

## 🙏 Credits

| Project | Sumber |
|---------|--------|
| Animation presets (16 preset) | [ML4W](https://github.com/mylinuxforwork/dotfiles) |
| DeckShift gaming session | [github.com/28allday/deckshift](https://github.com/28allday/deckshift) |
| Noctalia Shell | [github.com/noctalia-dev/noctalia](https://github.com/noctalia-dev/noctalia) |
| Hyprland | [hyprland.org](https://hyprland.org) |

---

## 📄 Lisensi

[MIT](LICENSE) © 2026 tofan79
