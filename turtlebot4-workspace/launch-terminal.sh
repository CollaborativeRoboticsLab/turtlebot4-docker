#!/bin/bash
set -e

# Prefer gnome-terminal via dbus-launch; fallback to xterm
if command -v gnome-terminal >/dev/null 2>&1; then
  if command -v dbus-launch >/dev/null 2>&1; then
    dbus-launch gnome-terminal --wait -- bash -i && exit 0
  else
    gnome-terminal --wait -- bash -i && exit 0
  fi
fi

# Fallback to xterm
exec xterm -fa 'Monospace' -fs 11 -geometry 120x30 -e bash -i
