#!/bin/bash

duration=$1 # Total duration in seconds
message=$2  # Message to display
if [ -z "$duration" ]; then
    echo "Usage: $0 <duration_seconds> <message>"
    exit 1
fi

if ! [[ "$duration" =~ ^[0-9]+$ ]]; then
    echo "Duration must be a number"
    exit 1
fi

if [ -z "$message" ]; then
    message="Wait Progress"
fi

start_time=$(date +%s)
end_time=$((start_time + duration))
bar_length=20 # Length of the progress bar

while [ $(date +%s) -lt $end_time ]; do
    elapsed_time=$(( $(date +%s) - start_time ))
    progress_percent=$((elapsed_time * 100 / duration))
    progress_bars=$((progress_percent * bar_length / 100))
    remaining_bars=$((bar_length - progress_bars))

    # Clear the line and print the progress bar and percentage
    printf "\r${message}: [%s>%s] %d%%" "$(printf '#%.0s' $(seq 1 $progress_bars))" "$(printf ' %.0s' $(seq 1 $remaining_bars))" $progress_percent
    sleep 0.1
done

# Print the final progress bar and percentage
printf "\r${message}: [%s] 100%%\n" "$(printf '#%.0s' $(seq 1 $bar_length))"
