# 🚀 Hurtig Reference - Auto Sync til GitHub

## Tre måder at synkronisere dine ændringer:

### 1️⃣ Hurtigste Metode - VS Code Task (ANBEFALET)
```
1. Tryk: Cmd + Shift + P
2. Skriv: "Run Task"
3. Vælg: "Git: Hurtig sync (auto-besked)"
✅ Færdig! Dine ændringer er nu på GitHub
```

### 2️⃣ Automatisk Metode - Background Script
```bash
# I Terminal:
./scripts/auto-sync.sh

# Scriptet kører nu i baggrunden
# Hver 30. sekund tjekkes for ændringer
# Tryk Ctrl+C for at stoppe
```

### 3️⃣ Manuel Metode - Terminal
```bash
git add .
git commit -m "Beskrivelse af ændringer"
git push
```

---

## 🔧 Første gang opsætning

### 1. Konfigurer Git (kun første gang):
```bash
git config --global user.name "Dit Navn"
git config --global user.email "din@email.dk"
```

### 2. Opsæt GitHub Authentication

**Vælg én af disse metoder:**

#### Option A: Personal Access Token
1. Gå til: https://github.com/settings/tokens
2. Generate new token (classic)
3. Vælg "repo" scope
4. Gem token et sikkert sted
5. Brug token som password første gang du pusher

#### Option B: SSH Key
```bash
# Generer key
ssh-keygen -t ed25519 -C "din@email.dk"

# Start ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Kopier public key
cat ~/.ssh/id_ed25519.pub

# Tilføj til GitHub → Settings → SSH Keys
```

Skift remote til SSH:
```bash
git remote set-url origin git@github.com:sophusand/Fysik-klubbens-hjemmeside.git
```

---

## ✨ VS Code er allerede konfigureret med:

- ✅ **Auto-save**: Filer gemmes automatisk efter 1 sekund
- ✅ **Smart commit**: Lettere at committe ændringer
- ✅ **Auto push**: Pusher automatisk efter commit

---

## 📝 Workflow Eksempel

```
1. Åbn VS Code i projektmappen
2. Lav dine ændringer (HTML, CSS, JS osv.)
3. Filer gemmes automatisk
4. Sync til GitHub:
   → Cmd + Shift + P → "Run Task" → "Git: Hurtig sync"
5. Tjek GitHub - dine ændringer er der! ✅
```

---

## 🐛 Problemløsning

**Kan ikke pushe?**
→ Opsæt authentication (se ovenfor)

**"Author identity unknown"?**
→ Konfigurer git (se punkt 1 under opsætning)

**Merge conflict?**
```bash
git pull --rebase
# Ret konflikter i VS Code
git push
```

---

## 📚 Fuld dokumentation

Se **[AUTO_SYNC_GUIDE.md](AUTO_SYNC_GUIDE.md)** for komplet vejledning med:
- Detaljeret opsætning
- Alle metoder forklaret
- Tips & tricks
- Fejlfinding
- God praksis

---

**God arbejdslyst! 🎉**
