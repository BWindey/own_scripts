#!/bin/bash

# Run this script in a cronjob
# 0,5,10,15,20,25,30,35,40,45,50,55 * * * * DISPLAY=:0 XAUTHORITY=/home/bram/.Xauthority bash /home/bram/.local/bin/own_scripts/battery_notify.sh

# Battery notification
battery_notify() {
	battery_status="$(cat "/sys/class/power_supply/BAT0/status")"

	if [[ "$battery_status" != "Discharging" ]]; then
		return 0
	fi

	battery_level="$(cat "/sys/class/power_supply/BAT0/capacity")"
	if (( battery_level <= 1 )); then
		notify-send --app-name=Battery --urgency=critical --wait \
			"CRITICAL" "Laptop will die in 3, 2, 1, ..."
		sleep 4
		battery_status="$(cat "/sys/class/power_supply/BAT0/status")"

		if [[ "$battery_status" == "Charging" ]]; then
			notify-send --app-name=Battery --urgency=low \
				"Achievement unlocked: living on the edge" \
				"Plug your laptop in on 1% or less battery-capacity"
		fi
	elif (( battery_level <= 15 )); then
		notify-send --app-name=Battery --urgency=critical \
			"Battery low" "${battery_level}% remaining. Time to charge!"
	fi
}

battery_notify
