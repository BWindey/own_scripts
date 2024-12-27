#!/bin/bash

spotify-qt &

start_librespot() {
	temp_file="$1"
	librespot \
		--cache "$HOME"/.cache/librespot/ \
		--enable-oauth \
		--enable-volume-normalisation \
		&>"${temp_file}"
	rm temp_file
}

if ! pgrep "librespot"; then
	temp_file="$(mktemp)"
	start_librespot "${temp_file}" &
	sleep 2
	if grep --quiet "OAuth server listening" "$temp_file"; then
		firefox "$(grep "^Browse to: " "$temp_file" | sed "s/^Browse to: *\(https:\/\/[^ ]*\) *$/\1/")"
	fi
fi
