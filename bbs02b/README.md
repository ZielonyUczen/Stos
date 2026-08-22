# BBS02B VESC Package

Application package for a VESC-based Bafang BBS02B integration.

## Current scope

- LispBM application layer
- QML configuration/dashboard layer
- package descriptor
- documented telemetry and protocol interfaces

## Firmware requirement

**VESC firmware 7.00 or newer is required.**

The project baseline is `7.00+`. Individual APIs may have lower documented introduction versions, but that does not make older firmware supported by this Package.

## Target

- VESC MKS 75200 v2
- Bafang BBS02B
- 710 mm wheel
- 40T chainring
- 10-speed cassette

## Important

Hardware pin mapping and sensor electrical characteristics are not assumed here. They must be verified against authoritative documentation before implementation.
