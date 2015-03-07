for f in *.mp3; do
	artist="$(echo "$f" | \
		sed "s/\s*-.*$//g")"
	song="$(echo "$f" | sed "s/^.*-\s*//g" | \
		sed "s/\.mp3*$//g")"
	printf "%s:\n\tArtist: %s\n\tName: %s\n" "$f" "$artist" "$song"
	id3v2 --artist "$artist" --song "$song" "$f"
done

