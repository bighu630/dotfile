for output in `swww query | awk -F: '{print $1}'`; do
    IMG=$(shuf -n1 -e `cat $HOME/.config/hypr/wallpapers/bg.list`)
    echo Display $output "$IMG"
    swww img -o $output -t outer "$IMG"
done
