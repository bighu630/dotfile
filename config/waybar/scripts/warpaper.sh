random_effect() {
    local options=(left right top bottom wipe wave grow center any outer)
    local choice=${options[RANDOM % ${#options[@]}]}
    echo "$choice"
}

for output in `swww query | awk -F: '{print $1}'`; do
    IMG=$(find $DOTFILE/config/hypr/wallpapers/bg -type f | shuf -n 1)
    echo Display $output "$IMG"
    swww img -o $output -t "$(random_effect)" "$IMG" --transition-angle 10
done
