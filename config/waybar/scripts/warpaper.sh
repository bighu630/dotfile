for output in `swww query | awk -F: '{print $1}'`; do
    IMG=$(find $DOTFILE/config/hypr/wallpapers/bg -type f | shuf -n 1)
    echo Display $output "$IMG"
    swww img -o $output -t random "$IMG" --transition-angle 30
done
