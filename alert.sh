#!/bin/bash
echo "=== Cloud Weather Bot Online & Ready ==="

# Pre-create the web response page so it's ready to serve
echo -e "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nSuccess" > response.txt

# Start an infinite loop so Render NEVER restarts the container
while true; do
  echo "Listening for the 7:00 AM cron-job ping..."
  
  # This stops the script and waits until cron-job.org hits port 8080
  cat response.txt | nc -l -p 8080
  
  echo "Ping received! Sending the daily update..."
  
  # Fetch data and send to Discord ONLY when the ping happens
  WEATHER=$(curl -s "wttr.in/Coimbatore?format=3")
  MESSAGE="🚀 **Cloud DevOps Bot Update:** Current conditions in $WEATHER"
  
  curl -s -H "Content-Type: application/json" \
       -X POST \
       -d "{\"content\": \"$MESSAGE\"}" \
       "https://discord.com/api/webhooks/1524821017732714668/9gfCVFO5Ap9YgZFhVv6F1YuImLJkFzRKUNeGTkmOmFoE-olCIJmg9Az6XdlXAiVSFIN-"
       
  echo "Update sent! Going back to sleep..."
  echo "----------------------------------------"
done
