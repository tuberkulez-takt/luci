#!/usr/bin/env bash
# Install Luci
# Project root = theme root (Id = luci)
set -e
SRC="$(cd "$(dirname "$0")" && pwd)"
DST="$HOME/.local/share/plasma/look-and-feel/luci"

if [ ! -f "$SRC/contents/splash/images/luci_sleep.gif" ] || [ ! -f "$SRC/contents/splash/images/luci_hight.gif" ] || [ ! -f "$SRC/contents/splash/images/luci_drink.gif" ]; then
  echo "ERROR: GIFs not found. Make sure these files exist:"
  echo "  $SRC/contents/splash/images/luci_sleep.gif"
  echo "  $SRC/contents/splash/images/luci_hight.gif"
  echo "  $SRC/contents/splash/images/luci_drink.gif"
  exit 1
fi

if [ ! -f "$SRC/metadata.json" ]; then
  echo "ERROR: missing $SRC/metadata.json"
  exit 1
fi

mkdir -p "$HOME/.local/share/plasma/look-and-feel"
rm -rf "$DST"
# Copy the theme
mkdir -p "$DST"
cp "$SRC/metadata.json" "$DST/"
cp -r "$SRC/contents" "$DST/"
[ -f "$SRC/README.md" ] && cp "$SRC/README.md" "$DST/"
echo "Installed to $DST"
echo "Now: System Settings → Appearance → Splash Screen → Luci → Apply"
