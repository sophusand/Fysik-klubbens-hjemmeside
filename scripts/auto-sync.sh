#!/bin/bash

# Auto-sync script til at automatisk committe og pushe ændringer til GitHub
# Dette script overvåger projektmappen for ændringer og synkroniserer dem automatisk

echo "🚀 Starter auto-sync til GitHub..."
echo "📁 Overvåger mappe: $(pwd)"
echo "⏰ Tjekker for ændringer hvert 30. sekund"
echo "Tryk Ctrl+C for at stoppe"
echo ""

# Interval mellem checks (i sekunder)
INTERVAL=30

# Funktion til at synkronisere ændringer
sync_changes() {
    # Tjek om der er ændringer
    if [[ -n $(git status -s) ]]; then
        echo "📝 Ændringer fundet - synkroniserer..."
        
        # Add alle ændringer
        git add .
        
        # Commit med timestamp
        COMMIT_MSG="Auto-sync: $(date '+%Y-%m-%d %H:%M:%S')"
        git commit -m "$COMMIT_MSG"
        
        # Push til GitHub
        if git push; then
            echo "✅ Ændringer uploadet til GitHub: $COMMIT_MSG"
        else
            echo "❌ Fejl ved upload - tjek din internetforbindelse eller GitHub adgang"
        fi
        echo ""
    fi
}

# Første sync ved start
sync_changes

# Uendelig loop der tjekker for ændringer
while true; do
    sleep $INTERVAL
    sync_changes
done
