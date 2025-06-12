# Identity Source Collector

This script is designed to collect data from a single identity source repeatedly, running 100 times.

## Prerequisites

- Python 3.x
- Linux environment
- Necessary permissions to run scripts and access the identity source

## Configuration

1. **Identity Source ID**:
   - Open `ident_collect2.py`.
   - Change line 18 to your identity source ID. Currently, it is set to `4`:
     ```python
     "/api/dcs/identitySources/4/schedules"
     ```

2. **IP Address**:
   - Replace `YOUR_IP_ADDRESS_GOES_HERE!` with your actual IP address in the following scripts:
     - `run_script_100_times.sh`
     - `just_collect`

3. **IAC Secret and Bootstrap Password**:
   - Adjust the IAC secret and bootstrap password as per your configuration.

4. **Paths**:
   - Update the paths in the run script to match your directory structure. For example:
     ```bash
     IP_ADDRESS="YOUR_IP_ADDRESS_GOES_HERE!"
     SCHEDULES_DIR="/home/${IP_ADDRESS}/schedules"
     LOG_FILE="/home/${IP_ADDRESS}/schedules/collector.log"
     ```

## Usage

1. Ensure all three scripts (`ident_collect2.py`, `run_script_100_times.sh`, `just_collect`) are in the same directory.
2. Make the shell scripts executable:
   ```bash
   chmod +x run_script_100_times.sh just_collect

   ```
3. Run the main script:
   ```bash
  ./run_script_100_times.sh    

   ```
4. The script will run for 100 iterations, and the output will be saved to `collector.log`.

Monitoring
To monitor the progress, you can tail the collector.log file:

tail -f /home/YOUR_IP_ADDRESS_GOES_HERE/schedules/collector.log 

Additional Notes
The proGramTimer can be adjusted to change the rest period between script executions. It is currently set to 600 seconds (10 minutes).
Ensure that the necessary permissions and configurations are in place for the scripts to run successfully.
