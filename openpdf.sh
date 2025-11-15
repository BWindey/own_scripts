#!/bin/bash

file=$(fd --type f --extension pdf | rofi -dmenu -i -p "PDF")
[ -z "$file" ] && exit 1

zathura "$file"
