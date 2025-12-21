# Install-Dependencies.ps1
# Script per l'installazione automatica delle dipendenze su Windows
# Automated installation script for Windows dependencies

#Requires -Version 5.1
#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Installa automaticamente le dipendenze per Advanced Comics Converter

.DESCRIPTION
    Questo script installa (se mancanti):
    - Chocolatey (package manager)
    - Python 3
    - ImageMagick
    - Ghostscript (per merge PDF)
    - 7-Zip (per estrazione CBR)
    - img2pdf (modulo Python)

.NOTES
    Richiede esecuzione come Amministratore
#>

$ErrorActionPreference = "Continue"

# Colori per output
$ColorInfo = "Cyan"
$ColorSuccess = "Green"
$ColorWarning = "Yellow"
$ColorError = "Red"

# ============================================================================
# FUNZIONI
# ============================================================================

function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

function Test-IsAdmin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Test-CommandExists {
    param([string]$Command)
    return $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

function Install-Chocolatey {
    Write-ColorOutput "`n[*] Installazione Chocolatey..." $ColorInfo
    Write-ColorOutput "[*] Installing Chocolatey..." $ColorInfo
    
    try {
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        
        # Ricarica environment
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
        
        if (Test-CommandExists "choco") {
            Write-ColorOutput "[OK] Chocolatey installato con successo!" $ColorSuccess
            Write-ColorOutput "[OK] Chocolatey installed successfully!" $ColorSuccess
            return $true
        }
    } catch {
        Write-ColorOutput "[ERROR] Errore installazione Chocolatey: $_" $ColorError
        return $false
    }
    
    return $false
}

function Install-Package {
    param(
        [string]$PackageName,
        [string]$DisplayName,
        [string]$TestCommand
    )
    
    Write-ColorOutput "`n[*] Installazione $DisplayName..." $ColorInfo
    Write-ColorOutput "[*] Installing $DisplayName..." $ColorInfo
    
    if (Test-CommandExists $TestCommand) {
        Write-ColorOutput "[OK] $DisplayName gia installato!" $ColorSuccess
        Write-ColorOutput "[OK] $DisplayName already installed!" $ColorSuccess
        return $true
    }
    
    try {
        Write-ColorOutput "    Download e installazione in corso..." $ColorWarning
        Write-ColorOutput "    Downloading and installing..." $ColorWarning
        
        $output = choco install $PackageName -y 2>&1
        
        # Ricarica environment
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
        
        Start-Sleep -Seconds 2
        
        if (Test-CommandExists $TestCommand) {
            Write-ColorOutput "[OK] $DisplayName installato con successo!" $ColorSuccess
            Write-ColorOutput "[OK] $DisplayName installed successfully!" $ColorSuccess
            return $true
        } else {
            Write-ColorOutput "[WARN] $DisplayName installato ma richiede riavvio PowerShell" $ColorWarning
            Write-ColorOutput "[WARN] $DisplayName installed but requires PowerShell restart" $ColorWarning
            return $true
        }
        
    } catch {
        Write-ColorOutput "[ERROR] Errore installazione $DisplayName : $_" $ColorError
        return $false
    }
}

function Install-PythonPackage {
    param(
        [string]$PackageName,
        [string]$DisplayName
    )
    
    Write-ColorOutput "`n[*] Installazione modulo Python: $DisplayName..." $ColorInfo
    Write-ColorOutput "[*] Installing Python module: $DisplayName..." $ColorInfo
    
    try {
        # Verifica se gia installato
        $checkInstalled = python -m pip show $PackageName 2>&1
        
        if ($LASTEXITCODE -eq 0) {
            Write-ColorOutput "[OK] $DisplayName gia installato!" $ColorSuccess
            Write-ColorOutput "[OK] $DisplayName already installed!" $ColorSuccess
            return $true
        }
        
        Write-ColorOutput "    Installazione in corso..." $ColorWarning
        Write-ColorOutput "    Installing..." $ColorWarning
        
        $output = python -m pip install $PackageName 2>&1
        
        if ($LASTEXITCODE -eq 0) {
            Write-ColorOutput "[OK] $DisplayName installato con successo!" $ColorSuccess
            Write-ColorOutput "[OK] $DisplayName installed successfully!" $ColorSuccess
            return $true
        } else {
            Write-ColorOutput "[ERROR] Errore installazione $DisplayName" $ColorError
            return $false
        }
        
    } catch {
        Write-ColorOutput "[ERROR] Errore installazione $DisplayName : $_" $ColorError
        return $false
    }
}

function Update-EnvironmentPath {
    Write-ColorOutput "`n[*] Aggiornamento variabili d'ambiente..." $ColorInfo
    Write-ColorOutput "[*] Updating environment variables..." $ColorInfo
    
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    
    Write-ColorOutput "[OK] Variabili d'ambiente aggiornate" $ColorSuccess
    Write-ColorOutput "[OK] Environment variables updated" $ColorSuccess
}

# ============================================================================
# MAIN SCRIPT
# ============================================================================

# Banner
Write-Host ""
Write-Host "====================================================================" -ForegroundColor $ColorInfo
Write-Host "        Advanced Comics Converter - Dependency Installer           " -ForegroundColor $ColorInfo
Write-Host "        Installazione automatica dipendenze Windows                " -ForegroundColor $ColorInfo
Write-Host "        Automatic Windows dependencies installation                " -ForegroundColor $ColorInfo
Write-Host "====================================================================" -ForegroundColor $ColorInfo
Write-Host ""

# Verifica privilegi amministratore
if (-not (Test-IsAdmin)) {
    Write-ColorOutput "[ERROR] ERRORE: Questo script richiede privilegi di Amministratore!" $ColorError
    Write-ColorOutput "[ERROR] ERROR: This script requires Administrator privileges!" $ColorError
    Write-ColorOutput "`nEsegui PowerShell come Amministratore e riprova." $ColorWarning
    Write-ColorOutput "Run PowerShell as Administrator and try again." $ColorWarning
    Read-Host "`nPremi INVIO per uscire"
    exit 1
}

Write-ColorOutput "[OK] Esecuzione con privilegi di Amministratore" $ColorSuccess
Write-ColorOutput "[OK] Running with Administrator privileges" $ColorSuccess

# Contatori
$successCount = 0
$failCount = 0
$skipCount = 0

# Step 1: Chocolatey
Write-ColorOutput "`n====================================================================" $ColorInfo
Write-ColorOutput "STEP 1: Chocolatey Package Manager" $ColorInfo
Write-ColorOutput "====================================================================" $ColorInfo

if (Test-CommandExists "choco") {
    Write-ColorOutput "[OK] Chocolatey gia installato!" $ColorSuccess
    Write-ColorOutput "[OK] Chocolatey already installed!" $ColorSuccess
    $skipCount++
} else {
    if (Install-Chocolatey) {
        $successCount++
    } else {
        $failCount++
        Write-ColorOutput "`n[WARN] Impossibile installare Chocolatey automaticamente." $ColorWarning
        Write-ColorOutput "[WARN] Cannot install Chocolatey automatically." $ColorWarning
        Write-ColorOutput "Installazione manuale richiesta: https://chocolatey.org/install" $ColorWarning
    }
}

# Step 2: Python
Write-ColorOutput "`n====================================================================" $ColorInfo
Write-ColorOutput "STEP 2: Python 3" $ColorInfo
Write-ColorOutput "====================================================================" $ColorInfo

if (Install-Package -PackageName "python" -DisplayName "Python 3" -TestCommand "python") {
    $successCount++
} else {
    $failCount++
}

# Step 3: ImageMagick
Write-ColorOutput "`n====================================================================" $ColorInfo
Write-ColorOutput "STEP 3: ImageMagick" $ColorInfo
Write-ColorOutput "====================================================================" $ColorInfo

if (Install-Package -PackageName "imagemagick" -DisplayName "ImageMagick" -TestCommand "magick") {
    $successCount++
} else {
    $failCount++
}

# Step 4: Ghostscript
Write-ColorOutput "`n====================================================================" $ColorInfo
Write-ColorOutput "STEP 4: Ghostscript (PDF merge)" $ColorInfo
Write-ColorOutput "====================================================================" $ColorInfo

# Controlla se pdftk o ghostscript sono gia installati
if ((Test-CommandExists "pdftk") -or (Test-CommandExists "gswin64c") -or (Test-CommandExists "gswin32c")) {
    Write-ColorOutput "[OK] Tool PDF gia installato (pdftk o Ghostscript)!" $ColorSuccess
    Write-ColorOutput "[OK] PDF tool already installed (pdftk or Ghostscript)!" $ColorSuccess
    $skipCount++
} else {
    if (Install-Package -PackageName "ghostscript" -DisplayName "Ghostscript" -TestCommand "gswin64c") {
        $successCount++
    } else {
        $failCount++
    }
}

# Step 5: 7-Zip
Write-ColorOutput "`n====================================================================" $ColorInfo
Write-ColorOutput "STEP 5: 7-Zip (CBR extraction)" $ColorInfo
Write-ColorOutput "====================================================================" $ColorInfo

# Controlla se gia esiste un tool RAR
if ((Test-CommandExists "7z") -or (Test-CommandExists "unrar") -or (Test-Path "C:\Program Files\WinRAR\WinRAR.exe")) {
    Write-ColorOutput "[OK] Tool RAR gia installato (7-Zip, unrar o WinRAR)!" $ColorSuccess
    Write-ColorOutput "[OK] RAR tool already installed (7-Zip, unrar or WinRAR)!" $ColorSuccess
    $skipCount++
} else {
    if (Install-Package -PackageName "7zip" -DisplayName "7-Zip" -TestCommand "7z") {
        $successCount++
    } else {
        $failCount++
    }
}

# Step 6: img2pdf (Python module)
Write-ColorOutput "`n====================================================================" $ColorInfo
Write-ColorOutput "STEP 6: img2pdf (Python module)" $ColorInfo
Write-ColorOutput "====================================================================" $ColorInfo

if (Test-CommandExists "python") {
    if (Install-PythonPackage -PackageName "img2pdf" -DisplayName "img2pdf") {
        $successCount++
    } else {
        $failCount++
    }
} else {
    Write-ColorOutput "[WARN] Python non trovato, impossibile installare img2pdf" $ColorWarning
    Write-ColorOutput "[WARN] Python not found, cannot install img2pdf" $ColorWarning
    $failCount++
}

# Aggiorna PATH
Update-EnvironmentPath

# Riepilogo finale
Write-ColorOutput "`n====================================================================" $ColorInfo
Write-ColorOutput "RIEPILOGO INSTALLAZIONE / INSTALLATION SUMMARY" $ColorInfo
Write-ColorOutput "====================================================================" $ColorInfo
Write-Host ""
Write-ColorOutput "[OK] Installati con successo: $successCount" $ColorSuccess
Write-ColorOutput "[SKIP] Gia presenti: $skipCount" $ColorWarning
Write-ColorOutput "[ERROR] Falliti: $failCount" $ColorError
Write-Host ""

# Verifica finale
Write-ColorOutput "====================================================================" $ColorInfo
Write-ColorOutput "VERIFICA FINALE / FINAL CHECK" $ColorInfo
Write-ColorOutput "====================================================================" $ColorInfo
Write-Host ""

$allOk = $true

# Python
if (Test-CommandExists "python") {
    $pythonVersion = (python --version 2>&1).ToString().Trim()
    Write-ColorOutput "[OK] Python: $pythonVersion" $ColorSuccess
} else {
    Write-ColorOutput "[ERROR] Python: NON TROVATO" $ColorError
    $allOk = $false
}

# ImageMagick
if (Test-CommandExists "magick") {
    Write-ColorOutput "[OK] ImageMagick: OK" $ColorSuccess
} else {
    Write-ColorOutput "[ERROR] ImageMagick: NON TROVATO" $ColorError
    $allOk = $false
}

# PDF Tool
if (Test-CommandExists "pdftk") {
    Write-ColorOutput "[OK] PDF Tool: pdftk" $ColorSuccess
} elseif (Test-CommandExists "gswin64c") {
    Write-ColorOutput "[OK] PDF Tool: Ghostscript 64-bit" $ColorSuccess
} elseif (Test-CommandExists "gswin32c") {
    Write-ColorOutput "[OK] PDF Tool: Ghostscript 32-bit" $ColorSuccess
} else {
    Write-ColorOutput "[ERROR] PDF Tool: NESSUNO TROVATO" $ColorError
    $allOk = $false
}

# RAR Tool
if (Test-CommandExists "7z") {
    Write-ColorOutput "[OK] RAR Tool: 7-Zip" $ColorSuccess
} elseif (Test-CommandExists "unrar") {
    Write-ColorOutput "[OK] RAR Tool: unrar" $ColorSuccess
} elseif (Test-Path "C:\Program Files\WinRAR\WinRAR.exe") {
    Write-ColorOutput "[OK] RAR Tool: WinRAR" $ColorSuccess
} else {
    Write-ColorOutput "[WARN] RAR Tool: NESSUNO TROVATO (file CBR potrebbero fallire)" $ColorWarning
}

# img2pdf
if (Test-CommandExists "python") {
    $img2pdfCheck = python -m pip show img2pdf 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-ColorOutput "[OK] img2pdf: OK" $ColorSuccess
    } else {
        Write-ColorOutput "[ERROR] img2pdf: NON INSTALLATO" $ColorError
        $allOk = $false
    }
}

Write-Host ""
Write-ColorOutput "====================================================================" $ColorInfo

if ($allOk) {
    Write-ColorOutput "`n[SUCCESS] INSTALLAZIONE COMPLETATA CON SUCCESSO!" $ColorSuccess
    Write-ColorOutput "[SUCCESS] INSTALLATION COMPLETED SUCCESSFULLY!" $ColorSuccess
    Write-Host ""
    Write-ColorOutput "Puoi ora eseguire Advanced-Comics-Converter.ps1" $ColorSuccess
    Write-ColorOutput "You can now run Advanced-Comics-Converter.ps1" $ColorSuccess
} else {
    Write-ColorOutput "`n[WARN] INSTALLAZIONE COMPLETATA CON ERRORI" $ColorWarning
    Write-ColorOutput "[WARN] INSTALLATION COMPLETED WITH ERRORS" $ColorWarning
    Write-Host ""
    Write-ColorOutput "Alcuni componenti potrebbero richiedere:" $ColorWarning
    Write-ColorOutput "  1. Riavvio di PowerShell" $ColorWarning
    Write-ColorOutput "  2. Installazione manuale" $ColorWarning
    Write-Host ""
    Write-ColorOutput "Consulta README-WINDOWS.md per l'installazione manuale." $ColorInfo
}

Write-Host ""
Write-ColorOutput "====================================================================" $ColorInfo
Write-Host ""

Read-Host "Premi INVIO per uscire"
