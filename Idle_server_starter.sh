#!/bin/bash
    
# Set the path to your monitoring script
monitoring_script="/path/to/idle_server.sh"

# Function to check if the monitoring script is already running
function check_monitoring_script {
    pgrep -f "$monitoring_script" > /dev/null
    return $?
}

# Check if the monitoring script is already running
check_monitoring_script
if [ $? -eq 0 ]; then
    echo "Monitoring script is already running."
else
    echo "Starting monitoring script in the background..."
    nohup $monitoring_script > /dev/null 2>&1 &
    echo "Monitoring script is running in the background."
fi
