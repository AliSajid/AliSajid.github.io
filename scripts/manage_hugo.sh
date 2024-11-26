#!/usr/bin/env bash

# Script to manage the Hugo development server
# Usage:
#   ./manage_hugo.sh start    - Start the Hugo server
#   ./manage_hugo.sh stop     - Stop the Hugo server
#   ./manage_hugo.sh status   - Check if the Hugo server is running

set -euo pipefail

# Define file paths for process and log management
PID_FILE="hugo-server.pid"                             # File to store the process ID (PID)
LOG_FILE="logs/hugo_server-$(date +%Y%m%d-%H%M%S).log" # File to store logs

# Function to check if the Hugo server is running
is_hugo_running() {
  # Check if the PID file exists
  if [[ -f "$PID_FILE" ]]; then
    # Read the PID from the file
    local pid
    pid=$(cat "$PID_FILE")

    # Check if the process with the PID is active
    if ps -p "$pid" >/dev/null 2>&1; then
      return 0 # Hugo is running
    else
      rm -f "$PID_FILE" # Remove stale PID file if process isn't running
    fi
  fi
  return 1 # Hugo is not running
}

# Function to start the Hugo server
start_hugo() {
  # Prevent multiple instances of the Hugo server
  if is_hugo_running; then
    echo "Hugo server is already running. Visit https://localhost:1313 to view the site."
    return 0
  fi

  # Cleanup potential lock files from previous runs
  rm -f .hugo_build.lock

  echo "Starting Hugo server..."
  # Run Hugo server in the background and redirect logs
  hugo server -D --minify --gc --cleanDestinationDir \
    --printMemoryUsage --renderStaticToDisk \
    --templateMetrics --enableGitInfo --disableFastRender \
    >"$LOG_FILE" 2>&1 &

  # Save the background process ID (PID) to the PID file
  echo $! >"$PID_FILE"
  echo "Hugo server started. Visit https://localhost:1313 to view the site."
}

# Function to stop the Hugo server
stop_hugo() {
  # Check if the server is running
  if is_hugo_running; then
    # Retrieve the PID and stop the process
    local pid
    pid=$(cat "$PID_FILE")
    echo "Stopping Hugo server..."
    kill "$pid" && rm -f "$PID_FILE"
    echo "Hugo server stopped."
  else
    echo "No Hugo server is running."
  fi
}

# Function to display the status of the Hugo server
status_hugo() {
  if is_hugo_running; then
    echo "Hugo server is running. Visit https://localhost:1313 to view the site."
  else
    echo "Hugo server is not running."
  fi
}

# Function to display usage instructions
usage() {
  echo "Usage: $0 {start|stop|status}"
  echo
  echo "Commands:"
  echo "  start    - Start the Hugo development server"
  echo "  stop     - Stop the running Hugo server"
  echo "  status   - Check if the Hugo server is running"
  echo
  echo "Examples:"
  echo "  Start the server: $0 start"
  echo "  Stop the server:  $0 stop"
  echo "  Check status:     $0 status"
  exit 1
}

# Command-line argument parsing
if [[ $# -ne 1 ]]; then
  usage
fi

# Dispatch commands based on the first argument
case $1 in
start)
  start_hugo
  ;;
stop)
  stop_hugo
  ;;
status)
  status_hugo
  ;;
*)
  usage
  ;;
esac
