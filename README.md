# Advanced Comics Converter (ACC-Windows)

> [🇮🇹 Italiano](#italiano) | [🇬🇧 English](#english)

---

## Italiano

### 📖 Descrizione

Advanced Comics Converter per Windows (ACC-Windows) è un potente strumento multi-piattaforma per convertire fumetti digitali (CBZ/CBR) in PDF di alta qualità. Supporta processing parallelo, interfaccia grafica drag-and-drop.

### ✨ Caratteristiche Principali

- **🚀 Processing Parallelo**: Sfrutta l'80% della CPU per conversioni ultra-veloci
- **🖼️ Ricerca Ricorsiva**: Trova immagini anche in sottodirectory degli archivi
- **📦 Multi-formato**: Supporto completo per CBZ (ZIP) e CBR (RAR/RAR5)
- **🎨 Normalizzazione Immagini**: Converte tutte le immagini in JPG ottimizzato
- **🔧 Gestione Errori Robusta**: Continua anche se alcuni file falliscono
- **📊 Log Dettagliati**: Traccia completa di tutte le operazioni
- **⚡ Skip Intelligente**: Salta file già convertiti
- **🎯 Tre Versioni Disponibili**: Simple (CLI), GUI e Linux

### 📦 Versioni Disponibili

#### 1. **Advanced-Comics-Converter-Simple.ps1** 
- ✅ Interfaccia a riga di comando semplice
- ✅ Dialog per selezione cartelle
- ✅ Processing parallelo automatico (80% CPU)
- ✅ Stabilità garantita
- ✅ Ideale per batch processing

#### 2. **Advanced-Comics-Converter-GUI.ps1** (Raccomandato)
- ✅ Interfaccia grafica completa
- ✅ Drag and drop file/cartelle
- ✅ Lista file visiva
- ✅ Progress bar in tempo reale
- ✅ Dialog di riepilogo finale
- ✅ Chiusura immediata (cleanup in background)

#### 3. **Install-Dependencies.ps1**
- ✅ Script PowerShell per dipendenze (se mancanti)
- Richiede esecuzione come Amministratore
- ✅ Chocolatey (package manager)
- ✅ Python 3
- ✅ ImageMagick
- ✅ Ghostscript (per merge PDF)
- ✅ 7-Zip (per estrazione CBR)
- ✅ img2pdf (modulo Python)

#### 4. **Check-Dependencies.ps1**
- ✅ Verifica dipendenze

### 🔧 Requisiti

#### Windows
- **Python 3** (con PATH configurato)
- **ImageMagick** 7.x
- **img2pdf** (modulo Python)
- **Ghostscript** o **PDFtk** (per merge PDF)
- **7-Zip**, **WinRAR** o **unrar** (per file CBR)


### 📥 Installazione

#### Windows

**Metodo Automatico:**
```powershell come Amministratore
# Come Amministratore
PowerShell -ExecutionPolicy Bypass -File .\Install-Dependencies.ps1
```

**Verifica Installazione:**
```powershell
PowerShell -ExecutionPolicy Bypass -File.\Check-Dependencies.ps1


Se lo script fallisce installare manualmente le dipendenze, lo script chiederà se  aprire le pagine di download.


### Metodo 2: Installazione Manuale

#### 1. Python e img2pdf

```powershell
# Scarica Python da: https://www.python.org/downloads/
# Durante l'installazione, seleziona "Add Python to PATH"

# Dopo l'installazione, apri PowerShell e installa img2pdf:
pip install img2pdf
```

#### 2. ImageMagick

```powershell
# Scarica da: https://imagemagick.org/script/download.php#windows
# Scegli la versione: ImageMagick-7.x.x-Q16-HDRI-x64-dll.exe
# Durante l'installazione, seleziona "Add to system PATH"
```

#### 3. Tool PDF (scegli uno)

**Opzione A: PDFtk** (Raccomandato)
```powershell
# Scarica da: https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/
# Versione gratuita: PDFtk Free
```

**Opzione B: Ghostscript**
```powershell
# Scarica da: https://www.ghostscript.com/download/gsdnld.html
# Scegli: Ghostscript 10.x for Windows (64 bit)
```

#### 4. Tool RAR (scegli uno)

**Opzione A: WinRAR**
```powershell
# Scarica da: https://www.win-rar.com/download.html
# Aggiungi WinRAR al PATH:
# Pannello di controllo → Sistema → Impostazioni avanzate → Variabili d'ambiente
# Aggiungi: C:\Program Files\WinRAR
```

**Opzione B: 7-Zip** (Gratuito e Open Source)
```powershell
# Scarica da: https://www.7-zip.org/download.html
# Aggiungi 7-Zip al PATH:
# Aggiungi: C:\Program Files\7-Zip
```

**Opzione C: unrar**
```powershell
# Scarica da: https://www.rarlab.com/rar_add.htm
# Estrai unrar.exe in una directory nel PATH

```

### 🚀 Utilizzo

#### Windows - Versione Simple (CLI)

**Con Dialog:**
```powershell
PowerShell -ExecutionPolicy Bypass -File .\Advanced-Comics-Converter-Simple.ps1
```

**Specificando Cartella:**
```powershell
PowerShell -ExecutionPolicy Bypass -File .\Advanced-Comics-Converter-Simple.ps1 -Path "C:\Fumetti"
```

#### Windows - Versione GUI

**Avvio Normale:**
```powershell
PowerShell -ExecutionPolicy Bypass -File .\Advanced-Comics-Converter-GUI.ps1
```

**Drag and Drop:**
- Trascina file CBZ/CBR sull'area grigia nella GUI, oppure
- Usa i bottoni "Sfoglia File" o "Sfoglia Cartella"


### 🐛 Troubleshooting

**Problema: "Execution Policy"**
```powershell
PowerShell -ExecutionPolicy Bypass -File .\script.ps1

in caso di errore tipo sotto:

PS C:\Users\......> .\Install-Dependencies.ps1
.\Install-Dependencies.ps1 Install-Dependencies.ps1 cannot be loaded because
running scripts is disabled on this system. For more information, see about_Execution_Policies at
https:/go.microsoft.com/fwlink/?LinkID=135170.
At line:1 char:1
+ .\Install-Dependencies.ps1
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : SecurityError: (:) [], PSSecurityException
    + FullyQualifiedErrorId : UnauthorizedAccess

Gli script vanno lanciati da powershell con la sintassi:

PowerShell -ExecutionPolicy Bypass -File .\Advanced-Comics-Converter-GUI.ps1
PowerShell -ExecutionPolicy Bypass -File .\Advanced-Comics-Converter-Simple.ps1
PowerShell -ExecutionPolicy Bypass -File .\Install-Dependencies.ps1
PowerShell -ExecutionPolicy Bypass -File .\Check-Dependencies.ps1

```

**Problema: "Python non trovato"**
- Reinstalla Python con "Add to PATH"
- Verifica: `python --version`

**Problema: Drag and drop non funziona**
- Usa i bottoni "Sfoglia File" o "Sfoglia Cartella"
- Funzionano sempre al 100%

---

## English

### 📖 Description

Advanced Comics Converter for Windows (ACC-Windows) is a powerful cross-platform tool for converting digital comics (CBZ/CBR) to high-quality PDFs. Features parallel processing, drag-and-drop GUI interface.

### ✨ Key Features

- **🚀 Parallel Processing**: Utilizes 80% of CPU for ultra-fast conversions
- **🖼️ Recursive Search**: Finds images even in archive subdirectories
- **📦 Multi-format**: Full support for CBZ (ZIP) and CBR (RAR/RAR5)
- **🎨 Image Normalization**: Converts all images to optimized JPG
- **🔧 Robust Error Handling**: Continues even if some files fail
- **📊 Detailed Logging**: Complete trace of all operations
- **⚡ Smart Skip**: Skips already converted files

### 📦 Available Versions

#### 1. **Advanced-Comics-Converter-Simple.ps1** 
- ✅ Simple command-line interface
- ✅ Folder selection dialog
- ✅ Automatic parallel processing (80% CPU default)
- ✅ Guaranteed stability

#### 2. **Advanced-Comics-Converter-GUI.ps1** (Recommended)
- ✅ Complete graphical interface
- ✅ Drag and drop files/folders
- ✅ Visual file list
- ✅ Real-time progress bar
- ✅ Immediate closing (background cleanup)

#### 3. **Install-Dependencies.ps1**
- ✅ Script PowerShell for missing dependencies
- Requires admin rights
- ✅ Chocolatey (package manager)
- ✅ Python 3
- ✅ ImageMagick
- ✅ Ghostscript (per merge PDF)
- ✅ 7-Zip (per estrazione CBR)
- ✅ img2pdf (modulo Python)

#### 4. **Check-Dependencies.ps1**
- ✅ Check dependencies

### 📥 Installation

#### Windows

**Automatic Method:**
```powershell
# As Administrator
PowerShell -ExecutionPolicy Bypass -File .\Install-Dependencies.ps1
```

**Verify Installation:**
```powershell
PowerShell -ExecutionPolicy Bypass -File .\Check-Dependencies.ps1
```

### 🚀 Usage

#### Windows - Simple Version (CLI)

```powershell
PowerShell -ExecutionPolicy Bypass -File .\Advanced-Comics-Converter-Simple.ps1
```

#### Windows - GUI Version

```powershell
PowerShell -ExecutionPolicy Bypass -File .\Advanced-Comics-Converter-GUI.ps1
```

Then drag CBZ/CBR files onto the gray area or use the browse buttons.



### 👤 Author

**Franco Conidi aka Edmond** - Creator of SysLinuxOS and Linux blogger
