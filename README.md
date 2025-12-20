# Advanced Comics Converter (Windows)

> [🇮🇹 Versione Italiana](#versione-italiana) | [🇬🇧 English Version](#english-version)

---
---
---
[![ACC](https://img.youtube.com/vi/gxKtQuFBChE/hqdefault.jpg)](https://www.youtube.com/watch?v=gxKtQuFBChE)
----
----
----
----
## Versione Italiana

Script bash avanzato per la conversione automatica di file CBZ/CBR in formato PDF con interfaccia grafica Zenity.

----
----

DOWNLOAD

----
https://buymeacoffee.com/fconidi/e/489972
----

<img width="230" height="230" alt="ACC-LINUX-QR" src="https://github.com/user-attachments/assets/6384d315-ffa0-4863-b385-319660e02070" />


----
----

## 📋 Caratteristiche

- **Conversione automatica**: Trasforma tutti i file CBZ/CBR in PDF mantenendo la qualità delle immagini
- **Interfaccia grafica**: Utilizza Zenity per una selezione intuitiva delle directory e feedback visivo
- **Elaborazione parallela**: Sfrutta GNU Parallel per processare più file contemporaneamente (fino all'80% dei core disponibili)
- **Barra di progresso**: Visualizzazione in tempo reale dello stato di conversione
- **Validazione estensioni**: Controlla e corregge automaticamente le estensioni errate basandosi sui magic bytes
- **Test di integrità**: Verifica l'integrità dei file CBZ prima dell'estrazione
- **Supporto multi-formato RAR**: Tenta l'estrazione con rar, unar, unrar e 7z in sequenza
- **Riparazione automatica**: Utilizza `rar r` per tentare di riparare archivi CBR corrotti
- **Skip intelligente**: Salta automaticamente i file già convertiti
- **Logging selettivo**: Registra solo gli errori critici per facilitare il debugging
- **Pulizia automatica**: Rimuove file temporanei e metadati macOS

## 🔧 Requisiti

### Dipendenze obbligatorie

```bash
sudo apt install imagemagick img2pdf pdftk unzip zenity coreutils parallel
```

### Dipendenze ALTAMENTE CONSIGLIATA

installare Winrar per Linux https://www.win-rar.com/rar-linux-mac.html
