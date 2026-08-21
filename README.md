# VESC Package — BBS02B

Projekt VESC Package dla kontrolera VESC MKS 75200 v2 i napędu Bafang BBS02B.

## Cel

Połączenie niskopoziomowego firmware VESC, LispBM oraz interfejsu QML/VESC Tool w jeden modularny pakiet aplikacyjny.

## Główne warstwy

1. Hardware — MKS 75200 v2, BBS02B i sensory.
2. VESC firmware — sterowanie silnikiem, zabezpieczenia i natywna telemetria.
3. LispBM — logika aplikacyjna, PAS, speed sensor, biegi, bezpieczeństwo i custom telemetry.
4. Protocol — kontrakt danych pomiędzy LispBM i UI.
5. QML — dashboard, konfiguracja, kalibracja i diagnostyka.
6. Package — manifest, wersjonowanie i zasoby.
7. Tests — testy obliczeń, protokołu i logiki.

## Projekt referencyjny

- Bafang BBS02B
- VESC MKS 75200 v2
- koło 710 mm
- tarcza 40T
- kaseta 10-rzędowa: 11/13/15/18/21/24/28/32/36/42T

## Status

Projekt jest na etapie architektury i specyfikacji. Dane sprzętowe oraz API VESC będą weryfikowane na podstawie dokumentacji źródłowej przed implementacją.
