### Panoramica
Questo progetto implementa un modulo hardware in VHDL che applica un filtro differenziale di 3° o 5° ordine a una sequenza di byte memorizzati in memoria. Il sistema gestisce dati in complemento a 2, esegue la normalizzazione tramite approssimazioni basate su shift e assicura che i risultati siano saturati nell'intervallo a 8 bit [-128, 127]. Maggiori dettagli presenti nel file di specifica.

**Importante:** Una versione di Xilinx Vivado dal 2016 in poi risulta necessaria per poter eseguire il progetto.

### Struttura delle Cartelle
- `main.vhd`: File sorgente VHDL.
- `test_bench/`: Files testbench VHDL.
- `specifica`: Specifica originale del progetto.
- `relaziona_finale`: Relazione finale originale.

### Come Eseguire
1. Aprire Xilinx Vivado (Qualunque verione dovrebbe funzionare).
2. Creare un nuovo progetto per Artix-7 `xc7a12ticsg325-1L`.
3. Aggiungere il file `main.vhd`.
4. Eseguire le simulazioni comportamentali e funzionali post-sintesi utilizzando i testbench forniti per verificare la correttezza del      componente progettato.

**Importante:** notare che il progetto è stato valutato su test creati e noti solo ai professori. I test qui presenti sono stati creati da me, con lo scopo di coprire più casistiche possibile e autovalutarmi prima della consegna.
