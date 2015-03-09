for i in *.mp4; do avconv -i "$i" "$(echo "$i" | sed "s/\.mp4//g").mp3" ; done
