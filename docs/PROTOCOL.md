# VESC Package — Protocol and Data Contract v1

## Status

The format below is the proposed Package contract. It is not yet implemented
or verified on VESC firmware 7.00.x. Sensor fields remain invalid until their
physical inputs and acquisition APIs have been verified on the target board.

## Configuration model

VESC `ConfigParams` remains the source of truth for motor configuration. The
settings screen stages edits locally, uses the parameter bounds and types
reported by firmware, and writes only after explicit confirmation. VESC Tool's
`setMcconf()` writes the complete motor configuration, so users must read the
controller immediately before writing.

The settings screen currently exposes these motor configuration parameters
when present in the connected firmware:

| Parameter | Unit |
|---|---|
| `l_current_max`, `l_current_min` | A |
| `l_in_current_max`, `l_in_current_min` | A |
| `l_battery_cut_start`, `l_battery_cut_end` | V |
| `l_temp_fet_start`, `l_temp_fet_end` | °C |

Numeric bounds and integer/floating-point types come from the connected
firmware's `ConfigParams` metadata; the Package does not override them.
The BBS02B preset is withheld until approved target values are available.

Sensor configuration will use the following units:

| Field | Unit | Current status |
|---|---|---|
| `wheel_diameter_mm` | mm | Range/value pending wheel measurement |
| `speed_sensor_pulses_per_wheel_rev` | pulses/revolution | Pending measurement |
| `speed_sensor_timeout_ms` | ms | Pending sensor/API validation |
| `speed_filter` | dimensionless | Filter and allowed range TBD |

No sensor configuration is active while hardware mapping is unverified.

## Custom telemetry frame

All multibyte values are unsigned/signed integers in little-endian order.

| Offset | Size | Field |
|---:|---:|---|
| 0 | 1 | Magic byte `0x53` (`S`) |
| 1 | 1 | Magic byte `0x54` (`T`) |
| 2 | 1 | Protocol version (`1`) |
| 3 | 1 | Message type |
| 4 | 2 | Sequence number, wrapping modulo 65536 |
| 6 | 2 | Payload length in bytes |
| 8 | variable | Payload |
| 8 + payload length | 2 | CRC-16/CCITT-FALSE, little-endian |

CRC-16/CCITT-FALSE uses polynomial `0x1021`, initial value `0xFFFF`, no
reflection, and xor-out `0x0000`; it covers bytes 0 through the end of the
payload.

### Message type `0x01`: telemetry

The payload is 18 bytes:

| Offset | Size | Field | Unit / encoding |
|---:|---:|---|---|
| 0 | 2 | Validity flags | Bitfield; reserved bits must be zero |
| 2 | 1 | Application state | `0` safe, `1` ready, `2` degraded, `3` fault |
| 3 | 1 | Fault code | `0` none, `1` hardware unverified, `2` invalid config, `3` invalid sensor, `4` stale sensor, `5` protocol error |
| 4 | 4 | Speed | mm/s; `0xFFFFFFFF` unavailable |
| 8 | 4 | Wheel rotation rate | milli-rpm; `0xFFFFFFFF` unavailable |
| 12 | 4 | Cadence | milli-rpm; `0xFFFFFFFF` unavailable |
| 16 | 1 | Gear | signed gear index; `0x7F` unavailable |
| 17 | 1 | PAS level | `0xFF` unavailable |

Validity flag bits 0–4 correspond to speed, wheel rotation rate, cadence,
gear, and PAS level, respectively. A consumer must ignore any field whose
validity bit is clear. Unknown message types, unsupported versions, malformed
lengths, invalid CRCs, and nonzero reserved bits must be rejected.

VESC-native telemetry remains sourced from VESC Tool and is not duplicated in
this custom frame unless a later documented requirement needs it. Configuration
READ/WRITE uses VESC Tool's `ConfigParams` and `Commands` APIs, not custom
telemetry messages.

## Safety-state contract

- Startup is `safe`; motor-current control is not enabled.
- `ready` is permitted only after firmware, hardware, configuration, and
  required sensor/API validation have all passed.
- Invalid or stale required sensor data transitions the application to
  `degraded` or `fault`; it must never increase a motor-current request.
- Hardware mappings remain unset until the exact board revision, signal
  voltages, logic levels, timing, and input API are verified.
- QML may stage configuration and request operations, but LispBM remains the
  authority for any future safety decision or motor-control behavior.
