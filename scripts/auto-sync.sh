#!/bin/bash

# Auto-sync script til at automatisk committe og pushe ændringer til GitHub
# Dette script overvåger projektmappen for ændringer og synkroniserer dem automatisk

# Tjek at vi er i et git repository
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    echo "❌ Fejl: Ikke i et git repository!"
    echo "Kør dette script fra roden af dit git projekt."
    exit 1
fi

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
    if [[ -n $(git status -s 2>/dev/null) ]]; then
        echo "📝 Ændringer fundet - synkroniserer..."
        
        # Add alle ændringer
        if ! git add -A; then
            echo "❌ Fejl ved tilføjelse af filer"
            return 1
        fi
        
        # Commit med timestamp
        COMMIT_MSG="Auto-sync: $(date '+%Y-%m-%d %H:%M:%S')"
        if ! git commit -m "$COMMIT_MSG" 2>/dev/null; then
            echo "⚠️  Ingen ændringer at committe"
            return 0
        fi
        
        # Push til GitHub og gem fejlbesked
        if ! ERROR_OUTPUT=$(git push 2>&1); then
            echo "❌ Fejl ved upload til GitHub:"
            echo "$ERROR_OUTPUT"
            echo ""
            echo "Mulige årsager:"
            echo "  • Manglende internetforbindelse"
            echo "  • Ikke konfigureret GitHub authentication"
            echo "  • Merge conflict (nogen anden har pushet ændringer)"
            echo ""
            echo "Prøv at køre: git pull --rebase && git push"
            return 1
        fi
        
        echo "✅ Ændringer uploadet til GitHub: $COMMIT_MSG"
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
