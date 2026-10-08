import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_taxi_fare_app/main.dart';
import 'package:flutter_taxi_fare_app/taxi_fare_screen.dart';

void main() {
  testWidgets('splash navigates to the taxi fare screen', (tester) async {
    await tester.pumpWidget(const TaxiFareApp());
    expect(find.text('Taxi Fare Calculator'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pump();
    expect(find.text('Taxi Fare'), findsOneWidget);
    expect(find.text('คำนวณค่าโดยสารแท็กซี่'), findsWidgets);
  });

  testWidgets('calculates a fare from distance and waiting time', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: TaxiFareScreen()));

    await tester.enterText(find.byType(EditableText).at(0), '5');
    await tester.enterText(find.byType(EditableText).at(1), '0');
    await tester.tap(find.text('คำนวณค่าโดยสาร'));
    await tester.pump();

    expect(find.text('61.00'), findsOneWidget);
  });
}
