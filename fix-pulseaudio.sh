#!/bin/bash

# Delete auto-generated configuration files
[ -f ~/.pulse ] && rm -r ~/.pulse 
[ -f ~/.pulse-cookie ] && rm ~/.pulse-cookie
[ -f ~/.config/pulse ] && rm -r ~/.config/pulse

# Get PID of pulseaudio
pid="$(pgrep ^pulseaudio$)"

# Kill and restart pulseaudio
kill "$pid" && pulseaudio --start

