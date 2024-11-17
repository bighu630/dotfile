for output in `swww query | awk -F: '{print $1}'`; do
    IMG=$(find ~/dotfile/config/hypr/wallpapers/bg -type f | shuf -n 1)
    echo Display $output "$IMG"
    swww img -o $output -t outer "$IMG"
done
