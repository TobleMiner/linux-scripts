for f in *.mp3; do
        artist="$(echo "$f" | \
                sed "s/\s*-.*$//g")"
        song="$(echo "$f" | sed "s/^.*-\s*//g" | \
                sed "s/\.mp3*$//g")"
        printf "%s:\n\tArtist: %s\n\tName: %s\n" "$f" "$artist" "$song"
        id3v2 --artist "$artist" --song "$song" "$f"
        f_vid="$(echo "$f" | sed 's/\.mp3/.mp4/g')"
        if [ -f "$f_vid" ] && [ $(command -v eyeD3 2>/dev/null) ]; then
                printf "\tAdding cover from video\n"
                dur="$(ffprobe -loglevel error -show_streams "$f_vid" | \
                        grep duration | \
                        cut -f2 -d= | \
                        head -n 1 | \
                        sed 's/[,.][0-9]\{1,\}//g')"
                tmp_base="$(mktemp)"
                tmp_cover="$tmp_base"".jpg"
                touch "$tmp_cover"
                ffmpeg -ss $((dur / 2)) -i "$f_vid" -y -t 1 -f image2 "$tmp_cover" 2>/dev/null
                eyeD3 --force-update --add-image "$tmp_cover"":FRONT_COVER:cover" "$f" >/dev/null
                rm "$tmp_cover" "$tmp_base"
        fi
done

