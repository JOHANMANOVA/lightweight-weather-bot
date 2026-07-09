#!/bin/bash
echo "Cloud Weather Bot initialized."

# Create a minimal response page for the web browser
echo "HTTP/1.1 200 OK" > response.txt
echo "Content-Type: text/plain" >> response.txt
echo "" >> response.txt
echo "Weather Bot is Active!" >> response.txt

# Start an infinite loop to act as a web server on port 8080
while true; do
  # Listen on port 8080. When hit, trigger the alert script!
  cat response.txt | nc -l -p 8080
  
  echo "--- Fetching Weather Data ---"
  WEATHER=$(curl -s "wttr.in/Coimbatore?format=3")
  MESSAGE="🚀 **Cloud DevOps Bot Update:** Current conditions in $WEATHER"
  
  # Push to Discord
  curl -s -H "Content-Type: application/json" \
       -X POST \
       -d "{\"content\": \"$MESSAGE\"}" \
       "https://discord.com/api/webhooks/1524821017732714668/9gfCVFO5Ap9YgZFhVv6F1YuImLJkFzRKUNeGTkmOmFoE-olCIJmg9Az6XdlXAiVSFIN-"
       
  echo "Alert sent successfully!"
done
