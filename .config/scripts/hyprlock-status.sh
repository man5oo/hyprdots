#!/bin/bash


# WIFI
# Function to check WiFi connection and print its name
network() {
    if [ -n "$(iwgetid -r)" ]; then
        network_i="  $(iwgetid -r)"

    elif [ -n "$(ip route | grep default | grep en)" ]; then
        network_i="󰈀  $(ip route | grep default | awk '{print $5}')"
    
    elif [ -z "$(iwgetid -r)" ] && [ -z "$(ip route | grep default | grep en)" ]; then
        network_i="󰕑 "
    else
        network_i="error"
    fi
}

# BATTERY
print_batt(){
    batt_p=$(acpi | grep -o '[0-9]*%' | sed s/%//g | sed -n '1p')
    if [ $batt_p -gt 70 ]; then
        batt_i="󱊣 $batt_p%%"
    elif [$batt_p -lt 70 ] && [ $batt_p -gt 40 ]; then
        batt_i="󱊢 $batt_p%%"
    elif [$batt_p -lt 40 ] && [ $batt_p -gt 10] ; then
        batt_i="󱊡 $batt_p%%"
    else
        batt_i="󰂎 $batt_p%"
    fi
}

network
print_batt
printf "$batt_i  $network_i"
