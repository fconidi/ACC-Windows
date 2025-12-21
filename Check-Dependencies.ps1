# Check-Dependencies.ps1
# Script per verificare le dipendenze installate
# Script to check installed dependencies

<#
.SYNOPSIS
    Verifica quali dipendenze sono installate per Advanced Comics Converter
    
.DESCRIPTION
    Questo script NON installa nulla, verifica solo cosa e' presente
    e fornisce i link per l'installazione manuale
#>

$ErrorActionPreference = "SilentlyContinue"

function Test-CommandExists {
    param([string]$Command)
    return $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

# Banner
Write-Host ""
Write-Host "====================================================================" -ForegroundColor Cyan
Write-Host "     Advanced Comics Converter - Verifica Dipendenze              " -ForegroundColor Cyan
Write-Host "     Advanced Comics Converter - Dependencies Check               " -ForegroundColor Cyan
Write-Host "====================================================================" -ForegroundColor Cyan
Write-Host ""

$allOk = $true
$missing = @()

# ============================================================================
# VERIFICA PYTHON
# ============================================================================

Write-Host "[1] Python 3..." -ForegroundColor Cyan

if (Test-CommandExists "python") {
    try {
        $pythonVersion = (python --version 2>&1).ToString().Trim()
        if ($pythonVersion -match "Python \d+\.\d+") {
            Write-Host "    [OK] $pythonVersion" -ForegroundColor Green
        } else {
            Write-Host "    [ERROR] Python trovato ma non funziona correttamente" -ForegroundColor Red
            Write-Host "           Output: $pythonVersion" -ForegroundColor Yellow
            $allOk = $false
            $missing += @{
                Name = "Python 3"
                Url = "https://www.python.org/downloads/"
                Notes = "Seleziona 'Add Python to PATH' durante installazione"
            }
        }
    } catch {
        Write-Host "    [ERROR] Python trovato ma genera errori" -ForegroundColor Red
        $allOk = $false
        $missing += @{
            Name = "Python 3"
            Url = "https://www.python.org/downloads/"
            Notes = "Reinstalla e seleziona 'Add Python to PATH'"
        }
    }
} elseif (Test-CommandExists "py") {
    try {
        $pythonVersion = (py --version 2>&1).ToString().Trim()
        Write-Host "    [OK] $pythonVersion (usa comando 'py')" -ForegroundColor Green
    } catch {
        Write-Host "    [ERROR] py trovato ma non funziona" -ForegroundColor Red
        $allOk = $false
        $missing += @{
            Name = "Python 3"
            Url = "https://www.python.org/downloads/"
            Notes = "Reinstalla Python"
        }
    }
} else {
    Write-Host "    [ERROR] Python NON trovato" -ForegroundColor Red
    $allOk = $false
    $missing += @{
        Name = "Python 3"
        Url = "https://www.python.org/downloads/"
        Notes = "IMPORTANTE: Seleziona 'Add Python to PATH' durante installazione"
    }
}

# ============================================================================
# VERIFICA IMG2PDF
# ============================================================================

Write-Host "`n[2] img2pdf (modulo Python)..." -ForegroundColor Cyan

if (Test-CommandExists "python") {
    $img2pdfCheck = python -m pip show img2pdf 2>&1
    if ($LASTEXITCODE -eq 0) {
        $version = ($img2pdfCheck | Select-String "Version:").ToString().Replace("Version:", "").Trim()
        Write-Host "    [OK] img2pdf $version" -ForegroundColor Green
    } else {
        Write-Host "    [ERROR] img2pdf NON installato" -ForegroundColor Red
        Write-Host "           Installa con: pip install img2pdf" -ForegroundColor Yellow
        $allOk = $false
        $missing += @{
            Name = "img2pdf"
            Command = "pip install img2pdf"
            Notes = "Richiede Python installato"
        }
    }
} elseif (Test-CommandExists "py") {
    $img2pdfCheck = py -m pip show img2pdf 2>&1
    if ($LASTEXITCODE -eq 0) {
        $version = ($img2pdfCheck | Select-String "Version:").ToString().Replace("Version:", "").Trim()
        Write-Host "    [OK] img2pdf $version" -ForegroundColor Green
    } else {
        Write-Host "    [ERROR] img2pdf NON installato" -ForegroundColor Red
        Write-Host "           Installa con: py -m pip install img2pdf" -ForegroundColor Yellow
        $allOk = $false
        $missing += @{
            Name = "img2pdf"
            Command = "py -m pip install img2pdf"
            Notes = "Richiede Python installato"
        }
    }
} else {
    Write-Host "    [SKIP] Impossibile verificare (Python mancante)" -ForegroundColor Yellow
}

# ============================================================================
# VERIFICA IMAGEMAGICK
# ============================================================================

Write-Host "`n[3] ImageMagick..." -ForegroundColor Cyan

if (Test-CommandExists "magick") {
    try {
        $magickVersion = (magick --version 2>&1 | Select-Object -First 1).ToString().Trim()
        Write-Host "    [OK] ImageMagick installato" -ForegroundColor Green
        Write-Host "         $magickVersion" -ForegroundColor Gray
    } catch {
        Write-Host "    [WARN] ImageMagick trovato ma genera errori" -ForegroundColor Yellow
    }
} else {
    Write-Host "    [ERROR] ImageMagick NON trovato" -ForegroundColor Red
    $allOk = $false
    $missing += @{
        Name = "ImageMagick"
        Url = "https://imagemagick.org/script/download.php#windows"
        Notes = "Scarica ImageMagick-7.x.x-Q16-HDRI-x64-dll.exe e seleziona 'Add to PATH'"
    }
}

# ============================================================================
# VERIFICA PDF TOOLS
# ============================================================================

Write-Host "`n[4] Tool PDF (pdftk o Ghostscript)..." -ForegroundColor Cyan

$pdfToolFound = $false

if (Test-CommandExists "pdftk") {
    Write-Host "    [OK] pdftk trovato" -ForegroundColor Green
    $pdfToolFound = $true
}

if (Test-CommandExists "gswin64c") {
    Write-Host "    [OK] Ghostscript 64-bit trovato" -ForegroundColor Green
    $pdfToolFound = $true
} elseif (Test-CommandExists "gswin32c") {
    Write-Host "    [OK] Ghostscript 32-bit trovato" -ForegroundColor Green
    $pdfToolFound = $true
}

if (-not $pdfToolFound) {
    Write-Host "    [ERROR] Nessun tool PDF trovato" -ForegroundColor Red
    $allOk = $false
    $missing += @{
        Name = "Ghostscript o PDFtk"
        Url = "https://www.ghostscript.com/download/gsdnld.html"
        Notes = "Scarica Ghostscript 10.x for Windows (64 bit)"
    }
}

# ============================================================================
# VERIFICA RAR TOOLS
# ============================================================================

Write-Host "`n[5] Tool RAR (per file CBR)..." -ForegroundColor Cyan

$rarToolFound = $false

if (Test-CommandExists "7z") {
    Write-Host "    [OK] 7-Zip trovato" -ForegroundColor Green
    $rarToolFound = $true
}

if (Test-CommandExists "unrar") {
    Write-Host "    [OK] unrar trovato" -ForegroundColor Green
    $rarToolFound = $true
}

if (Test-Path "C:\Program Files\WinRAR\WinRAR.exe") {
    Write-Host "    [OK] WinRAR trovato" -ForegroundColor Green
    $rarToolFound = $true
}

if (-not $rarToolFound) {
    Write-Host "    [WARN] Nessun tool RAR trovato (file CBR potrebbero fallire)" -ForegroundColor Yellow
    Write-Host "           Non critico per file CBZ" -ForegroundColor Gray
    $missing += @{
        Name = "7-Zip (opzionale)"
        Url = "https://www.7-zip.org/download.html"
        Notes = "Necessario solo per file CBR. Installa 7-Zip 64-bit"
    }
}

# ============================================================================
# RIEPILOGO
# ============================================================================

Write-Host ""
Write-Host "====================================================================" -ForegroundColor Cyan
Write-Host "RIEPILOGO / SUMMARY" -ForegroundColor Cyan
Write-Host "====================================================================" -ForegroundColor Cyan

if ($allOk) {
    Write-Host ""
    Write-Host "[SUCCESS] Tutte le dipendenze sono installate correttamente!" -ForegroundColor Green
    Write-Host "[SUCCESS] All dependencies are correctly installed!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Puoi eseguire:" -ForegroundColor Green
    Write-Host "  .\Advanced-Comics-Converter.ps1" -ForegroundColor White
    Write-Host "  .\Advanced-Comics-Converter-DragDrop.ps1" -ForegroundColor White
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "[WARN] Alcune dipendenze sono mancanti" -ForegroundColor Yellow
    Write-Host "[WARN] Some dependencies are missing" -ForegroundColor Yellow
    Write-Host ""
    
    if ($missing.Count -gt 0) {
        Write-Host "Dipendenze mancanti / Missing dependencies:" -ForegroundColor Yellow
        Write-Host ""
        
        foreach ($item in $missing) {
            Write-Host "  [-] $($item.Name)" -ForegroundColor Red
            
            if ($item.Url) {
                Write-Host "      Download: $($item.Url)" -ForegroundColor Cyan
            }
            
            if ($item.Command) {
                Write-Host "      Comando: $($item.Command)" -ForegroundColor Cyan
            }
            
            if ($item.Notes) {
                Write-Host "      Note: $($item.Notes)" -ForegroundColor Gray
            }
            
            Write-Host ""
        }
    }
    
    Write-Host "Dopo aver installato le dipendenze mancanti:" -ForegroundColor Yellow
    Write-Host "  1. Chiudi e riapri PowerShell" -ForegroundColor White
    Write-Host "  2. Esegui di nuovo questo script per verificare" -ForegroundColor White
    Write-Host "  3. Esegui il converter" -ForegroundColor White
    Write-Host ""
}

Write-Host "====================================================================" -ForegroundColor Cyan
Write-Host ""

# Offri di aprire i link
if ($missing.Count -gt 0) {
    $response = Read-Host "Vuoi aprire i link di download nel browser? (S/N)"
    
    if ($response -eq "S" -or $response -eq "s" -or $response -eq "Y" -or $response -eq "y") {
        foreach ($item in $missing) {
            if ($item.Url) {
                Write-Host "Apertura: $($item.Name)..." -ForegroundColor Cyan
                Start-Process $item.Url
                Start-Sleep -Seconds 1
            }
        }
    }
}

Write-Host ""
Read-Host "Premi INVIO per uscire"
