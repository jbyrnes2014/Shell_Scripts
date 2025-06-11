#!/bin/bash

IP_ADDRESS="YOUR_IP_ADDRESS_GOES_HERE!"
SCHEDULES_DIR="/home/${IP_ADDRESS}/schedules"
LOG_FILE="/home/${IP_ADDRESS}/schedules/collector.log"
# Function to get the current timestamp in EST
timestamp() {
  TZ='America/New_York' date +"%Y-%m-%d %H:%M:%S %Z" # current time in EST
}

exec &>> "${LOG_FILE}"

# Define the script to run
SCRIPT_TO_RUN="${SCHEDULES_DIR}/just_collect.sh"

# Define the number of times to run the script
NUM_RUNS=100

# Define the interval in seconds (10 minutes = 600 seconds)
INTERVAL=600

# Loop to run the script the specified number of times
for ((i=1; i<=NUM_RUNS; i++)); do
  echo "Running script $i of $NUM_RUNS at $(timestamp)"
  $SCRIPT_TO_RUN
  echo "Script $i completed at $(timestamp)"

  # Wait for the specified interval before running the script again
  if [ $i -lt $NUM_RUNS ]; then
# Sleep set to 10 minutes.
    ${SCHEDULES_DIR}/progTimer.sh 600
  fi
done

echo "All runs completed."
