import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_taxi_fare_app/fare_calculator.dart';

void main() {
  group('FareCalculator.calculate', () {
    test('returns 35 baht for a trip within the first kilometer', () {
      expect(
        FareCalculator.calculate(distanceKm: 0.5, waitingMinutes: 0),
        35.0,
      );
    });

    test('adds 3 baht for each waiting minute', () {
      expect(FareCalculator.calculate(distanceKm: 1, waitingMinutes: 10), 65.0);
    });

    test('applies the 2–10 km rate after the first kilometer', () {
      expect(FareCalculator.calculate(distanceKm: 5, waitingMinutes: 0), 61.0);
    });

    test('applies each progressive rate band', () {
      expect(
        FareCalculator.calculate(distanceKm: 15, waitingMinutes: 5),
        35 + (9 * 6.5) + (5 * 7.0) + (5 * 3.0),
      );
    });

    test('uses the over-80-km rate for remaining distance', () {
      expect(
        FareCalculator.calculate(distanceKm: 85, waitingMinutes: 0),
        35 +
            (9 * 6.5) +
            (10 * 7) +
            (20 * 8) +
            (20 * 8.5) +
            (20 * 9) +
            (5 * 10.5),
      );
    });

    test('rejects negative inputs', () {
      expect(
        () => FareCalculator.calculate(distanceKm: -1, waitingMinutes: 0),
        throwsArgumentError,
      );
    });
  });
}
