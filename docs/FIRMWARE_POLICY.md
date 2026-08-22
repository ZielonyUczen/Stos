# VESC Package — Firmware Policy

## Opis

Od tego momentu docelowa wersja firmware dla projektu VESC Package BBS02B to **VESC firmware 7.00 lub nowszy**.

Nie projektujemy już Package z minimalnym wymaganiem 6.x.

## Baseline

```text
MINIMUM_FW = 7.00
SUPPORTED_POLICY = 7.00+
```

## Dlaczego 7.00

Oficjalny changelog VESC Tool oznacza wersję 7.00 jako wydanie z 2026-05-15. W 7.00 wprowadzono m.in. poprawki i usprawnienia LispBM, remapowanie pinów AS5047, remapowanie pinów Hall oraz nowe rozszerzenia i parametry LispBM.

Źródło: VESC Tool `res/firmwares/CHANGELOG.md`.

## Zasada kompatybilności

Package musi odrzucić instalację/uruchomienie na firmware poniżej 7.00.

```text
FW < 7.00
  ↓
INCOMPATIBLE

FW >= 7.00
  ↓
VERSION CHECK PASSED
```

## API a wymaganie projektu

Dokumentacja może podawać niższą wersję minimalną dla pojedynczej funkcji, np. ICU od 6.02. Nie oznacza to, że Package wspiera 6.02.

Dla tego projektu obowiązuje:

```text
project minimum = 7.00
```

Czyli funkcja oznaczona w dokumentacji jako `6.02+` może być używana w Package bez dodatkowego fallbacku wersji 6.x, pod warunkiem że jest dostępna w firmware 7.00 dla docelowego hardware.

## 7.00 vs 7.00.x

Wymaganie projektu zapisujemy jako **7.00+**, ale przed finalnym release wykonamy osobną macierz testową dla konkretnego builda 7.00.x używanego na MKS 75200 V2.

Jeżeli konkretna funkcja wymaga np. 7.00.2+, zostanie oznaczona osobno i nie będzie automatycznie traktowana jako dostępna w bazowym 7.00.0.

## Hardware compatibility

Samo `FW >= 7.00` nie wystarcza. Package będzie sprawdzał również zgodność hardware:

- MKS 75200 V2,
- wymagane wejścia sensorów,
- dostępność wymaganych LispBM extensions,
- wersję/profil hardware.

## Status

`FIRMWARE_BASELINE = 7.00+`

`RELEASE_COMPATIBILITY = NOT_FINAL`
