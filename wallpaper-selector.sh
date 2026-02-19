#!/usr/bin/env bash

# creare file ~/dotfiles/rofi/.config/rofi/scripts/wallpaper-selector.sh

# Directory dei wallpaper
WALLPAPER_DIR="$HOME/wallpapers"
CACHE_DIR="$HOME/.cache/rofi-wallpapers"
CURRENT_WALLPAPER="$HOME/.cache/current_wallpaper"

# Crea cache directory se non esiste
mkdir -p "$CACHE_DIR"

# Funzione per generare thumbnails
generate_thumbnails() {
    for wallpaper in "$WALLPAPER_DIR"/*.{jpg,jpeg,png,webp} 2>/dev/null; do
        [ -f "$wallpaper" ] || continue
        
        filename=$(basename "$wallpaper")
        thumbnail="$CACHE_DIR/${filename%.*}.png"
        
        # Genera thumbnail solo se non esiste
        if [ ! -f "$thumbnail" ]; then
            convert "$wallpaper" -resize 200x200^ -gravity center -extent 200x200 "$thumbnail" 2>/dev/null
        fi
    done
}

# Funzione per ottenere il wallpaper corrente
get_current_wallpaper() {
    if [ -f "$CURRENT_WALLPAPER" ]; then
        cat "$CURRENT_WALLPAPER"
    else
        echo ""
    fi
}

# Genera thumbnails
generate_thumbnails

# Wallpaper corrente
current_wp=$(get_current_wallpaper)

# Costruisci lista per rofi con formato: nome\0icon\0path
entries=""
while IFS= read -r -d '' wallpaper; do
    filename=$(basename "$wallpaper")
    thumbnail="$CACHE_DIR/${filename%.*}.png"
    
    # Marca il wallpaper corrente con ✓
    if [ "$wallpaper" = "$current_wp" ]; then
        display_name="✓ $filename"
    else
        display_name="$filename"
    fi
    
    # Formato: display_name\0icon\0wallpaper_path
    entries+="${display_name}\0icon\x1f${thumbnail}\x1f${wallpaper}\n"
    
done < <(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" \) -print0 | sort -z)

# Se non ci sono wallpapers
if [ -z "$entries" ]; then
    dunstify "No Wallpapers" "Add wallpapers to $WALLPAPER_DIR" -u critical
    exit 1
fi

# Mostra rofi con icone
selected=$(echo -en "$entries" | rofi \
    -dmenu \
    -i \
    -p "Wallpaper Gallery" \
    -theme "$HOME/.config/rofi/styles/wallpaper-selector.rasi" \
    -show-icons \
    -markup-rows \
    -selected-row 0)

# Se qualcosa è stato selezionato
if [ -n "$selected" ]; then
    # Estrai il path del wallpaper (terzo campo separato da \x1f)
    # Il formato è: display_name\x1ficon_path\x1fwallpaper_path
    wallpaper_path=$(echo "$entries" | grep -F "$selected" | awk -F'\x1f' '{print $3}')
    
    if [ -f "$wallpaper_path" ]; then
        change-wallpaper "$wallpaper_path"
    fi
fi