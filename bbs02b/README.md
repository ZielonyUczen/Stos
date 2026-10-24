# BBS02B VESC Package

Application package for a VESC-based Bafang BBS02B integration.

## Current scope

- LispBM application layer
- ConfigParams-backed motor settings screen with staged edits and explicit READ/WRITE
- package descriptor
- versioned telemetry/data contract documented in `docs/PROTOCOL.md`

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

The package descriptor requires the MKS firmware hardware identifier
`mksesc_75_200_v2` and VESC firmware 7.00 or newer. Confirm that exact
identifier against the target firmware build before release.

Hardware pin mapping and sensor electrical characteristics remain unverified,
so sensor inputs are unmapped and motor-control behavior is disabled. The
BBS02B preset is withheld until approved configuration values are documented.
