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



# Verifica i sensori disponibili
sensors

# Dovresti vedere qualcosa tipo:
# amdgpu-pci-xxxx
# Adapter: PCI adapter
# vddgfx: ...
# edge: +XX.0°C
# ...

Prendi nota del nome del sensore (es. amdgpu-pci-0400 o simile).



# Trova tutti i sensori hwmon
ls /sys/class/hwmon/

# Per ogni hwmon, controlla il nome
cat /sys/class/hwmon/hwmon*/name

# Trova quello AMD (dovrebbe essere "amdgpu")
find /sys/class/hwmon/ -name "name" -exec grep -l "amdgpu" {} \;

# Verifica i file temperature disponibili
ls /sys/class/hwmon/hwmon*/temp*_input

# Leggi la temperatura
cat /sys/class/hwmon/hwmon0/temp1_input  # Dividi per 1000 per avere °C

Una volta trovato il percorso corretto, aggiorna la configurazione di Waybar:

~/dotfiles/waybar/.config/waybar/config

"temperature": {
    "hwmon-path": "/sys/class/hwmon/hwmonX/temp1_input",  // Sostituisci X
    ...
}


Installa Font Awesome per le icone

sudo pacman -S ttf-font-awesome

# Oppure versione più recente
yay -S ttf-font-awesome-6 	

pkill waybar && waybar &




Troubleshooting temperatura

# Script helper per trovare il sensore giusto
cat > ~/.local/bin/find-temp-sensor << 'EOF'
#!/bin/bash
echo "=== Sensori disponibili ==="
sensors

echo -e "\n=== Percorsi hwmon ==="
for i in /sys/class/hwmon/hwmon*/temp*_input; do
    echo -n "$i: "
    cat "$i" 2>/dev/null | awk '{print $1/1000 "°C"}'
done

echo -e "\n=== Thermal zones ==="
for i in /sys/class/thermal/thermal_zone*/temp; do
    echo -n "$i: "
    cat "$i" 2>/dev/null | awk '{print $1/1000 "°C"}'
done
EOF

chmod +x ~/.local/bin/find-temp-sensor
find-temp-sensor


Usa l'output di questo script per trovare il sensore corretto dell'AMD AI MAX+ 395.





# Test bluetooth
bluetoothctl
> power on
> scan on
> devices  # Vedi dispositivi
> exit

# Test audio
pactl list sinks short  # Speaker
pactl list sources short  # Microfoni