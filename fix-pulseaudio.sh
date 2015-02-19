#!/bin/bash

# Delete auto-generated configuration files
[ -e ~/.pulse ] && rm -r ~/.pulse 
[ -e ~/.pulse-cookie ] && rm ~/.pulse-cookie
[ -e ~/.config/pulse ] && rm -r ~/.config/pulse

# Get PID of pulseaudio
pid="$(pgrep ^pulseaudio$)"

# Kill and restart pulseaudio if it was started
kill "$pid" && pulseaudio --start