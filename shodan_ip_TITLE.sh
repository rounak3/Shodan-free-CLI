#!/bin/bash

# Function to fetch and display results for a given IP
fetch_shodan_data() {
  local ip=$1
  # Fetch the Shodan page for the IP and extract content between <strong> tags
  result=$(curl -s "https://www.shodan.io/search/facet?query=$ip&facet=http.title" \
           | grep -oP '(?<=<strong>).*?(?=</strong>)')

  # Only display output if there is data
  if [ -n "$result" ]; then
    echo "Testing $ip:"
    echo "$result"
    echo "---------------------"
  fi
}

# Check if the argument is a file or a single IP
if [ -f "$1" ]; then
  # Loop through each IP in the file
  while IFS= read -r ip; do
    fetch_shodan_data "$ip"
  done < "$1"
else
  # Treat the argument as a single IP
  fetch_shodan_data "$1"
fi
