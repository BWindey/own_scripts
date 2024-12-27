# My collection of scripts
I wrote these scripts when I needed them, and they come in handy every once in
a while, so I decided to store them here on GitHub so I don't loose them.

Maybe you find something interesting.



### mkscript
This was invented by a friend and perfected by me (for me).
This script helps in developing other bash scripts by setting up some
boilerplate for you, especially the `getopts` handling is nice.
It takes in a script-name, creates the file, makes it executable, and opens it
in Neovim.
```sh
$ mkscript -h

mkscript: A script to help with starting bash-scripts.

Usage:
  mkscript [-f <flags>] [-e] <script_name>

Flags:
  -f <flags>: flags in getopts-style string for the new script
  -e:         include exit-status "trap" in script
```


### now
A silly little script that posts the current time (in 24h notation) to your
terminal with that nice 7-segment-display look:
```sh
$ now

 🯲🯳 : 🯵🯲
```


### cpImage
A simple alias for `xclip` to copy images from files to your system clipboard.


### batteryNotify.sh
A script designed to run in a cronjob. In the modern day, people have laptops.
And those have batteries, which drain. As there don't exist any programs which
do this already (there definitely are...), I wrote this little script that sends
a notification when your battery is low on energy.
It uses `notify-send`, which should be independent of your notification-
manager, and checks the battery-status in a virtual file (which you will very
likely need to adapt for your own computer).

I made a cron-job like this:
```sh
$ crontab -e

0,5,10,15,20,25,30,35,40,45,50,55 * * * * DISPLAY=:0 XAUTHORITY=<HOME>/.Xauthority bash <HOME>/.local/bin/own_scripts/battery_notify.sh

```
where you change `<HOME>` for your own absolute path to your "$HOME" folder.
This will run every 5 minutes.


### play
An abstraction above `mpg123` to allow me to easily play music that I have
installed. I really need to change this to use something else though, because
I don't have `mpg123` on my current Linux install.


### wrapper.spotify-qt.sh
A script that I call from my custom `Spotify.desktop` file, so that `librespot`
is correctly started together with `spotify-qt`.


### recordScreen
A wrapper around VLC to easily record my screen with a command. The script
toggles between on/off using a temp-file as flag, and it additionally sets a
"recording status" in my Polybar.

Polybar module:
```ini
[module/recording]
type = custom/script
exec = echo "%{F#FB4934}●%{F-}"
hidden = true
```

> [!WARNING]
> The vlc settings are specifically for my monitor-setup. Play a bit around to
> get this working on your machine. Maybe ask AI to help with that.

The script is a simple toggle, but if you want to start recording, you can pass
an additional argument that will serve as filename.
All video-files are stored in `~/Videos/`.
