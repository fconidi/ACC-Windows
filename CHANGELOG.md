# Changelog

Tutte le modifiche importanti al progetto sono documentate in questo file.

Il formato è basato su [Keep a Changelog](https://keepachangelog.com/it/1.0.0/),
e questo progetto aderisce al [Semantic Versioning](https://semver.org/lang/it/).

---

## [2.0.0] - 2025-12-21

### ✨ Aggiunto

#### Versione Windows GUI (Advanced-Comics-Converter-GUI.ps1)
- Interfaccia grafica completa con Windows Forms
- **Drag and drop funzionante** per file e cartelle
- Area visiva con feedback colorato (grigio → verde → "FILE AGGIUNTI!")
- Lista file con scrolling e contatore
- Bottoni "Sfoglia File" e "Sfoglia Cartella" per selezione multipla
- Bottone "Cancella Lista" per reset
- Dialog finale con riepilogo (Convertiti/Saltati/Falliti)
- **Chiusura immediata** con cleanup temp in background
- Supporto input da riga di comando (`-InputFiles`)

#### Versione Windows Simple (Advanced-Comics-Converter-Simple.ps1)
- **Processing parallelo** con supporto PowerShell 5.1 e 7+
- Calcolo automatico thread (80% CPU)
- Runspaces per PowerShell 5.1
- `ForEach-Object -Parallel` per PowerShell 7+
- Dialog folder browser integrato
- Progress bar in tempo reale
- Parametro `-MaxThreads` per controllo manuale

#### Funzionalità Core
- **Ricerca ricorsiva immagini** in sottodirectory degli archivi CBZ/CBR
- Spostamento automatico immagini alla root prima della conversione
- Gestione duplicati con rinominazione automatica
- Cleanup sottodirectory vuote dopo conversione
- Supporto completo PowerShell 5.1 (Windows 10/11 nativo)

#### Gestione PDF Migliorata
- Tentativo multiplo di merge: pdftk → Ghostscript 64-bit → Ghostscript 32-bit
- Parametri ottimizzati Ghostscript (`-dPDFSETTINGS=/ebook`)
- Verifica exit code per ogni comando
- Logging dettagliato di successo/fallimento
- Gestione file con 100+ pagine

#### Script di Supporto
- `Check-Dependencies.ps1`: Verifica dipendenze senza admin
- `Install-Dependencies-Fixed.ps1`: Installer automatico senza emoji
- `EXECUTION-POLICY-FIX.md`: Guida completa policy PowerShell
- `Fix-ExecutionPolicy.bat`: Fix automatico policy

### 🔄 Modificato

#### Ottimizzazioni Performance
- Sleep ridotto da 500ms a 200ms nel polling jobs
- Cleanup temp folder **in background** con `Start-Job`
- Try-catch su `EndInvoke()` per evitare blocchi
- Progress "Finalizzazione..." durante cleanup jobs
- Riduzione latenza chiusura GUI da 5-10 secondi a istantanea

#### Gestione Errori
- Variabili scope corrette con `$Script:` per eventi GUI
- Gestione null-safe su drop files
- Timer con `$this` invece di variabile per cleanup
- Fallback multipli per comandi esterni
- Continuazione processing anche con errori individuali

#### Compatibilità
- Rimozione completa emoji e caratteri unicode
- Sostituzione `[OK]` → `(OK)` per evitare parsing array
- Fix ampersand in stringhe (`drag & drop` → `drag and drop`)
- Fix slash in path (`CBZ/CBR` → `CBZ-CBR` in display)
- Fix percent sign in stringhe di status
- Encoding ASCII puro per massima compatibilità

### 🐛 Risolto

#### Windows PowerShell
- Errore "The expression after '&' in a pipeline element produced an object that was not valid"
- Errore "Array index expression is missing or not valid" con `[WARN]`
- Errore "You must provide a value expression following the '%' operator"
- Errore "The string is missing the terminator" su righe con emoji
- Errore "PropertyNotFound" su `BackColor`, `Text`, `ForeColor` in eventi
- Errore "InvokeMethodOnNull" su timer disposal

#### Conversione File
- **Bug critico**: Nessuna immagine trovata per file con sottodirectory
- File CBZ con struttura complessa (es. `/images/page001.jpg`)
- Merge PDF fallito con file 100+ pagine
- Timeout su cleanup cartella temp con molti file
- Blocco finale prima del dialog di completamento

#### GUI Drag and Drop
- Eventi non triggerati (label bloccava panel)
- Scope variabili non accessibili in event handlers
- Background color non cambiava durante drag
- File non aggiunti alla lista dopo drop
- Errori runtime su property non trovate

### 🔧 Tecnico

#### Architettura
- **3 versioni**: Simple (CLI), GUI, Linux (bash)
- **Modularità**: Funzioni core identiche tra versioni
- **Testabilità**: Ogni componente isolato e verificabile

#### Dipendenze Verificate
- Python 3.14.0 ✅
- ImageMagick 7.1.2-10 ✅
- img2pdf 0.6.3 ✅
- Ghostscript 64-bit ✅
- WinRAR/7-Zip/unrar ✅

---

## [1.0.0] - 2025-12-09

### ✨ Aggiunto

#### Prima Versione Stabile
- Script bash per Linux (`advanced-comics-converter.sh`)
- Supporto CBZ (ZIP) e CBR (RAR)
- Conversione immagini con ImageMagick
- Creazione PDF con img2pdf
- Merge PDF con pdftk
- GUI opzionale con Zenity
- Magic bytes validation
- Logging dettagliato

#### Packaging Debian
- Script `setup-deb-package.sh` per creazione pacchetto
- Struttura `debian/` completa
- File `.desktop` per integrazione menu
- Man page
- Supporto installazione sistema

### 📝 Documentazione
- README completo bilingue (IT/EN)
- Guida packaging DEB
- Esempi d'uso
- Troubleshooting Linux

---

## [0.5.0] - 2025-12-08 (Beta)

### ✨ Aggiunto
- Proof of concept iniziale
- Script PowerShell base
- Conversione singola CBZ → PDF
- Test ImageMagick + img2pdf

---

## Legenda

- ✨ **Aggiunto**: Nuove funzionalità
- 🔄 **Modificato**: Modifiche a funzionalità esistenti
- 🐛 **Risolto**: Bug fix
- 🔧 **Tecnico**: Modifiche tecniche/refactoring
- 📝 **Documentazione**: Solo documentazione
- ⚠️ **Deprecato**: Funzionalità deprecate
- 🗑️ **Rimosso**: Funzionalità rimosse

---

## Note di Versione

### v2.0.0 - Milestone Importante

Questa versione rappresenta una **completa riscrittura** del progetto con:

1. **Supporto Multi-piattaforma Completo**: Windows e Linux
2. **Processing Parallelo Nativo**: Velocità 6-8x superiore
3. **GUI Professionale**: Drag and drop funzionante e intuitiva
4. **Stabilità Enterprise**: Gestione errori robusta, logging completo
5. **Zero Dipendenze Esterne Windows**: Solo Python, ImageMagick, Ghostscript

### Migrazioni

#### Da v1.0.0 a v2.0.0

**Linux**: Nessuna modifica necessaria, retrocompatibile al 100%

**Windows**: 
- Prima versione Windows completa
- Segui guida installazione nel README

### Problemi Noti

#### Windows
- Drag and drop potrebbe non funzionare con UAC elevato
  - **Workaround**: Usa bottoni "Sfoglia File/Cartella"
- PowerShell 5.1 più lento di PowerShell 7+
  - **Raccomandazione**: Aggiorna a PowerShell 7 per performance ottimali

#### Linux
- GNU Parallel non strettamente necessario ma fortemente raccomandato
- Zenity opzionale per GUI

---

**Nota**: Le date seguono il formato ISO 8601 (YYYY-MM-DD)
