# Hardware Verification Checklist

## Opis

Lista dowodów wymaganych przed przypisaniem sygnału BBS02B do fizycznego wejścia MKS 75200 V2.

## Dokumentacja

- [x] Identyfikacja STM32F405RG/RGT6.
- [x] Identyfikacja interfejsów PPM/CAN/UART/USB/COMM/SENSOR.
- [x] Potwierdzenie ograniczenia ADC do 3,3 V.
- [x] Rozróżnienie starszej/nowszej rewizji 75200 V2.
- [ ] Oryginalny schemat PCB konkretnej rewizji.
- [ ] Jednoznaczny pinout złączy konkretnej rewizji.
- [ ] Mapowanie GPIO/ADC/ICU.

## BBS02B

- [ ] PAS1 — zmierzyć i udokumentować sygnał.
- [ ] PAS2 — zmierzyć i udokumentować sygnał.
- [ ] Speed sensor — zmierzyć typ sygnału.
- [ ] Zidentyfikować napięcie zasilania czujnika.
- [ ] Zidentyfikować poziom logiczny sygnału.
- [ ] Zmierzyć częstotliwość przy znanej prędkości.
- [ ] Potwierdzić kierunek/znaczenie PAS.

## Walidacja elektryczna

- [ ] Sprawdzenie napięcia przed podłączeniem.
- [ ] Sprawdzenie wspólnej masy.
- [ ] Sprawdzenie maksymalnego napięcia wejściowego.
- [ ] Test sygnału bez obciążenia.
- [ ] Test sygnału oscyloskopem/analityzatorem logicznym, jeśli wymagany.

## Status

`HARDWARE_PIN_MAPPING = NOT_FINAL`

Do czasu zakończenia tej listy Package nie powinien zawierać twardo zakodowanego mapowania PAS/speed sensor → GPIO.
