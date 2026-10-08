class FareCalculator {
  const FareCalculator._();

  static const double waitingRatePerMinute = 3.0;

  static double calculate({
    required double distanceKm,
    required double waitingMinutes,
  }) {
    if (!distanceKm.isFinite ||
        !waitingMinutes.isFinite ||
        distanceKm < 0 ||
        waitingMinutes < 0) {
      throw ArgumentError(
        'Distance and waiting time must be finite and nonnegative.',
      );
    }

    var fare = distanceKm == 0 ? 0.0 : 35.0;
    var remainingKm = distanceKm > 1 ? distanceKm - 1 : 0.0;

    double chargeBand(double bandLength, double ratePerKm) {
      final chargedKm = remainingKm.clamp(0.0, bandLength).toDouble();
      remainingKm -= chargedKm;
      return chargedKm * ratePerKm;
    }

    fare += chargeBand(9, 6.5);
    fare += chargeBand(10, 7.0);
    fare += chargeBand(20, 8.0);
    fare += chargeBand(20, 8.5);
    fare += chargeBand(20, 9.0);
    fare += remainingKm * 10.5;
    fare += waitingMinutes * waitingRatePerMinute;

    return double.parse(fare.toStringAsFixed(2));
  }
}
