#!/bin/bash

# Check if a domain is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <domain>"
  exit 1
fi

# Set the domain from the argument
DOMAIN=$1

# Fetch the page content
page_content=$(curl -s "https://www.shodan.io/search/facet?query=ssl.cert.subject.cn:$DOMAIN&facet=ip")

# Extract everything between <strong> and </strong> tags
results=$(echo "$page_content" | grep -oP '(?<=<strong>).*?(?=</strong>)')

# Display the output
echo "$results"
