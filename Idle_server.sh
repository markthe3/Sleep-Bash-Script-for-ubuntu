#!/bin/bash

# Threshold CPU usage below which the server is considered idle
threshold_cpu=5  # Adjust this value as needed (percentage)

# Duration (in seconds) for which the CPU usage must be below the threshold to consider the server idle
duration_idle=600  # 10 minutes (adjust this value as needed)

# Function to check CPU usage and put the server to sleep if idle
function check_and_sleep {
    cpu_usage=$(top -b -n 1 | grep "Cpu(s)" | awk '{print $2 + $4}')
    if (( $(echo "$cpu_usage < $threshold_cpu" | bc -l) )); then
        echo "Server CPU usage is below the threshold. Waiting for $duration_idle seconds..."
        sleep $duration_idle
        # Check CPU usage again after the specified duration
        cpu_usage=$(top -b -n 1 | grep "Cpu(s)" | awk '{print $2 + $4}')
        if (( $(echo "$cpu_usage < $threshold_cpu" | bc -l) )); then
            echo "Server is idle. Putting it to sleep..."
            systemctl suspend
        else
            echo "Server is active. Resuming monitoring..."
        fi
    else
        echo "Server is active. Resuming monitoring..."
    fi
}

# Main loop to continuously monitor the server
while true; do
    check_and_sleep
    # Sleep interval (in seconds) before checking again
    sleep 60
done
