# Core utilities
sudo pacman -S rofi-wayland sddm dunst thunar zsh zsh-autosuggestions zsh-syntax-highlighting stow imagemagick sww

# Per sensori temperatura
sudo pacman -S lm_sensors

# Configura i sensori
sudo sensors-detect  # Rispondi YES a tutto
sensors  # Verifica che funzioni

# Per bluetooth
sudo pacman -S bluez bluez-utils
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# Per audio (se non ce l'hai già)
sudo pacman -S pipewire pipewire-pulse pavucontrol





# Wallpaper management e theming
yay -S wallust swww  # swww per transizioni animate wallpaper
#yay -S python-pywal  # alternativa/supporto a wallust
# Aggiungi wallpaper
mkdir -p ~/wallpapers
cp /path/to/images/* ~/wallpapers/

# Testa lo script
#~/.config/rofi/scripts/wallpaper-selector.sh

# Oppure con keybinding
# SUPER + W


# Utilities extra
sudo pacman -S imagemagick fd ripgrep  # per preview e ricerca wallpaper

mkdir -p ~/dotfiles
cd ~/dotfiles

# Crea le directory per ogni applicazione
mkdir -p hyprland/.config/hypr
mkdir -p waybar/.config/waybar
mkdir -p rofi/.config/rofi
mkdir -p kitty/.config/kitty
mkdir -p zsh/.config/zsh
mkdir -p dunst/.config/dunst
mkdir -p sddm  # configurazione SDDM separata
mkdir -p wallust/.config/wallust
mkdir -p scripts/.local/bin  # script personalizzati
mkdir -p wallpapers  # i tuoi wallpaper


# Backup delle config attuali (se esistono)
cd ~/.config

# Sposta le configurazioni in ~/dotfiles
mv hypr ~/dotfiles/hyprland/.config/
mv waybar ~/dotfiles/waybar/.config/
mv rofi ~/dotfiles/rofi/.config/
mv kitty ~/dotfiles/kitty/.config/


cd ~/dotfiles

# Crea i symlink per tutte le applicazioni
stow hyprland
stow waybar
stow rofi
stow kitty
stow dunst
stow wallust
stow scripts
stow zsh

# Ricarica Hyprland
hyprctl reload


# Cambia shell di default da bash a zsh
chsh -s $(which zsh)

# Installa Oh My Zsh (opzionale ma consigliato)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"



# crea file di conf
touch ~/dotfiles/zsh/.zshrc

---------------------

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"  # o "agnoster", "powerlevel10k"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    history-substring-search
)

source $ZSH/oh-my-zsh.sh

# Autosuggestions config
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666"
bindkey '^[[Z' autosuggest-accept  # Shift+Tab per accettare

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.config/zsh/.zsh_history

# Aliases
alias ls='ls --color=auto'
alias ll='ls -lah'
alias vim='nvim'
alias update='sudo pacman -Syu'

# Path
export PATH="$HOME/.local/bin:$PATH"

--------------------


# logout e login e poi:
# Clona i plugin se non li hai
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting



#FONTS
# Controlla i font installati
fc-list | grep -i "jetbrains\|cascadia\|nerd"
# Lista tutti i font monospaced
fc-list :mono | cut -d: -f2 | sort -u

# Oppure cerca Cascadia
fc-list | grep -i cascadia
# Oppure più specifico
pacman -Qs font | grep -i "nerd\|jetbrains\|cascadia"

# Installa i Nerd Fonts (include JetBrainsMono)
sudo pacman -S ttf-jetbrains-mono-nerd

# Oppure tutto il pacchetto Nerd Fonts
yay -S nerd-fonts-complete  # (molto grande, ~3GB)

# Oppure solo alcuni font Nerd
yay -S nerd-fonts-jetbrains-mono

# Font popolari con icone/glifi
sudo pacman -S ttf-jetbrains-mono-nerd  # Il mio preferito
sudo pacman -S ttf-firacode-nerd
sudo pacman -S ttf-sourcecodepro-nerd
sudo pacman -S ttf-hack-nerd

# Font base di qualità
sudo pacman -S ttf-cascadia-code  # Quello che hai
sudo pacman -S ttf-fira-code
sudo pacman -S ttf-ibm-plex


# Wallust color palette 
touch ~/dotfiles/wallust/.config/wallust/wallust.toml

----------------------

[settings]
# Backend per generare colori
backend = "resized"  # o "full", "wal", "thumb"

# Dove salvare i colori
palette = "dark16"  # o "dark", "light"

# Alpha/transparency
alpha = 95

[templates]
# Template per ogni applicazione
hyprland = { template = "hyprland.conf", target = "~/.config/hypr/colors.conf" }
waybar = { template = "waybar.css", target = "~/.config/waybar/colors.css" }
rofi = { template = "rofi.rasi", target = "~/.config/rofi/colors.rasi" }
kitty = { template = "kitty.conf", target = "~/.config/kitty/colors.conf" }
dunst = { template = "dunstrc", target = "~/.config/dunst/dunstrc" }
gtk = { template = "gtk.css", target = "~/.config/gtk-3.0/gtk.css" }


----------------------

# crea un template per ogni applicazione
touch ~/dotfiles/wallust/.config/wallust/templates/

hyprland.conf:
# Hyprland colors from wallust
$background = rgb({{background | strip}})
$foreground = rgb({{foreground | strip}})
$color0 = rgb({{color0 | strip}})
$color1 = rgb({{color1 | strip}})
$color2 = rgb({{color2 | strip}})
$color3 = rgb({{color3 | strip}})
$color4 = rgb({{color4 | strip}})
$color5 = rgb({{color5 | strip}})
$color6 = rgb({{color6 | strip}})
$color7 = rgb({{color7 | strip}})


waybar.css:
@define-color background #{{background}};
@define-color foreground #{{foreground}};
@define-color color0 #{{color0}};
@define-color color1 #{{color1}};
@define-color color2 #{{color2}};
@define-color color3 #{{color3}};
@define-color color4 #{{color4}};
@define-color color5 #{{color5}};
@define-color color6 #{{color6}};
@define-color color7 #{{color7}};


rofi.rasi:
* {
    bg: #{{background}};
    fg: #{{foreground}};
    primary: #{{color4}};
    secondary: #{{color5}};
    accent: #{{color6}};
}

kitty.conf:
foreground #{{foreground}}
background #{{background}}
color0 #{{color0}}
color1 #{{color1}}
color2 #{{color2}}
color3 #{{color3}}
color4 #{{color4}}
color5 #{{color5}}
color6 #{{color6}}
color7 #{{color7}}
color8 #{{color8}}
color9 #{{color9}}
color10 #{{color10}}
color11 #{{color11}}
color12 #{{color12}}
color13 #{{color13}}
color14 #{{color14}}
color15 #{{color15}}
cursor #{{foreground}}
cursor_text_color #{{background}}

dunstrc:

[global]
    monitor = 0
    follow = mouse
    
    # Geometry
    width = (0, 400)
    height = 300
    origin = top-right
    offset = 10x50
    
    # Style
    padding = 15
    horizontal_padding = 15
    frame_width = 2
    gap_size = 5
    corner_radius = 10
    separator_height = 2
    
    # Text
    font = Cascadia Code 10
    line_height = 0
    format = "<b>%s</b>\n%b"
    alignment = left
    vertical_alignment = center
    show_age_threshold = 60
    word_wrap = yes
    
    # Icons
    icon_position = left
    min_icon_size = 32
    max_icon_size = 64
    icon_path = /usr/share/icons/Papirus-Dark/16x16/status/:/usr/share/icons/Papirus-Dark/16x16/devices/
    
    # Progress bar
    progress_bar = true
    progress_bar_height = 10
    progress_bar_frame_width = 1
    progress_bar_min_width = 150
    progress_bar_max_width = 300
    
    # Interaction
    mouse_left_click = do_action, close_current
    mouse_middle_click = close_all
    mouse_right_click = close_current
    
    # Colors from wallust
    frame_color = "#{{color4}}"
    separator_color = "#{{color6}}"
    
    # Behavior
    timeout = 5
    show_indicators = yes
    
[urgency_low]
    background = "#{{background}}"
    foreground = "#{{foreground}}"
    frame_color = "#{{color4}}"
    timeout = 3
    
[urgency_normal]
    background = "#{{background}}"
    foreground = "#{{foreground}}"
    frame_color = "#{{color4}}"
    timeout = 5
    
[urgency_critical]
    background = "#{{color1}}"
    foreground = "#{{background}}"
    frame_color = "#{{color1}}"
    timeout = 0
    default_icon = dialog-error







# Script per cambiare wallpaper
touch ~/dotfiles/scripts/.local/bin/change-wallpaper:

-----------------------

#!/bin/bash

WALLPAPER="$1"
TRANSITION_TYPE="grow"  # grow, outer, wipe, wave
TRANSITION_POS="center"  # center, top-left, etc.

# Se non viene passato un wallpaper, scegline uno random
if [ -z "$WALLPAPER" ]; then
    WALLPAPER=$(find ~/wallpapers -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n 1)
fi

# Imposta il wallpaper con animazione
swww img "$WALLPAPER" \
    --transition-type "$TRANSITION_TYPE" \
    --transition-pos "$TRANSITION_POS" \
    --transition-duration 2 \
    --transition-fps 60

# Genera la palette con wallust
wallust run "$WALLPAPER"

# Ricarica le applicazioni
pkill waybar && waybar &
dunstify "Wallpaper Changed" "Color palette updated!" -i "$WALLPAPER"

-------------------------

chmod +x ~/dotfiles/scripts/.local/bin/change-wallpaper


# Rofi wallpaper selector preview
touch ~/dotfiles/scripts/.local/bin/rofi-wallpaper

------------------------
#!/bin/bash

WALLPAPER_DIR="$HOME/wallpapers"

# Genera preview thumbnails se non esistono
CACHE_DIR="$HOME/.cache/wallpaper-thumbnails"
mkdir -p "$CACHE_DIR"

# Crea thumbnails
for img in "$WALLPAPER_DIR"/*.{jpg,png}; do
    [ -f "$img" ] || continue
    thumb="$CACHE_DIR/$(basename "$img")"
    if [ ! -f "$thumb" ]; then
        convert "$img" -resize 200x200^ -gravity center -extent 200x200 "$thumb"
    fi
done

# Lista wallpaper con rofi
SELECTED=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) -exec basename {} \; | \
    rofi -dmenu \
    -i \
    -p "Select Wallpaper" \
    -theme-str 'window {width: 800px;} listview {columns: 4; lines: 3;}' \
    -show-icons)

if [ -n "$SELECTED" ]; then
    change-wallpaper "$WALLPAPER_DIR/$SELECTED"
fi

--------------------------

# Hyprland - Keybinding wallpaper selector  ~/dotfiles/hyprland/.config/hypr/hyprland.conf

# Wallpaper selector
bind = SUPER, W, exec, rofi-wallpaper

# Import colors generati da wallust
source = ~/.config/hypr/colors.conf

# Autostart
exec-once = sddm
exec-once = swww-daemon
exec-once = waybar
exec-once = dunst
exec-once = change-wallpaper  # Imposta wallpaper random all'avvio




# Dunstrc

touch dotfiles/dunst/.config/dunst/dunstrc


--------------------------

[global]
    monitor = 0
    follow = mouse
    width = 300
    height = 300
    origin = top-right
    offset = 10x50
    
    padding = 15
    horizontal_padding = 15
    frame_width = 2
    gap_size = 5
    
    font = Cascadia Code 10
    line_height = 0
    
    format = "<b>%s</b>\n%b"
    alignment = left
    show_age_threshold = 60
    
    icon_position = left
    max_icon_size = 64
    
    corner_radius = 10
    timeout = 5
    
[urgency_low]
    timeout = 3
    
[urgency_normal]
    timeout = 5
    
[urgency_critical]
    timeout = 0

---------------------------

# Installa un tema SDDM carino
#yay -S sddm-sugar-candy-git
#check sddm-theme-tokyo-night-git
yay -S sddm-tokyo-night-git

# Configura SDDM
sudo nano /etc/sddm.conf


[Theme]
Current=tokyo-night


# Installa tool per temi GTK
sudo pacman -S nwg-look  # GUI per cambiare temi GTK

# Temi GTK popolari che seguono i colori sistema
yay -S materia-gtk-theme
yay -S papirus-icon-theme


# Per applicare automaticamente i colori di wallust a GTK, aggiungi al template gtk.css:

@define-color theme_bg_color #{{background}};
@define-color theme_fg_color #{{foreground}};
@define-color theme_selected_bg_color #{{color4}};
@define-color theme_selected_fg_color #{{foreground}};


touch ~/.config/gtk-3.0/settings.ini

[Settings]
gtk-theme-name=Materia-dark
gtk-icon-theme-name=Papirus-Dark
gtk-font-name=Cascadia Code 10
gtk-application-prefer-dark-theme=true





# Testa il cambio wallpaper
change-wallpaper ~/wallpapers/your-image.jpg

# Oppure apri il selector
rofi-wallpaper

# O con la keybinding
# SUPER + W




#GITHUB

# Sul sistema attuale
cd ~/dotfiles
git init
git add .
git commit -m "Initial dotfiles setup"

# Crea un repo su GitHub (chiamalo ad es. "dotfiles")
# Poi collegalo:
git remote add origin https://github.com/TUO_USERNAME/dotfiles.git
git branch -M main
git push -u origin main

# Su un altro sistema (o dopo reinstallazione)
cd ~
git clone https://github.com/TUO_USERNAME/dotfiles.git
cd dotfiles
stow hyprland waybar rofi kitty
# Et voilà! Tutto configurato