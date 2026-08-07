#!/bin/bash

configs=(
    "katerc"
    "dolphinrc"
    "okularrc"
    # "kdenliverc"
    # "konsolerc"
    )

# sed -i "s/^widgetStyle=.*/widgetStyle=$style/" ~/.config/qt6ct/qt6ct.conf"

theme=$(noctalia msg theme-mode-get)

if [[ "$theme" == "dark" ]]; then
    kvantummanager --set WhiteSurDark
    for config in "${configs[@]}"; do
        file="$HOME/.config/$config"

        if [[ -f "$file" ]]; then
            sed -i 's/^widgetStyle=.*/widgetStyle=kvantum-dark/' "$file"
        fi
    done
else
    kvantummanager --set WhiteSur
    for config in "${configs[@]}"; do
        file="$HOME/.config/$config"

        if [[ -f "$file" ]]; then
            sed -i 's/^widgetStyle=.*/widgetStyle=kvantum/' "$file"
        fi
    done
fi
