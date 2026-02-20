#!/bin/bash

WINDOWTITLE=$(gsettings get org.gnome.shell.extensions.pop-shell show-title)

if [[ "$WINDOWTITLE" = true ]]
then
  gsettings set org.gnome.shell.extensions.pop-shell show-title false
else
  gsettings set org.gnome.shell.extensions.pop-shell show-title true
fi
