# Luci — своя заставка для KDE Plasma 6

При каждой загрузке **случайно показывается одна из 3 гифок Luci**.
Гифки проигрываются **целиком через AnimatedImage**, резать на кадры НЕ нужно.
Светлый фон выбран специально, т.к. персонаж **чёрный**.

## Структура (корень проекта = корень темы, Id = luci)

```
luci/  (эта папка)
├── metadata.json              # Id = luci = имя папки проекта
├── install.sh
└── contents/
    ├── splash/
    │   ├── Splash.qml         # разметка: фон + случайный AnimatedImage
    │   └── images/
    │       ├── luci_sleep.gif
    │       ├── luci_hight.gif
    │       └── luci_drink.gif
    └── previews/
        └── splash.png         # превью 400x250 для настроек
```

Случайный выбор в `Splash.qml`:
```qml
property var gifList: ["images/luci_sleep.gif", "images/luci_hight.gif", "images/luci_drink.gif"]
property string randomGif: gifList[Math.floor(Math.random() * gifList.length)]
source: content.randomGif
```

## Установка

```bash
# 1. Установить тему в KDE
./install.sh
# или вручную: cp -r . ~/.local/share/plasma/look-and-feel/luci
# (папка проекта целиком копируется как тема luci)

# 2. Обновить список (или выйти/войти)
kquitapp6 plasmashell && kstart plasmashell

# 3. Открыть: Параметры системы → Оформление → Заставка → выбрать Luci → Применить → Тест
```

## Настройки под себя

В `contents/splash/Splash.qml`:
- `color: "#e8e8e8"` — фон. Для чёрного персонажа НЕ ставь `"#000"`.
- `property int sizeAnim: 600` — размер гифки.
- Блок `Text { "Загрузка..." }` — можно удалить если не нужен.
