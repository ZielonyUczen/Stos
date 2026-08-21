# VESC Package — Data Flow v0.1

## Cel

Zdefiniowanie przepływu danych przed implementacją właściwego LispBM i QML.

```text
BBS02B sensors
     │
     ▼
VESC hardware inputs
     │
     ▼
VESC firmware / LispBM API
     │
     ▼
LispBM acquisition
     │
     ├── validation
     ├── filtering
     ├── state machine
     ├── safety checks
     └── calculations
     │
     ▼
Package telemetry model
     │
     ├──────────────► logging
     │
     ▼
custom app data
     │
     ▼
VESC Tool
     │
     ▼
QML data model
     │
     ├── Dashboard
     ├── Configuration
     ├── Diagnostics
     └── Calibration
```

## Zasada

QML nie steruje bezpośrednio wejściami sprzętowymi. QML wysyła żądania konfiguracji/komend do warstwy aplikacyjnej, a LispBM wykonuje walidację i decyduje, czy operacja jest dozwolona.

## Telemetria

Rozdzielamy:

1. natywne `MC_VALUES` VESC,
2. własną telemetrię BBS02B Package.

Natywne dane nie będą ponownie kodowane w custom telemetry, jeżeli mogą być pobrane bezpośrednio przez VESC Tool.

## Custom telemetry — propozycja v0.1

```text
version
message_type
sequence
flags
speed
wheel_rpm
motor_erpm
cadence_rpm
pas_level
gear
battery_voltage
battery_current
motor_current
input_power
motor_power
duty
motor_temperature
mos_temperature
fault_code
state
```

To jest propozycja modelu, a nie jeszcze finalny wire format. Typy, skale, endianess i CRC zostaną zamknięte w osobnej specyfikacji protokołu.
