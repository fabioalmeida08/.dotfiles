#!/bin/bash
# Este script apenas cospe o texto. Se não houver player, fica vazio.
playerctl --follow metadata --format "{{ artist }} - {{ title }}" 2>/dev/null
