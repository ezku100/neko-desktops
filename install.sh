#!/usr/bin/env bash
# Instalador 1-clic para Neko + Kanji Desktop (Plasma 6)
set -e
cd "$(dirname "$0")"

install_one() {
  local pkg="$1"
  local id="$1"
  # metadata Id es el mismo que la carpeta
  if kpackagetool6 -t Plasma/Applet -s "$id" >/dev/null 2>&1; then
    echo "↻ Actualizando $id..."
    kpackagetool6 -t Plasma/Applet -u "$pkg"
  else
    echo "＋ Instalando $id..."
    kpackagetool6 -t Plasma/Applet -i "$pkg"
  fi
}

install_one com.ezku.nekodesktop
install_one com.ezku.kanjidesktop

echo ""
echo "Listo. Ahora clic derecho en panel/escritorio → Añadir widgets → busca 'Neko Desktop' o 'Kanji Desktop'."
echo "Si no aparecen, reinicia: nohup plasmashell --replace >/tmp/plasmashell.log 2>&1 &"
