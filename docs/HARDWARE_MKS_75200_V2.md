# MKS 75200 V2 — Hardware Baseline v0.2

## Opis

Ten dokument definiuje zweryfikowaną bazę sprzętową dla VESC Package. Nie traktuje niepotwierdzonego mapowania MCU GPIO jako faktu.

## Zweryfikowane informacje

| Element | Wartość | Status |
|---|---|---|
| Kontroler | Makerbase MKSESC 75200 V2 | VERIFIED |
| MCU | STM32F405RG / RGT6 | VERIFIED |
| Rdzeń | ARM Cortex-M4 + FPU/DSP | VERIFIED |
| Napięcie wg instrukcji | 14–84 V | VERIFIED |
| Firmware model | `mksesc_75_200_v2` | VERIFIED |
| Historyczny firmware domyślny | V6.02 | VERIFIED |
| **Projektowy firmware minimum** | **V7.00** | **PROJECT REQUIREMENT** |
| Maks. ERPM podawane przez producenta/instrukcję | 150000 | VERIFIED |
| PPM | dostępny | VERIFIED |
| CAN | dostępny | VERIFIED |
| UART | dostępny | VERIFIED |
| USB | dostępny | VERIFIED |
| COMM | dostępny | VERIFIED |
| SENSOR | ABI/HALL/AS5047/AS5048A | VERIFIED |
| ADC | dostępny przez interfejs sterowania | VERIFIED |

## Firmware policy

Projekt nie wspiera już firmware 6.x jako konfiguracji docelowej.

```text
MINIMUM_FW = 7.00
SUPPORTED = 7.00+
```

Oficjalny changelog VESC Tool wskazuje wydanie 7.00 z 2026-05-15 oraz zmiany obejmujące LispBM, remapowanie pinów AS5047 i Hall oraz nowe rozszerzenia/parametry. Przed release sprawdzimy konkretny build 7.00.x używany na MKS 75200 V2.

## Interfejsy zidentyfikowane na poziomie złącza

- USB — konfiguracja VESC Tool.
- PPM — wejście RC/servo.
- CAN — komunikacja CAN.
- UART2 — komunikacja szeregowa; dokumentacja wskazuje m.in. użycie z modułem Bluetooth.
- SWD — debugowanie/programowanie.
- COMM — port komunikacyjny.
- SENSOR — wejścia czujników silnika.

## ADC

Instrukcja MKS 75200 V2 podaje, że wejścia ADC akceptują maksymalnie sygnał 3,3 V. Nie wolno zakładać, że wejście ADC jest tolerancyjne na 5 V.

## Wersje sprzętu

MKS dokumentuje różnicę pomiędzy starszą i nowszą wersją 75200 V2. Jednostki sprzed 15 listopada 2023 r. mają inne wymagania dotyczące phase filtering; nowsza wersja obsługuje phase filtering i używa modelu firmware `MKSESC_75200_V2`.

Package musi wykrywać/udokumentować wersję sprzętu i firmware przed użyciem funkcji zależnych od tej różnicy.

## Czego jeszcze NIE ustalamy

Poniższe elementy wymagają schematu PCB lub jednoznacznego pinoutu konkretnej rewizji:

- STM32 GPIO → ADC channel mapping.
- STM32 GPIO → ICU mapping.
- dokładny pin PPM.
- dokładne piny COMM.
- dokładne piny UART2.
- dokładne piny CAN.
- dokładne mapowanie HALL1/HALL2/HALL3 do MCU.
- dokładne mapowanie dodatkowych ADC/GPIO.
- możliwość bezpośredniego wykorzystania konkretnego wejścia przez LispBM.

Nie wpisujemy tych danych do kodu Package, dopóki nie zostaną zweryfikowane.

## Źródła

1. Makerbase VESC-MKS: https://github.com/makerbase-mks/VESC-MKS
2. Makerbase MKSESC 75200 V2 User Manual.
3. VESC firmware/LispBM documentation.
4. VESC Tool firmware changelog.

## Wniosek

Na obecnym etapie możemy bezpiecznie przygotować warstwę abstrakcji hardware, ale nie powinniśmy jeszcze przypisywać PAS ani czujnika prędkości BBS02B do konkretnych GPIO.
