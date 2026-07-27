<p align="center">
  <a href="README.id.md">🇮🇩 Bahasa Indonesia</a>
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
  <img src="assets/screenshots/desktop.png" width="800" alt="Desktop">
</p>

<p align="center">
  <img src="assets/screenshots/rofi.png" width="400" alt="Rofi Launcher">
  <img src="assets/screenshots/presets.png" width="400" alt="Rofi Presets">
  <br>
  <img src="assets/screenshots/btop.png" width="400" alt="Btop System Monitor">
  <img src="assets/screenshots/gaming.png" width="400" alt="Gaming Mode">
</p>

<p align="center">
  <sup>▶️ <i>Video demo coming soon on YouTube</i></sup>
</p>

---

## ✨ Highlights

| | |
|---|---|
| 🎨 **16 animation presets** | Switch with `SUPER + CTRL + A` |
| 🪟 **14 window + 10 decoration presets** | Rofi switcher — no reload |
| 🎮 **Gaming mode** | DeckShift — Steam Deck toggle |
| 🔄 **DM-agnostic** | SDDM · GDM · LightDM · greetd · Ly |
| 🧹 **One-command cleanup** | `clean.sh` — cache, orphans, temp |

---

## 📋 Table of Contents

- [Dotfiles — Config Only (Safe)](#dotfiles--config-only-safe)
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
- [License](#license)

---

## 📁 Dotfiles — Config Only (Safe)

> **Copies hypr files to `~/.config/hypr/`** — no sudo, no system changes.
> For users who already have Hyprland + Noctalia.

### Prerequisites

| Requirement | Package |
|---|---|
| Hyprland + Noctalia | `hyprland noctalia` |
| Rofi (preset switcher) | `rofi` |
| Terminal | `foot` |
| Nerd Font | `ttf-jetbrains-mono-nerd` |
| Cursor | `bibata-cursor-theme` (Bibata-Modern-Ice) |
| Icons | `tela-icon-theme` (Tela-nord-dark) |
| GTK | `nordic-theme` |

### Usage

```bash
git clone https://github.com/tofan79/cachyos-mydotfiles.git
cd cachyos-mydotfiles
chmod +x mydotfiles.sh
./mydotfiles.sh
```

**Install gaming mode? (y/N)**
- `y` → auto-installs **Chaotic-AUR** (if missing) → runs `gaming.sh` (sudo)
- `n` / Enter → skip, safe

### What Gets Copied

| From | To |
|---|---|
| `dotfiles/hypr/` | `~/.config/hypr/` |
| Default preset → `hyprctl reload` | Applied immediately |

---

## 💿 Installer — Fresh OS

> For fresh Arch/CachyOS installs. Run step by step.

```bash
git clone https://github.com/tofan79/cachyos-mydotfiles.git
cd cachyos-mydotfiles
chmod +x *.sh
```

| Step | Script | What It Does |
|------|--------|-------------|
| 1 | `./install.sh` | **Core OS** — packages, fonts, Zsh + P10k, mise, opencode, Flatpak, non-Hyprland dotfiles |
| 2 | `./hyprland-noctalia.sh` | **Desktop WM** — Hyprland, Noctalia, SDDM, rofi, polkit fix, Hyprland dotfiles |
| 3 | `./apps.sh` | **Applications** — Nautilus, Zen, Neovim, tmux, Docker, PHP, ASUS tools, bloat removal |
| 4 | `./gaming.sh` | **Gaming** — DeckShift session switch, performance tuning |
| 5 | `sudo ./firewall.sh` | **Firewall** — UFW deny incoming, allow LocalSend |
| 6 | `./fix-audio.sh` (optional) | **ASUS audio fix** — ALC256 mic/audio. ASUS TUF/ROG only. |

<details>
<summary><b>Step details</b></summary>

### Step 1: `install.sh`

**Packages:** `base-devel git curl wget rsync cmake meson python python-pip flatpack foot bat fzf zoxide fastfetch jq tmux ripgrep fd tree unzip zip bc lsof grim slurp wl-clipboard brightnessctl playerctl eza pamixer wlsunset lm_sensors ...`

**Setup:** Flatpak + Flathub · Tela-nord-dark icons · Bibata-Modern-Ice cursor · JetBrainsMono + FiraCode Nerd Font · Oh My Zsh + P10k · mise · opencode · Foot default term · Fontconfig · Git aliases · Sensors · `gnome-keyring-daemon`

**Copied to `~/.config/`:** `foot/` · `fontconfig/` · `git/` · `gtk-3.0/` · `gtk-4.0/` · `qt5ct/` · `qt6ct/` · `btop/` · `cava/` · `yazi/` · `zed/` · `zsh/` · `easyeffects/` · `environment.d/` · `noctalia/` · `Wallpapers/` · `docker-db/`

### Step 2: `hyprland-noctalia.sh`

**Packages:** `hyprland rofi cliphist xdg-desktop-portal-hyprland hyprpicker nvidia-utils sddm switcheroo-control noctalia gnome-keyring`

**Does:** SDDM enable · `switcheroo-control` · Session → "Hyprland (Noctalia)" · Polkit fix · Noctalia state fix

**Copied:** `hypr/` · `rofi/` · `xdg-desktop-portal/` · `fastfetch/` · `MangoHud/` · `nvim/`

### Step 3: `apps.sh`

**Packages:** `nautilus yazi neovim btop mpv imv evince easyeffects tesseract imagemagick cava satty gum lazydocker telegram-desktop localsend zen-browser-bin zed protonplus ab-download-manager android-studio docker php ...`

**Does:** ASUS auto-detect → `asusctl` + `rog-control-center` · Docker enable · tmux config · PHP deploy · Remove CachyOS bloat · Hide unused desktop entries

### Step 4: `gaming.sh`

**Does:** `gamescope-session-git` + session scripts + autologin (auto-detect DM) + performance tuning

**Compatible with:** SDDM · GDM · LightDM · greetd · Ly

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

### Key Modules

| Module | What |
|--------|------|
| `monitor.lua` | `1920x1080@144`, VRR, scale 1 |
| `env.lua` | Qt6ct, Bibata cursor, NVIDIA offload |
| `layouts.lua` | Dwindle (default), preserve_split, persistent 1-9 |
| `rules.lua` | Steam floating, Zen/Zoom idle inhibit, XWayland fix |
| `gestures.lua` | 3-finger workspace, 4-finger fullscreen |
| `startup.lua` | xdg-desktop-portal, cliphist, Noctalia |

---

## ⌨️ Keybindings

All use `SUPER` (Windows key). View on screen: `SUPER + SHIFT + K`

| Category | Key | Action |
|----------|-----|--------|
| **Core** | `SUPER + Q` | Close window |
| | `SUPER + CTRL + R` | Reload Hyprland |
| | `SUPER + Escape` | Session menu (Noctalia) |
| | `SUPER + SHIFT + L` | Lock screen |
| | `SUPER + /` | Btop system monitor |
| **Shell** | `SUPER + Space` | App launcher |
| | `SUPER + ALT + Space` | Control center |
| | `SUPER + CTRL + Space` | Settings |
| | `SUPER + CTRL + W` | Wallpaper picker |
| | `SUPER + CTRL + C` | Caffeine toggle |
| | `SUPER + CTRL + /` | Wallhaven browser |
| | `SUPER + CTRL + P` | Color picker |
| **Focus** | `SUPER + arrows` | Move focus |
| | `SUPER + SHIFT + arrows` | Swap windows |
| | `SUPER + CTRL + up/down` | Prev/next workspace |
| **Window** | `SUPER + F` | Fullscreen |
| | `SUPER + SHIFT + F` | Maximize |
| | `SUPER + SHIFT + T` | Float toggle |
| | `SUPER + ALT + T` | Float + pin |
| **Scratchpad** | `SUPER + S` | Toggle special |
| | `SUPER + SHIFT + S` | Send to special |
| **Layout** | `SUPER + CTRL + L` | Cycle layout |
| | `SUPER + CTRL + K` | Swap split |
| | `SUPER + CTRL + J` | Toggle split |
| **Groups** | `SUPER + SHIFT + G` | Toggle group |
| | `SUPER + Tab` / `SHIFT + Tab` | Next/prev group |
| **Presets** | `SUPER + CTRL + A` | Switch animations |
| | `SUPER + CTRL + D` | Switch decorations |
| | `SUPER + CTRL + S` | Switch windows |
| | `SUPER + SHIFT + A` | Animations on/off |
| **Apps** | `SUPER + Enter` | Foot terminal |
| | `SUPER + E` | Nautilus |
| | `SUPER + B` | Zen browser |
| | `SUPER + N` | Zed editor |
| | `SUPER + G` | Steam |
| | `SUPER + L` | LocalSend |
| | `SUPER + T` | Telegram |
| | `SUPER + D` | Vesktop (Discord) |
| | `SUPER + ALT + G` | Gaming mode switch |
| **Workspace** | `SUPER + 1-9` | Switch workspace |
| | `SUPER + SHIFT + 1-9` | Move to workspace |
| **Mouse** | `SUPER + left click` | Drag window |
| | `SUPER + right click` | Resize window |
| **Media** | `XF86Sleep` | Lock + suspend |

> Some keybinds require specific apps (Foot, Nautilus, Zen, etc.) — install via installer scripts.

---

## 🎨 Presets

Switch window styles without reloading — via Rofi.

### Animations
`SUPER + CTRL + A` — 16 presets

| Default | Others |
|---------|--------|
| **wipe-meta** | classic · dynamic · end4 · fast · high · moving · smooth · default · disabled · metamorphosis · slide · standard · wipe · moving-meta · smooth-meta |

### Decorations
`SUPER + CTRL + D` — 10 presets

| Default | Others |
|---------|--------|
| **rounding-all-blur** (10px, opacity 0.9/0.7, blur 2/2) | blur · default · gamemode · no-blur · no-rounding · no-rounding-more-blur · rounding · rounding-all-blur-no-shadows · rounding-more-blur |

### Windows
`SUPER + CTRL + S` — 14 presets

| Default | Others |
|---------|--------|
| **glass** (gaps 5/10, border 2px, gradient) | border-1..4 · border-1..4-reverse · default · gamemode · no-border · no-border-more-gaps · transparent |

---

## 🎮 Gaming

### game-launch.sh
Steam launch option `~/.config/hypr/scripts/game-launch.sh %command%`

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

| Script | Binding | Function |
|--------|---------|----------|
| `keybindings.sh` | `SUPER + SHIFT + K` | View all keybinds |
| `switch-animations.sh` | `SUPER + CTRL + A` | Animation presets |
| `switch-decorations.sh` | `SUPER + CTRL + D` | Decoration presets |
| `switch-windows.sh` | `SUPER + CTRL + S` | Window presets |
| `toggle-animations.sh` | `SUPER + SHIFT + A` | Animations on/off |
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

| Folder | Script | Contents |
|--------|--------|----------|
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

Cleans: pacman cache · orphans · Flatpak · Go/pip/npm/Cargo cache · mise · temp · journal (>3d) · trash · browser cache · shader cache · Qt/GTK cache · Zed cache · zsh history · thumbnails

---

## 📝 Notes

- **Runtime config:** `hyprctl eval "hl.config({...})"` — correct way in Hyprland Lua API
- **Noctalia colors:** Noctalia regenerates `noctalia.lua` — `colors.lua` re-applies via text parsing
- **Session name:** "Hyprland (Noctalia)" in any display manager
- **Audio fix:** `fix-audio.sh` — standalone, portable. Auto for ASUS.
- **Package sources:** CachyOS official repos + Chaotic-AUR binary mirror

---

## 🙏 Credits

| Project | Source |
|---------|--------|
| Animation presets (16 presets) | [ML4W](https://github.com/mylinuxforwork/dotfiles) |
| DeckShift gaming session | [github.com/28allday/deckshift](https://github.com/28allday/deckshift) |
| Noctalia Shell | [github.com/noctalia-dev/noctalia](https://github.com/noctalia-dev/noctalia) |
| Hyprland | [hyprland.org](https://hyprland.org) |

---

## 📄 License

[MIT](LICENSE) © 2026 tofan79
