#!/bin/bash
echo "=== Cloud Weather Bot Online & Ready ==="

# Pre-create a clean, standardized HTTP response text page
echo -e "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\nConnection: close\r\n\r\nSuccess" > response.txt

# Infinite loop ensures Render keeps the cloud service running 24/7 without restarting
while true; do
  echo "Waiting quietly for the 7:00 AM cron-job ping..."
  
  # Stops execution and opens port 8080. It only moves forward when hit!
  cat response.txt | nc -l -p 8080
  
  echo "Ping received! Processing daily update..."
  
  # Added '?m' to explicitly force Metric/Celsius units regardless of cloud server location
  WEATHER=$(curl -s "wttr.in/Coimbatore?m&format=3")
  MESSAGE="🚀 **Cloud DevOps Bot Update:** Current conditions in $WEATHER"
  
  # Fire a single payload over to Discord
  curl -s -H "Content-Type: application/json" \
       -X POST \
       -d "{\"content\": \"$MESSAGE\"}" \
       "https://discord.com/api/webhooks/1524321531696779386/0cIhPs0qsGCUKh4LlmRX_kiesk9ZhWInI8gzwrzHHXr264daOK_sQ4nRVMpwegc1_-VQ"
       
  echo "Update dispatched cleanly! Returning to sleep..."
  echo "----------------------------------------"
done
