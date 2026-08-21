# VESC Package Architecture v0.1

## Warstwy

```text
Hardware
   ↓
VESC firmware
   ↓
LispBM application
   ↓
Package protocol / telemetry
   ↓
QML data model
   ↓
QML UI / VESC Tool
```

## Zasady

- Krytyczne sterowanie silnikiem pozostaje w VESC firmware.
- LispBM realizuje logikę aplikacyjną i integrację sensorów.
- QML jest warstwą prezentacji i konfiguracji, nie warstwą bezpieczeństwa.
- Interfejs pomiędzy LispBM i QML musi być jawnie wersjonowany.
- Każde założenie sprzętowe musi zostać zweryfikowane przed użyciem w kodzie.

## Moduły LispBM

- `main.lisp` — inicjalizacja i główna pętla.
- `config.lisp` — konfiguracja.
- `pas.lisp` — PAS.
- `speed.lisp` — czujnik prędkości.
- `gears.lisp` — obliczenia przełożeń.
- `state.lisp` — maszyna stanów.
- `safety.lisp` — logika bezpieczeństwa aplikacyjnego.
- `telemetry.lisp` — telemetria.
- `protocol.lisp` — format komunikacji.

## Moduły QML

- `Dashboard.qml`
- `Configuration.qml`
- `Calibration.qml`
- `Diagnostics.qml`
- `Logs.qml`

Szczegóły protokołu i mapowania hardware będą uzupełniane po weryfikacji dokumentacji VESC i MKS 75200 v2.
