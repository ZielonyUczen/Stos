# ETAP 1.5 — Sensor Validation Plan

## Opis

Ten dokument definiuje procedurę walidacji elektrycznej PAS1, PAS2 oraz zewnętrznego czujnika prędkości BBS02B przed implementacją właściwego sterownika LispBM.

Celem jest ustalenie rzeczywistego typu sygnału i jego parametrów dla konkretnego zestawu BBS02B + MKS 75200 V2. Nie zakładamy mapowania GPIO na podstawie podobnych kontrolerów.

## Fakty potwierdzone z dokumentacji

- MKS 75200 V2 udostępnia interfejsy PPM, Analog/ADC, UART, I2C, USB i CAN.
- Dokumentacja MKS podaje STM32F405RGT6.
- Wejścia analogowe nie mogą otrzymywać więcej niż 3,3 V.
- LispBM na VESC FW 6.02+ posiada Input Capture Unit (ICU) dla pinu PPM. ICU mierzy szerokość i okres impulsu.
- `app-pas-get-rpm` zwraca RPM pedałowania z istniejącej aplikacji PAS VESC. Nie oznacza to automatycznie, że możemy nim odczytać fizyczny PAS BBS02B podłączony do dowolnego GPIO.
- Dla BBS02B materiały użytkowników identyfikują typ PAS `DoubleSignal-24` jako 24 pola na obrót.
- Zewnętrzny speed sensor jest osobnym sensorem od PAS i jego liczba impulsów na obrót koła musi być parametrem konfiguracji.

Źródła: VESC LispBM Documentation, Makerbase MKSESC 75200 V2 manual oraz materiały dotyczące BBS02B.

## Procedura pomiarowa

### 1. Identyfikacja rewizji

- [ ] Odczytać dokładny model z etykiety PCB/kontrolera.
- [ ] Odczytać wersję firmware z VESC Tool.
- [ ] Zapisać datę/rewizję sprzętu, jeżeli jest dostępna.
- [ ] Zrobić zdjęcie wszystkich złączy przed modyfikacją.

### 2. Zasilanie sensorów

Przed podłączeniem sygnału do MCU:

- [ ] Zmierzyć VCC PAS.
- [ ] Zmierzyć VCC speed sensora.
- [ ] Zmierzyć napięcie względem GND.
- [ ] Potwierdzić, że poziom logiczny jest bezpieczny dla konkretnego wejścia.
- [ ] Nie podłączać sygnału 5 V bez potwierdzenia tolerancji wejścia.

### 3. PAS1 / PAS2

Przy nieruchomym rowerze ręcznie obracać korbą.

Dla każdego kanału zapisać:

- stan LOW,
- stan HIGH,
- napięcie LOW,
- napięcie HIGH,
- częstotliwość przy wolnym obrocie,
- częstotliwość przy szybszym obrocie,
- kolejność zboczy PAS1/PAS2.

Tabela pomiarowa:

| Parametr | PAS1 | PAS2 |
|---|---:|---:|
| VLOW | TBD | TBD |
| VHIGH | TBD | TBD |
| Freq slow | TBD | TBD |
| Freq fast | TBD | TBD |
| Phase relation | TBD | TBD |

### 4. Kierunek pedałowania

Obrócić korbą:

1. do przodu,
2. do tyłu.

Zapisać kolejność zboczy:

```text
Forward:  PAS1 → PAS2  /  PAS2 → PAS1
Reverse:  PAS2 → PAS1  /  PAS1 → PAS2
```

Nie zakładać kolejności przed pomiarem.

### 5. Speed sensor

Przy jednym magnesie/czujniku:

- [ ] potwierdzić typ czujnika,
- [ ] zmierzyć VCC,
- [ ] zmierzyć VLOW/VHIGH,
- [ ] policzyć impulsy na jeden pełny obrót koła,
- [ ] zmierzyć okres impulsu przy znanej prędkości,
- [ ] sprawdzić zachowanie przy bardzo małej prędkości.

Konfiguracja musi obsługiwać:

```text
wheel_diameter_mm
speed_sensor_pulses_per_wheel_rev
speed_sensor_timeout_ms
speed_filter
```

### 6. Bezpieczeństwo pomiaru

- Nie testować nieznanego sygnału bez pomiaru napięcia.
- Nie podawać 5 V bezpośrednio na niezweryfikowane wejście MCU.
- Pierwsze testy wykonywać z wyłączonym napędem lub z kołem uniesionym, zgodnie z bezpieczną procedurą testową.
- W pierwszej wersji LispBM sensor failure musi prowadzić do stanu bezpiecznego, a nie do zwiększenia prądu silnika.

## Kryterium zakończenia ETAPU 1.5

Etap jest zamknięty dopiero, gdy mamy:

1. konkretną rewizję MKS 75200 V2,
2. potwierdzone złącze i wejście dla każdego sygnału,
3. potwierdzone napięcia,
4. potwierdzone poziomy logiczne,
5. potwierdzoną częstotliwość,
6. potwierdzoną kolejność PAS1/PAS2,
7. potwierdzoną liczbę impulsów speed sensora.

Dopiero wtedy `hardware.lisp`, `pas.lisp` i `speed.lisp` mogą otrzymać konkretne mapowanie sprzętowe.

## Status

`SENSOR_VALIDATION = PLAN_READY`

`HARDWARE_PIN_MAPPING = NOT_FINAL`
