# VESC Package — lista prac

## Ustalenia globalne
- [x] Ustawić minimalny firmware projektu na VESC 7.00.
- [x] Zdefiniować politykę kompatybilności firmware 7.00+.

## Etap 0 — Specyfikacja
- [ ] Zweryfikować VESC firmware i wersję API dla konkretnego builda 7.00.x.
- [ ] Zweryfikować dokumentację MKS 75200 v2.
- [ ] Zdefiniować granice firmware / LispBM / QML.
- [ ] Zdefiniować model danych.
- [ ] Zdefiniować protokół telemetryczny.

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
- [ ] Test kompatybilności Package dla FW <7.00 i >=7.00.

## Etap 4 — Package
- [ ] Manifest.
- [ ] Versioning.
- [ ] Resources.
- [ ] Compatibility checks.
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
