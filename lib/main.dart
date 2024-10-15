import 'package:flutter/material.dart';
import 'dart:math';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(const Bmi());
}

class Bmi extends StatelessWidget {
  const Bmi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BMI Calculator',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.indigo,
        ),
        home: const BodyMassIndex()
    );
  }
}

class BodyMassIndex extends StatefulWidget {
  const BodyMassIndex({super.key});

  @override
  State<BodyMassIndex> createState() => _BMIForm();
}

class _BMIForm extends State<BodyMassIndex> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double? bmi;
  String errorText = '';
  String status = '';

   //get child => null;

  void calculateBMI() {
    final double? height = double.tryParse(_heightController.value.text);
    final double? weight = double.tryParse(_weightController.value.text);

    if (height == null || weight == null) {
      setState(() {
        errorText = "Please enter your Height and Weight";
      });
      return;
    }

    if (height <= 0 || weight <= 0) {
      setState(() {
        errorText = "Your Height and Weight must be positive numbers";
      });
      return;
    }

    setState(() {
      bmi = weight / pow((height / 100), 2);
      if (bmi! < 18.5) {
        status = "Underweight";
      } else if (bmi! > 18.5 && bmi! < 25) {
        status = 'Normal weight';
      } else if (bmi! > 25 && bmi! < 30) {
        status = 'Pre-Obesity';
      } else if (bmi! > 30 && bmi! < 35) {
        status = 'Obesity class 1';
      } else if (bmi! > 35 && bmi! < 40) {
        status = 'Obesity class 2';
      } else {
        status = 'Obesity class 3';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('BMI Calculator'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: _heightController,
                keyboardType:TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    labelText: 'Height (cm)',
                    suffixText: 'centimeters'
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Weight (kg)',
                  suffixText: 'kilograms',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: calculateBMI,
                    child: const Text('Calculate'),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                errorText,
              ),
              const SizedBox(
                height: 20,
              ),

              bmi != null
                  ? SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 14,
                    maximum: 40,
                    ranges: <GaugeRange>[
                      GaugeRange(
                        startValue: 14,
                        endValue: 18.5,
                        color: Colors.green.shade100,
                        label: 'Underweight',
                        labelStyle: const GaugeTextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        startWidth: 20,
                        endWidth: 20,
                      ),
                      GaugeRange(
                        startValue: 18.5,
                        endValue: 24.9,
                        color: Colors.green,
                        label: 'Normal',
                        labelStyle: const GaugeTextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        startWidth: 20,
                        endWidth: 20,
                      ),
                      GaugeRange(
                        startValue: 25,
                        endValue: 29.9,
                        color: Colors.orange,
                        label: 'Overweight',
                        labelStyle: const GaugeTextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        startWidth: 20,
                        endWidth: 20,
                      ),
                      GaugeRange(
                        startValue: 30,
                        endValue: 40,
                        color: Colors.red,
                        label: 'Obesity',
                        labelStyle: const GaugeTextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        startWidth: 20,
                        endWidth: 20,
                      ),
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(value: bmi ?? 0), // Utilisation du BMI calculé ici
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Text(
                          'BMI: ${bmi!.toStringAsFixed(1)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        angle: 90,
                        positionFactor: 0.5,
                      ),
                    ],
                  ),
                ],
              )
                  : const Text('Please enter your data to calculate BMI'),
              ],
          ),
        )
    );
  }
}


