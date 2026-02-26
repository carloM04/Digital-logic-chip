### Panoramica
Questo progetto implementa un modulo hardware in VHDL che applica un filtro differenziale di 3° o 5° ordine a una sequenza di byte memorizzati in memoria. Il sistema gestisce dati in complemento a 2, esegue la normalizzazione tramite approssimazioni basate su shift e assicura che i risultati siano saturati nell'intervallo a 8 bit [-128, 127]. Maggiori dettagli presenti nel file di specifica.

### Caratteristiche
- **Architettura Strutturale:** Sviluppato senza FSM utilizzando un approccio strutturale stratificato per la massima trasparenza hardware.
- **Alte Prestazioni:** Ottimizzato per Xilinx Artix-7, ottenendo un Worst Negative Slack (WNS) di 13.673 ns su un clock di 20ns.
- **Precisione:** Implementa la correzione degli errori per gli shift di numeri negativi per mantenere l'accuratezza matematica.

### Struttura delle Cartelle
- `it_version/`: File originali del progetto in italiano.
  - `main.vhd`: File sorgente VHDL.
  - `test_bench/`: Files testbench VHDL.
  - `specifica`: Specifica originale del progetto.
  - `relaziona_finale`: Relazione finale originale.

### Come Eseguire
1. Aprire Xilinx Vivado (Qualunque verione dovrebbe funzionare).
2. Creare un nuovo progetto per Artix-7 `xc7a12ticsg325-1L`.
3. Aggiungere il file `main.vhd`.
4. Eseguire le simulazioni comportamentali e funzionali post-sintesi utilizzando i testbench forniti.
