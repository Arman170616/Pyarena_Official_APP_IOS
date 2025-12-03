#!/bin/bash

# Automated Screenshot Capture Script
# Takes screenshots from the currently running iOS Simulator

echo "🤖 Automated Screenshot Capture"
echo "==============================="
echo ""

# Get the simulator UDID
SIMULATOR_UDID=$(xcrun simctl list devices | grep "Booted" | grep -o "[A-F0-9-]\{36\}" | head -n 1)

if [ -z "$SIMULATOR_UDID" ]; then
    echo "❌ Error: No simulator is currently running"
    echo "Please start the simulator and run the School app first"
    exit 1
fi

echo "✅ Found running simulator: $SIMULATOR_UDID"
echo ""
echo "📸 Taking screenshots..."
echo ""

# Output directory
OUTPUT_DIR="$(pwd)"

# Function to take screenshot
take_screenshot() {
    local filename=$1
    local description=$2
    
    echo "  📱 Capturing: $description"
    xcrun simctl io $SIMULATOR_UDID screenshot "$OUTPUT_DIR/$filename" 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo "  ✅ Saved: $filename"
    else
        echo "  ⚠️  Failed to capture $filename"
    fi
    
    # Small delay between screenshots
    sleep 1
}

# Instructions
echo "🎬 Automated capture will start in 5 seconds..."
echo ""
echo "IMPORTANT: Manually navigate through the app screens in this order:"
echo ""
echo "1. Home Dashboard (starting screen)"
sleep 2
take_screenshot "home-dashboard.png" "Home Dashboard"

echo ""
echo "👉 Now navigate to: About section"
echo "Press Enter when ready..."
read
take_screenshot "about-us.png" "About Us"

echo ""
echo "👉 Now navigate to: Programs"
echo "Press Enter when ready..."
read
take_screenshot "programs.png" "Programs"

echo ""
echo "👉 Now navigate to: Teachers"
echo "Press Enter when ready..."
read
take_screenshot "teachers.png" "Teachers Portfolio"

echo ""
echo "👉 Now navigate to: Activities"
echo "Press Enter when ready..."
read
take_screenshot "activities.png" "Activities"

echo ""
echo "👉 Now navigate to: Careers"
echo "Press Enter when ready..."
read
take_screenshot "careers.png" "Careers"

echo ""
echo "👉 Now navigate to: News tab"
echo "Press Enter when ready..."
read
take_screenshot "news.png" "News"

echo ""
echo "👉 Now navigate to: Schools tab"
echo "Press Enter when ready..."
read
take_screenshot "schools.png" "Schools Directory"

echo ""
echo "👉 Now navigate to: Contact"
echo "Press Enter when ready..."
read
take_screenshot "contact.png" "Contact"

echo ""
echo "👉 Now navigate to: Chat tab (Chatbot)"
echo "Press Enter when ready..."
read
take_screenshot "chatbot.png" "AI Chatbot"

echo ""
echo "👉 Now navigate to: More tab → Admin Login"
echo "Press Enter when ready..."
read
take_screenshot "admin-login.png" "Admin Login"

echo ""
echo "👉 Now navigate to: More tab"
echo "Press Enter when ready..."
read
take_screenshot "more.png" "More Menu"

echo ""
echo "👉 Show the tab navigation at the bottom"
echo "Press Enter when ready..."
read
take_screenshot "tab-navigation.png" "Tab Navigation"

echo ""
echo "✨ Screenshot capture complete!"
echo ""
echo "📁 Screenshots saved to: $OUTPUT_DIR"
echo ""
echo "Next steps:"
echo "1. Review the screenshots"
echo "2. git add screenshots/"
echo "3. git commit -m 'Add app screenshots'"
echo "4. git push origin main"
echo ""
