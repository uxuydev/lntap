#!/bin/bash

# Define the cleanup function
cleanup() {
    echo "Running cleanup command..."
    # Add your cleanup command here
    rm /root/lnd-service.pid
    rm /root/tapd-service.pid
}

# Trap signals and call the cleanup function
trap 'cleanup' SIGINT SIGTERM

# Start your main process (e.g., your application)
exec "$@"
