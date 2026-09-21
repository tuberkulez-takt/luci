#!/usr/bin/env bash
# Установка Luci в KDE Plasma 6
# Корень проекта = корень темы (Id = luci)
set -e
SRC="$(cd "$(dirname "$0")" && pwd)"
DST="$HOME/.local/share/plasma/look-and-feel/luci"

if [ ! -f "$SRC/contents/splash/images/luci_sleep.gif" ] || [ ! -f "$SRC/contents/splash/images/luci_hight.gif" ] || [ ! -f "$SRC/contents/splash/images/luci_drink.gif" ]; then
  echo "ОШИБКА: не найдены гифки. Проверь что в папке есть:"
  echo "  $SRC/contents/splash/images/luci_sleep.gif"
  echo "  $SRC/contents/splash/images/luci_hight.gif"
  echo "  $SRC/contents/splash/images/luci_drink.gif"
  exit 1
fi

if [ ! -f "$SRC/metadata.json" ]; then
  echo "ОШИБКА: нет $SRC/metadata.json"
  exit 1
fi

mkdir -p "$HOME/.local/share/plasma/look-and-feel"
rm -rf "$DST"
# Копируем тему: корень проекта -> папка luci (исключая .git и служебное)
mkdir -p "$DST"
cp "$SRC/metadata.json" "$DST/"
cp -r "$SRC/contents" "$DST/"
[ -f "$SRC/README.md" ] && cp "$SRC/README.md" "$DST/"
echo "Установлено в $DST"
echo "Теперь: Параметры системы → Оформление → Заставка → Luci → Применить"
