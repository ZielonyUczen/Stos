# VESC Package — LispBM API Matrix

## Cel

Ten dokument jest kontraktem projektowym dla warstwy LispBM. Wpisujemy tutaj tylko API potwierdzone w dokumentacji VESC/LispBM. Konkretne mapowanie pinów MKS 75200 v2 pozostaje osobnym zadaniem i nie jest zgadywane.

## Projektowe wymaganie firmware

```text
MINIMUM_FW = 7.00
SUPPORTED = 7.00+
```

Poniższa tabela pokazuje minimalną wersję firmware, od której dane API jest udokumentowane. Jest to informacja źródłowa; Package i tak wymaga globalnie firmware 7.00+.

## 1. Runtime

| API | Platforma | Dokumentowane od FW | Zastosowanie |
|---|---|---:|---|
| `sleep` | ESC/Express | 6.00+ | okresowa pętla aplikacji |
| `print` | ESC/Express | 6.00+ | diagnostyka |
| `puts` | ESC/Express | 6.05+ | diagnostyka |
| `event-enable` | ESC/Express | 6.00+ | obsługa zdarzeń |
| `event-register-handler` | ESC/Express | 6.00+ | handler zdarzeń |

## 2. Sterowanie silnikiem

| API | Platforma | Dokumentowane od FW | Zastosowanie |
|---|---|---:|---|
| `set-current` | ESC | 6.00+ | żądanie prądu silnika |
| `app-disable-output` | ESC | 6.00+ | czasowe wyłączenie wyjścia aplikacji |
| `app-is-output-disabled` | ESC | 6.00+ | sprawdzenie blokady wyjścia |

### Zasada bezpieczeństwa

`set-current` nie będzie wywoływane bezpośrednio z QML. QML wysyła konfigurację/komendy, a LispBM waliduje je i dopiero wtedy steruje VESC.

## 3. PAS

| API | Platforma | Dokumentowane od FW | Zastosowanie |
|---|---|---:|---|
| `app-pas-get-rpm` | ESC | 6.00+ | odczyt RPM pedałów z aplikacji PAS |

Dokumentacja potwierdza również możliwość użycia `app-disable-output` do przejęcia kontroli nad wyjściem aplikacji PAS i implementacji własnego sterowania.

Dla naszego Package najpierw sprawdzimy, czy natywna aplikacja PAS zapewnia wszystkie potrzebne informacje. Dopiero jeśli nie, przejdziemy do własnej detekcji PAS.

## 4. Input Capture / speed sensor

| API | Platforma | Dokumentowane od FW | Zastosowanie |
|---|---|---:|---|
| `icu-start` | ESC | 6.02+ | pomiar szerokości/okresu impulsów |
| `icu-width` | ESC | 6.02+ | ostatnia szerokość impulsu |
| `icu-period` | ESC | 6.02+ | ostatni okres |
| `event-icu-width` | ESC | 6.02+ | zdarzenie impulsu |
| `event-icu-period` | ESC | 6.02+ | zdarzenie okresu |

ICU działa na wejściu PPM. To nie oznacza jeszcze, że wejście PPM MKS 75200 v2 jest właściwym fizycznym wejściem dla oryginalnego czujnika BBS02B. To zostanie zweryfikowane w analizie hardware.

## 5. CAN

| API | Platforma | Dokumentowane od FW | Zastosowanie |
|---|---|---:|---|
| `canget-dist` | ESC/Express | 6.00+ | dystans z VESC po CAN |
| `canget-speed` | ESC/Express | 6.00+ | prędkość z VESC po CAN |
| `canget-adc` | ESC/Express | 6.00+ | ADC z VESC po CAN |
| `canget-vin` | ESC/Express | 6.02+ | napięcie wejściowe po CAN |

## 6. Custom App Data

VESC Tool obsługuje `COMM_CUSTOM_APP_DATA`, a LispBM posiada zdarzenia związane z odbiorem danych (`event-data-rx`) i transmisją danych (`event-cmds-data-tx`).

To będzie podstawowy kanał dla własnej telemetrii Package.

Docelowo:

```text
LispBM
   │
   │ custom app data
   ▼
VESC firmware
   │
   ▼
VESC Tool Commands
   │
   ▼
QML customAppDataReceived()
```

## 7. Commands interface

`cmds-start-stop` uruchamia interfejs komend VESC. Nie będziemy uruchamiać go bez potrzeby.

## 8. Configuration API

Dokumentacja LispBM udostępnia odczyt/zapis wybranych parametrów aplikacji i silnika, m.in.:

- `controller-id`
- `timeout-msec`
- `can-baud-rate`
- `can-mode`
- `can-status-rate-*`
- `can-status-msgs-*`
- `ppm-ctrl-type`
- `adc-ramp-time-pos`
- `adc-ramp-time-neg`
- `adc-thr-hyst`
- `adc-v1-start`
- `adc-v1-end`
- `adc-v1-min`
- `adc-v1-max`
- `pas-current-scaling`

Nie wszystkie będą częścią konfiguracji Package. UI pokaże wyłącznie parametry, które mają uzasadnienie dla BBS02B.

## 9. Events

Istotne zdarzenia:

```text
event-can-sid
event-can-eid
event-data-rx
event-cmds-data-tx
event-shutdown
event-icu-width
event-icu-period
```

Będą używane przez centralny event dispatcher Package.

## 10. Import / libraries

LispBM obsługuje `import`, a VESC Tool może dołączać importowane pliki do pakowanego kodu. Dokumentacja podaje łączny limit około 120 KB dla skryptu i importowanych plików.

Na początku nie używamy native C libraries. Dodamy je dopiero wtedy, gdy LispBM API okaże się niewystarczające.

## 11. Logging

LispBM może logować dane do urządzeń logujących, w tym VESC Express po CAN. Package będzie miał własny model telemetrii, ale nie będzie dublował natywnych danych VESC bez potrzeby.

## 12. Wnioski dla naszego Package

### Obowiązujące

- firmware minimum: **7.00**
- okresowa pętla LispBM: `sleep`
- sterowanie prądem: `set-current`
- blokada wyjścia: `app-disable-output`
- odczyt RPM PAS: `app-pas-get-rpm`
- pomiar impulsów: ICU
- zdarzenia: event system
- komunikacja custom: custom app data
- integracja QML: `customAppDataReceived`
- pakowanie: VESC Tool / `.vescpkg`

### Nadal do zweryfikowania

- dokładne wejście fizyczne speed sensora BBS02B na MKS 75200 v2
- dokładne wejścia PAS1/PAS2
- dostępność konkretnych GPIO z LispBM na tej platformie
- właściwa metoda odczytu oryginalnego PAS BBS02B
- konkretny build 7.00.x używany podczas release

## Źródła

- VESC Lisp Documentation: https://www.lispbm.com/lispbm-reference-manual/html/vesc-lisp-documentation.html
- Official VESC Packages: https://github.com/vedderb/vesc_pkg
- VESC Tool commands: https://github.com/vedderb/vesc_tool/blob/master/commands.cpp
- VESC Tool QML example: https://github.com/vedderb/vesc_tool/blob/master/res/qml/Examples/SendToLbm.qml
