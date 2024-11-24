#!/bin/bash
set -e

# Check if the .env file exists
if [ -f firebase.env ]; then
  echo "🔐 Loading environment variables from firebase.env file..."
  export $(grep -v '^#' firebase.env | xargs)
  echo "✅ Environment variables loaded."
  printenv | grep "FIREBASE"
else
  echo "⚠️ No firebase.env file found, please create one as specified in the README 📄"
  exit
fi

echo "🧹 Installing Frontend and Backend dependencies 🚀"
mvn install

echo "🚀 Starting the Spring Boot application... 🌱"
mvn spring-boot:run &

SPRING_PID=$!

# Trap signal to kill Spring Boot when the script exits
trap "echo '🛑 Stopping Spring Boot server...'; kill $SPRING_PID" EXIT

echo "🌐 Starting the frontend development server... 🎉"
cd frontend && npm run dev

wait $SPRING_PID
