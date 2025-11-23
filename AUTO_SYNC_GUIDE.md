# Automatisk GitHub Sync Guide 🚀

Denne guide hjælper dig med at opsætte automatisk synkronisering af dine hjemmeside-ændringer til GitHub når du arbejder på din Mac med Visual Studio Code.

## 📋 Indholdsfortegnelse

1. [Forudsætninger](#forudsætninger)
2. [Hurtig Start](#hurtig-start)
3. [Metode 1: VS Code Tasks (Anbefalet)](#metode-1-vs-code-tasks-anbefalet)
4. [Metode 2: Auto-Sync Script](#metode-2-auto-sync-script)
5. [Metode 3: GitHub Desktop](#metode-3-github-desktop)
6. [Fejlfinding](#fejlfinding)

---

## 🔧 Forudsætninger

Før du går i gang, skal du sikre at:

1. **Git er installeret** på din Mac
   - Åbn Terminal og skriv: `git --version`
   - Hvis ikke installeret, download fra: https://git-scm.com/

2. **Du har konfigureret Git med dine oplysninger**
   ```bash
   git config --global user.name "Dit Navn"
   git config --global user.email "din@email.dk"
   ```

3. **Du har GitHub adgang**
   - Du skal kunne pushe til repository uden at indtaste password hver gang
   - Opsæt enten SSH-nøgler eller Personal Access Token

### Opsætning af GitHub Authentication

#### Option A: Personal Access Token (Nemmest)

1. Gå til GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Klik "Generate new token (classic)"
3. Giv den et navn (f.eks. "Mac VSCode")
4. Vælg "repo" under scopes
5. Klik "Generate token" og **gem tokenet et sikkert sted**
6. Når du første gang pusher, brug tokenet som password

#### Option B: SSH Keys (Mest sikker)

```bash
# Generer SSH key
ssh-keygen -t ed25519 -C "din@email.dk"

# Tilføj key til ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Kopier public key
cat ~/.ssh/id_ed25519.pub

# Tilføj denne key til GitHub → Settings → SSH and GPG keys
```

Skift derefter remote URL til SSH:
```bash
git remote set-url origin git@github.com:sophusand/Fysik-klubbens-hjemmeside.git
```

---

## 🚀 Hurtig Start

Dette repository er allerede konfigureret med automatiske sync-muligheder!

### VS Code Indstillinger der allerede er sat op:

- ✅ **Auto-save**: Filer gemmes automatisk efter 1 sekund
- ✅ **Git auto-fetch**: Henter automatisk ændringer fra GitHub
- ✅ **Smart commit**: Tillader commits uden at tilføje filer først
- ✅ **Auto push**: Pusher automatisk efter commit

---

## 🎯 Metode 1: VS Code Tasks (Anbefalet)

Dette er den nemmeste metode til at synkronisere dine ændringer.

### Sådan bruger du det:

1. **Åbn VS Code** i din projektmappe
2. Tryk `Cmd + Shift + P` for at åbne Command Palette
3. Skriv "Run Task" og vælg `Tasks: Run Task`
4. Vælg en af følgende tasks:

#### 📤 Git: Sync alle ændringer
- Spørger dig om en commit-besked
- Tilføjer alle ændringer, committer og pusher

#### ⚡ Git: Hurtig sync (auto-besked)
- Synkroniserer med automatisk timestamp som besked
- Hurtigste metode når du bare vil uploade ændringer

### Genvejstast (Optional)

Du kan tilføje en keyboard shortcut til hurtig sync:

1. Tryk `Cmd + K, Cmd + S` for at åbne Keyboard Shortcuts
2. Søg efter "Run Task"
3. Tilføj en genvej (f.eks. `Cmd + Shift + U` for "Upload")

---

## 🤖 Metode 2: Auto-Sync Script

Dette script overvåger løbende dine filer og pusher automatisk til GitHub.

### Sådan starter du auto-sync:

#### Option A: Via VS Code Task

1. Tryk `Cmd + Shift + P`
2. Vælg `Tasks: Run Task`
3. Vælg `Start auto-sync overvågning`

#### Option B: Via Terminal

```bash
# Gør scriptet eksekverbart (kun første gang)
chmod +x scripts/auto-sync.sh

# Start auto-sync
./scripts/auto-sync.sh
```

### Hvad gør scriptet?

- 🔍 Tjekker hvert 30. sekund om der er ændringer
- 📝 Committer automatisk med timestamp
- 🚀 Pusher til GitHub
- 💬 Viser status i terminalen

### Stop auto-sync:

Tryk `Ctrl + C` i Terminal-vinduet hvor scriptet kører.

---

## 🖥️ Metode 3: GitHub Desktop

Hvis du foretrækker en grafisk brugerflade:

1. **Download GitHub Desktop**: https://desktop.github.com/
2. **Klon repository** i GitHub Desktop
3. **Åbn i VS Code** via GitHub Desktop
4. **Arbejd i VS Code**, og GitHub Desktop viser automatisk ændringer
5. **Commit og Push** med et enkelt klik i GitHub Desktop

---

## 🔄 Workflow Eksempel

Her er et typisk workflow når du arbejder på hjemmesiden:

```
1. Åbn projekt i VS Code
   → Filer auto-saves automatisk

2. Lav ændringer i dine HTML/CSS/JS filer
   → Alle ændringer gemmes løbende

3. Når du er klar til at uploade:
   
   Option A - Manuel sync:
   → Cmd + Shift + P
   → "Run Task"
   → "Git: Hurtig sync"
   
   Option B - Auto sync:
   → Start auto-sync scriptet én gang
   → Glem det - det uploader automatisk!

4. Tjek på GitHub at dine ændringer er der ✅
```

---

## 🐛 Fejlfinding

### Problem: "Permission denied" når jeg pusher

**Løsning**: Du skal opsætte authentication (se [Forudsætninger](#forudsætninger))

### Problem: "Author identity unknown"

**Løsning**: Konfigurer Git med dine oplysninger:
```bash
git config --global user.name "Dit Navn"
git config --global user.email "din@email.dk"
```

### Problem: Merge conflicts

**Løsning**: Hvis andre har pushet ændringer:
```bash
git pull --rebase
# Ret eventuelle konflikter
git push
```

### Problem: Auto-sync virker ikke

**Løsning**: 
1. Tjek at scriptet er eksekverbart: `chmod +x scripts/auto-sync.sh`
2. Tjek din internet forbindelse
3. Verify at du kan pushe manuelt: `git push`

### Problem: Filer bliver ikke tracked

**Løsning**: Tjek `.gitignore` filen - nogle filer ignoreres med vilje (f.eks. `.DS_Store`, `node_modules`)

---

## 💡 Tips & Tricks

### God praksis for commit-beskeder:

```bash
✅ GOD: "Tilføjet kontakt-side med formular"
✅ GOD: "Rettet styling på forsiden"
✅ GOD: "Opdateret billeder i galleri"

❌ DÅRLIG: "ændringer"
❌ DÅRLIG: "fix"
❌ DÅRLIG: "asdf"
```

### Brug branches for større ændringer:

```bash
# Lav en ny branch for en ny feature
git checkout -b ny-funktion

# Arbejd på din branch
# ... lav ændringer ...

# Push din branch
git push -u origin ny-funktion

# Merge tilbage til main når færdig (via GitHub Pull Request)
```

### Gem arbejde midlertidigt:

```bash
# Gem midlertidigt uden at committe
git stash

# Få det tilbage senere
git stash pop
```

---

## 📞 Få Hjælp

- **GitHub Docs**: https://docs.github.com/
- **Git Cheat Sheet**: https://education.github.com/git-cheat-sheet-education.pdf
- **VS Code Git Guide**: https://code.visualstudio.com/docs/sourcecontrol/overview

---

## ✅ Checklist: Er jeg sat op korrekt?

- [ ] Git er installeret på min Mac
- [ ] Git er konfigureret med mit navn og email
- [ ] Jeg kan pushe til GitHub uden password (SSH eller Token)
- [ ] VS Code åbner projektet korrekt
- [ ] Jeg kan køre en VS Code Task
- [ ] Jeg har testet at lave en ændring og pushe den

Hvis alle punkter er tjekket af, er du klar! 🎉

---

**God fornøjelse med hjemmesiden! 🚀**
