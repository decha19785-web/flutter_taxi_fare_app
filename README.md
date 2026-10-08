# Flutter Taxi Fare App

A Thai-language taxi fare calculator built with Flutter. The app opens with a
short splash screen and then shows fields for distance and waiting time.

## Fare rules

- First kilometer: 35 baht
- Kilometers 2–10: 6.50 baht per kilometer
- Kilometers 10–20: 7.00 baht per kilometer
- Kilometers 20–40: 8.00 baht per kilometer
- Kilometers 40–60: 8.50 baht per kilometer
- Kilometers 60–80: 9.00 baht per kilometer
- Over 80 kilometers: 10.50 baht per kilometer
- Waiting time: 3.00 baht per minute

## Run

```sh
flutter pub get
flutter run
```

Run the tests with:

```sh
flutter test
```

The taxi image at `assets/images/taxi.png` was provided for this project.
