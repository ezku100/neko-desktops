# Neko Desktops

Widgets para cambiar de escritorio en Plasma 6.

- **Neko Desktop**: con iconos, 11 estilos para elegir.
- **Kanji Desktop**: con texto, 6 formatos de números.

## Capturas (Neko Desktop)

![Neko en el panel](screenshots/neko-panel.png)

![Ajustes con los 11 estilos](screenshots/neko-settings.png)

## Capturas (Kanji Desktop)

![Kanji en el panel](screenshots/kanji-panel.png)

![Ajustes con los 6 formatos](screenshots/kanji-settings.png)

## Instalar (súper fácil)

```bash
git clone https://github.com/ezku100/neko-desktops.git
cd neko-desktops
./install.sh
```

Otras formas:

- Desde Plasma: clic derecho en panel/escritorio → Añadir widgets → Obtener nuevos → Instalar desde archivo, selecciona el `.plasmoid` del Release.
- Manual:
```bash
cp -r com.ezku.nekodesktop ~/.local/share/plasma/plasmoids/
cp -r com.ezku.kanjidesktop ~/.local/share/plasma/plasmoids/
nohup plasmashell --replace >/tmp/plasmashell.log 2>&1 &
```

## Créditos

- Base: MikeDevQH (michaelqhdez@gmail.com)
- Fork y estilos Neko: ezku
- Licencia: GPLv3
