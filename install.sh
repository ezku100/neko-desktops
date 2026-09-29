#!/usr/bin/env bash
# Instalador 1-clic para Neko + Kanji Desktop (Plasma 6)
set -e
cd "$(dirname "$0")"

install_one() {
  local pkg="$1"
  if kpackagetool6 -t Plasma/Applet -u "$pkg"; then
    echo "↻ $pkg actualizado."
  else
    echo "＋ Instalando $pkg..."
    kpackagetool6 -t Plasma/Applet -i "$pkg"
  fi
}

install_one com.ezku.nekodesktop
install_one com.ezku.kanjidesktop

echo ""
echo "Listo. Ahora clic derecho en panel/escritorio → Añadir widgets → busca 'Neko Desktop' o 'Kanji Desktop'."
echo "Si no aparecen, reinicia: nohup plasmashell --replace >/tmp/plasmashell.log 2>&1 &"
