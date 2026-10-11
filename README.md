# Advanced Comics Converter — ACC-Windows 2.2.1

[Italiano](#italiano) | [English](#english)

Converte fumetti **CBZ e CBR in PDF** con un'interfaccia grafica per Windows.
Converts **CBZ and CBR comics to PDF** through a Windows graphical interface.

## Download

**ACC-Windows-2.2.1-win64.exe** è disponibile su Buy Me a Coffee / is available on Buy Me a Coffee:

https://buymeacoffee.com/fconidi/e/491165

<img width="230" height="230" alt="ACC-Windows QR" src="https://github.com/user-attachments/assets/0f4c13b6-bf73-4fd8-a0e0-a8fac2ad4fa8" />

## Italiano

### Versione 2.2.1

La versione portatile include Python, i moduli per la creazione dei PDF, `rarfile` e 7-Zip per leggere i CBR. Basta avviare il file EXE: non occorre installare dipendenze, usare pip o configurare il PATH. Le conversioni avvengono sul computer e non richiedono una connessione Internet.


### Requisiti

- Windows 10 o Windows 11 **a 64 bit (x64)**.
- Windows PowerShell di sistema disponibile.
- Spazio libero nella cartella temporanea e nel disco di destinazione per immagini estratte e PDF.
- Permesso di scrittura nella cartella dove salvare i PDF.

### Avvio rapido

1. Scarica **ACC-Windows-2.2.1-win64.exe** dal link Buy Me a Coffee qui sopra. Se il download è uno ZIP, estrailo prima.
2. Salva l'EXE in una cartella a tua scelta.
3. Fai doppio clic sull'EXE **come utente normale** e attendi l'apertura della finestra.
4. Trascina un fumetto CBZ o CBR nella finestra e premi **Converti**.
5. Con destinazione vuota, troverai il PDF accanto al fumetto originale.

All'avvio il programma prepara i componenti inclusi in una cartella temporanea; alla chiusura li rimuove. Per usare l'edizione EXE è sufficiente il solo eseguibile.

### Guida alla conversione

1. **Aggiungi fumetti.** Trascina file o cartelle nell'area dedicata, oppure premi **Aggiungi file** o **Aggiungi cartella**. Le cartelle vengono cercate anche nelle sottocartelle; i duplicati nella lista vengono ignorati.
2. **Scegli la destinazione.** Lascia vuota **Cartella di destinazione** per creare ogni PDF accanto al relativo archivio, oppure seleziona una cartella comune.
3. **Controlla le opzioni.** Puoi lasciare i valori predefiniti per la prima conversione. Le opzioni sono descritte nella tabella seguente.
4. **Premi Converti.** La lista mostra lo stato dei fumetti, il numero di pagine e il percorso del PDF. La barra di avanzamento indica i fumetti completati.
5. **Apri i risultati.** Fai doppio clic su una riga convertita o già verificata per aprire il PDF. Seleziona una riga per leggere i dettagli; **Apri log** mostra il registro del batch.

Esempio: `C:\Fumetti\Volume 01.cbz` diventa `C:\Fumetti\Volume 01.pdf`. Con destinazione `D:\PDF`, diventa `D:\PDF\Volume 01.pdf`.

| Opzione | Effetto |
| --- | --- |
| Processi = 0 | Scelta automatica, fino a quattro fumetti contemporaneamente. |
| Processi da 1 a 64 | Numero massimo di conversioni contemporanee; riducilo se la memoria disponibile è poca. |
| Timeout | Tempo massimo per ciascun fumetto; il valore predefinito è 30 minuti. |
| Sostituisci PDF esistenti | Consente di ricreare i PDF già presenti nella destinazione. |
| Annulla | Interrompe il batch in corso. |
| Riprova falliti | Riprende soltanto i fumetti falliti o annullati. |

La finestra resta aperta alla fine del lavoro. Chiuderla durante una conversione annulla i processi in corso.

### PDF esistenti e qualità delle pagine

Gli archivi originali vengono conservati. Le pagine seguono l'ordine naturale dei nomi e delle sottocartelle: `1, 2, 10`. Sono supportate immagini JPG/JPEG, PNG, GIF, WebP e BMP; per le GIF animate viene usato il primo fotogramma. I JPEG compatibili vengono incorporati direttamente e gli altri formati non vengono ricompressi in JPEG con perdita.

Un PDF viene indicato come **Già verificato** soltanto se è valido, ha il numero di pagine atteso e corrisponde all'archivio originale invariato. Per sostituire un PDF di una vecchia versione, modificato o non corrispondente, attiva **Sostituisci PDF esistenti**.

Se una pagina non è leggibile, quel fumetto fallisce e gli altri continuano. Il nuovo PDF viene pubblicato dopo la verifica: un errore o annullamento prima della pubblicazione conserva l'eventuale PDF precedente. Se due fumetti produrrebbero lo stesso nome nella cartella di destinazione, il programma segnala il conflitto.

### Lingua dell'interfaccia

L'app riconosce automaticamente la lingua dell'interfaccia Windows e supporta **italiano, inglese, spagnolo, tedesco e francese**. Le varianti regionali usano la relativa lingua; per le lingue non supportate viene usato l'inglese. I dettagli tecnici degli errori e i log del motore restano in inglese.

### Problemi comuni

| Problema | Cosa controllare |
| --- | --- |
| Il trascinamento non funziona | Avvia l'EXE come utente normale. Puoi anche usare Aggiungi file o Aggiungi cartella. |
| L'EXE non apre la finestra o mostra un errore | Attendi la preparazione iniziale; controlla il messaggio e il log di avvio indicato sotto. |
| Compare Python o rarfile mancante | Verifica di avere avviato l'EXE 2.2.1 scaricato, che include questi componenti. Le istruzioni di installazione degli script precedenti non servono per questo EXE. |
| Un fumetto fallisce | Seleziona la riga e apri il log. Controlla che l'archivio sia integro, non cifrato e contenga immagini leggibili. |
| Il PDF esiste già | Controlla se è Già verificato; per ricrearlo abilita Sostituisci PDF esistenti. |
| Destinazione non scrivibile o spazio insufficiente | Scegli una cartella scrivibile e libera spazio sul disco di destinazione. |
| Conversione troppo pesante o timeout | Riduci i processi contemporanei oppure aumenta il timeout per fumetti molto grandi. |

Per trovare i registri, incolla questi percorsi nella barra di Esplora file:

- Log delle conversioni: `%LOCALAPPDATA%\ACC-Windows\Logs`
- Errori di avvio: `%LOCALAPPDATA%\ACC-Windows\startup-error.log`

I limiti predefiniti sono 20.000 voci per archivio, 10 GiB dichiarati non compressi e 40 milioni di pixel per immagine. Gli archivi cifrati non sono supportati.

Per segnalare un problema, indica versione dell'app, versione di Windows, formato CBZ/CBR e messaggio di errore, aggiungendo il log pertinente.

### Aggiornamento e vecchi script

Per aggiornare, chiudi il programma e usa il nuovo EXE scaricato da Buy Me a Coffee. I fumetti e i PDF già salvati restano nelle rispettive cartelle.

Gli script `Install-Dependencies.ps1` e `Check-Dependencies.ps1` presenti nel repository appartengono alla distribuzione precedente. Per la versione portatile 2.2.1 segui questa guida: Python, moduli PDF e decoder CBR sono già inclusi. ImageMagick, Ghostscript e PDFtk non sono necessari al nuovo motore.

## English

### Version 2.2.1

The portable executable includes Python, the PDF modules, `rarfile` and 7-Zip for CBR decoding. Conversion runs locally and works offline. No dependency installation, pip commands or PATH configuration are required.


### Requirements and quick start

You need **64-bit (x64) Windows 10 or 11**, the system Windows PowerShell, and enough free space for temporary components, extracted images and output PDFs. The output folder must be writable.

1. Download **ACC-Windows-2.2.1-win64.exe** from the Buy Me a Coffee link above. Extract it first if provided in a ZIP.
2. Save the EXE in a folder of your choice.
3. Double-click it **as a regular user** and allow it to prepare its included components.
4. Drag a CBZ or CBR comic into the window and click **Convert**.
5. With the output folder left blank, the PDF is saved beside the original comic.

Only the EXE is needed for this edition. Its included components are extracted to a temporary folder and removed when the app closes.

### Conversion guide

1. Drag files or folders into the drop area, or use **Add files** / **Add folder**. Folders are searched recursively; duplicate list entries are ignored.
2. Leave **Output folder** blank to save each PDF beside its archive, or select a shared destination.
3. Keep the default settings for your first conversion, then click **Convert**.
4. Follow each comic's status, page count and output path in the list.
5. Double-click a converted or already verified entry to open its PDF. Select a row for details or click **Open log** to view the batch log.

Example: `C:\Comics\Volume 01.cbz` becomes `C:\Comics\Volume 01.pdf`. With output folder `D:\PDF`, the result is `D:\PDF\Volume 01.pdf`.

| Option | Effect |
| --- | --- |
| Processes = 0 | Automatic selection, capped at four simultaneous comics. |
| Processes from 1 to 64 | Maximum simultaneous conversions; reduce this when memory is limited. |
| Timeout | Maximum time per comic; 30 minutes by default. |
| Replace existing PDFs | Allows existing destination PDFs to be recreated. |
| Cancel | Stops the current batch. |
| Retry failed | Retries only failed or cancelled comics. |

The window stays open after conversion. Closing it during conversion cancels the active processes.

### Page quality and existing PDFs

Original archives are kept. Pages follow natural filename and subfolder ordering (`1, 2, 10`). JPG/JPEG, PNG, GIF, WebP and BMP are supported; animated GIFs use their first frame. Compatible JPEGs are embedded directly; other formats are not converted to lossy JPEG.

An output is marked **Already verified** only when PDF validation, page count and the unchanged source archive's fingerprint match. Enable **Replace existing PDFs** to recreate older, modified or mismatched PDFs.

Unreadable images fail that comic while the rest of the batch continues. Output is verified before publication; an error or cancellation before publication preserves any previous PDF. Conflicting output names are reported.

### Interface language

The app detects the Windows display language and supports **English, Italian, Spanish, German and French**, including regional variants. Other languages fall back to English. Technical error details and engine logs remain in English.

### Troubleshooting

| Problem | What to check |
| --- | --- |
| Drag and drop fails | Run the EXE as a regular user, or use Add files / Add folder. |
| The window does not open | Allow initial preparation to finish, then check any error message and the startup log below. |
| Python or rarfile is reported missing | Check that you launched the downloaded 2.2.1 EXE, which includes both. |
| A comic fails | Select its row and open the log. Check for a damaged/encrypted archive or unreadable images. |
| A PDF already exists | Check whether it is Already verified; enable Replace existing PDFs to recreate it. |
| Cannot write output | Choose a writable folder and check free disk space. |
| Heavy conversion or timeout | Reduce simultaneous processes or increase the timeout for large comics. |

Paste these paths into File Explorer to find logs:

- Conversion logs: `%LOCALAPPDATA%\ACC-Windows\Logs`
- Startup errors: `%LOCALAPPDATA%\ACC-Windows\startup-error.log`

Default limits are 20,000 archive entries, 10 GiB declared uncompressed size and 40 million pixels per image. Encrypted archives are unsupported. When reporting a problem, include the app version, Windows version, CBZ/CBR format, error message and relevant log.

### Updating and older scripts

Close the app and use the new EXE downloaded from Buy Me a Coffee. Saved comics and PDFs stay in their folders.

The repository's `Install-Dependencies.ps1` and `Check-Dependencies.ps1` belong to the earlier distribution. Follow this guide for the portable 2.2.1 edition, which includes its dependencies. The new conversion engine does not require ImageMagick, Ghostscript or PDFtk.

## Video

Video dimostrativo della versione precedente / Demonstration of the previous version:

[![Advanced Comics Converter (ACC-Windows)](https://img.youtube.com/vi/4k-5JvSYeko/hqdefault.jpg)](https://www.youtube.com/watch?v=4k-5JvSYeko)

## Autore / Author

Franco Conidi aka Edmond — System Integrator, Network Engineer, IT Consultant, Blogger, Linux Developer.

[francoconidi.it](https://francoconidi.it) · [syslinuxos.com](https://syslinuxos.com)

