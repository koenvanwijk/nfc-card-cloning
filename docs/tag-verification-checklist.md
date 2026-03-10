# Tag verification checklist (safe / read-only)

Doel: betrouwbaar vaststellen wat voor tag je voor je hebt, zonder schrijfacties.

## Voorbereiding

- Werk op een testopstelling waarvoor je toestemming hebt.
- Log elke run naar een bestand (datum + tag-id).
- Gebruik de script helper:
  - `scripts/proxmark_readonly_audit.sh /dev/ttyACM0`

## Checklist

1. **Radio/kaarttype detectie**
   - `hf search`
   - Noteer type-indicatie en eventuele collisions.

2. **ISO14443A info**
   - `hf 14a info`
   - Noteer: UID-lengte, ATQA, SAK, ATS (indien aanwezig).

3. **MIFARE Classic metadata**
   - `hf mf info`
   - Controleer sector/layout-herkenning.

4. **(Optioneel) sleutel-check op bekende testkeys**
   - `hf mf chk`
   - Alleen op eigen/test kaarten.

5. **Vergelijking bron/doel (zonder schrijven)**
   - Vergelijk alleen gedetecteerde metadata:
     - UID-lengte (4/7/10)
     - ATQA/SAK
     - protocolrespons
   - Markeer mismatchs als “niet compatibel voor 1-op-1 gedrag”.

## Resultaat-template

```text
Tag label:
Timestamp:
UID length:
ATQA:
SAK:
ATS:
Type guess:
MIFARE info summary:
Conclusion:
```

## Belangrijk

- Deze flow is bewust read-only.
- Geen UID-wijzigingen, geen block writes, geen dump restore.
