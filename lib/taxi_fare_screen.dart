import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'fare_calculator.dart';

class TaxiFareScreen extends StatefulWidget {
  const TaxiFareScreen({super.key});

  @override
  State<TaxiFareScreen> createState() => _TaxiFareScreenState();
}

class _TaxiFareScreenState extends State<TaxiFareScreen> {
  final _formKey = GlobalKey<FormState>();
  final _distanceController = TextEditingController();
  final _waitingController = TextEditingController();
  double _fare = 0;

  @override
  void dispose() {
    _distanceController.dispose();
    _waitingController.dispose();
    super.dispose();
  }

  void _calculate() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() {
      _fare = FareCalculator.calculate(
        distanceKm: double.parse(_distanceController.text),
        waitingMinutes: double.parse(_waitingController.text),
      );
    });
  }

  void _cancel() {
    _formKey.currentState?.reset();
    _distanceController.clear();
    _waitingController.clear();
    FocusScope.of(context).unfocus();
    setState(() => _fare = 0);
  }

  String? _validateNonNegativeNumber(String? value, String label) {
    final input = value?.trim() ?? '';
    final parsed = double.tryParse(input);
    if (input.isEmpty || parsed == null || !parsed.isFinite || parsed < 0) {
      return 'กรุณากรอก$labelเป็นตัวเลขตั้งแต่ 0 ขึ้นไป';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taxi Fare'),
        backgroundColor: const Color(0xFFFFC107),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/taxi.png',
                      width: 220,
                      height: 150,
                      fit: BoxFit.contain,
                      semanticLabel: 'ภาพรถแท็กซี่สีเหลือง',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'คำนวณค่าโดยสารแท็กซี่',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildField(
                    controller: _distanceController,
                    label: 'ระยะทาง (กิโลเมตร) 🛣️',
                    hint: 'กรุณากรอกระยะทาง',
                    validator: (value) =>
                        _validateNonNegativeNumber(value, 'ระยะทาง'),
                  ),
                  const SizedBox(height: 14),
                  _buildField(
                    controller: _waitingController,
                    label: 'เวลารถติด (นาที) ⏱️',
                    hint: 'กรุณากรอกเวลารถติด',
                    validator: (value) =>
                        _validateNonNegativeNumber(value, 'เวลารถติด'),
                  ),
                  const SizedBox(height: 18),
                  FilledButton(
                    onPressed: _calculate,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFFFC107),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      textStyle: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('คำนวณค่าโดยสาร'),
                  ),
                  const SizedBox(height: 10),
                  FilledButton(
                    onPressed: _cancel,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF9E9E9E),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('ยกเลิก'),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEDB5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text('ค่าโดยสารแท็กซี่'),
                        const SizedBox(height: 2),
                        Text(
                          _fare.toStringAsFixed(2),
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: const Color(0xFFF44336),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const Text('บาท'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ],
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
