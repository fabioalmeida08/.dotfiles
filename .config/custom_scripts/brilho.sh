#!/bin/bash
# Pegue o brilho atual (só o número e o %)
valor=$(brightnessctl | grep -oP '\(\K[0-9]+(?=%\))')

# Envia a notificação via notify-send
notify-send -h int:value:"$valor" -h string:x-dunst-stack-tag:brightness "Brilho" "${valor}%"
