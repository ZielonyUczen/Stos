# VESC Package — lista prac

## Ustalenia globalne
- [x] Ustawić minimalny firmware projektu na VESC 7.00.
- [x] Zdefiniować politykę kompatybilności firmware 7.00+.

## Etap 0 — Specyfikacja
- [ ] Zweryfikować VESC firmware i wersję API dla konkretnego builda 7.00.x.
- [ ] Zweryfikować dokumentację MKS 75200 v2.
- [ ] Zdefiniować granice firmware / LispBM / QML.
- [x] Zdefiniować wstępny model danych i jednostki (`docs/PROTOCOL.md`).
- [x] Zdefiniować wersjonowany format telemetryczny (`docs/PROTOCOL.md`); implementacja nadal wymaga walidacji na FW 7.00.x.

## Etap 1 — Hardware
- [ ] Mapa pinów MKS 75200 v2.
- [ ] PAS1/PAS2.
- [ ] BBS02B speed sensor.
- [ ] ADC/GPIO.
- [ ] UART/CAN.
- [ ] Schemat połączeń.
- [x] Przygotować plan walidacji sensorów.
- [ ] Wykonać pomiary PAS1/PAS2.
- [ ] Wykonać pomiary speed sensora.
- [ ] Zamknąć mapowanie GPIO/ICU.
- [ ] Zweryfikować wymagane wejścia na firmware 7.00+.

## Etap 2 — LispBM
- [ ] Scheduler.
- [ ] State machine.
- [ ] PAS.
- [ ] Speed sensor.
- [ ] Gear engine.
- [ ] Safety.
- [ ] Telemetry.
- [ ] Protocol.
- [ ] Test kompilacji/uruchomienia na FW 7.00+.

## Etap 3 — QML
- [ ] Data model.
- [ ] Dashboard.
- [ ] Configuration.
- [ ] Calibration.
- [ ] Diagnostics.
- [ ] Logs.
- [x] Dedykowany edytor motor config z READ/WRITE i lokalnym stagingiem (`bbs02b/VescSettings.qml`).
- [ ] Zatwierdzić wartości presetu BBS02B przed jego włączeniem.
- [ ] Test kompatybilności Package dla FW <7.00 i >=7.00.

## Etap 4 — Package
- [ ] Manifest.
- [ ] Versioning.
- [ ] Resources.
- [x] Compatibility checks dla firmware 7.00+ i identyfikatora MKS 75200 V2; potwierdzić identyfikator na docelowym buildzie.
- [x] Wymaganie firmware 7.00+.

## Etap 5 — Testy
- [ ] Unit tests obliczeń.
- [ ] Test PAS.
- [ ] Test speed sensor.
- [ ] Test telemetry.
- [ ] Test protocol.
- [ ] Test configuration.
- [ ] Test safety.
- [ ] Test QML.
- [ ] Test hardware.
- [ ] Test firmware 7.00.x.

## Etap 6 — Release
- [ ] Dokumentacja instalacji.
- [ ] Dokumentacja konfiguracji.
- [ ] Release build.
- [ ] Final verification.
- [ ] GitHub Release.
