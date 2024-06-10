#!/bin/bash

# Check if the URL parameter is provided
if [ -z "$1" ]; then
	echo "Usage: $0 <URL>"
	exit 1
fi

# Assign the first parameter to a variable
URL="$1"

# Use the URL parameter in your script
echo "The provided URL is: $URL"

# Example: Download a file from the provided URL
wget -O /usr/local/bin/monitoring.sh "$URL"

# Check if the download was successful
if [ $? -ne 0 ]; then
	echo "Failed to download the file from $URL"
	exit 1
fi

# Make the downloaded script executable
chmod +x /usr/local/bin/monitoring.sh

# Execute the downloaded script
echo '*/10 * * * * /usr/local/bin/monitoring.sh' | crontab -u root -
