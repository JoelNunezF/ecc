import 'package:flutter/material.dart';
import 'package:project_ecc/run.dart';
import 'package:project_ecc/widgets/botons/BtnMode.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:async';

// ignore: camel_case_types
class chart_humidity extends StatefulWidget {
  const chart_humidity({Key? key}) : super(key: key);

  @override
  State<chart_humidity> createState() => _chart_humidityState();
}

// ignore: camel_case_types
class _chart_humidityState extends State<chart_humidity> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: SfRadialGauge(
          title: const GaugeTitle(
              text: "Humedad",
              textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Color.fromRGBO(23, 20, 192, 1) )),
          axes: <RadialAxis>[
            RadialAxis(
              interval: 20,
              useRangeColorForAxis: true,
              ranges: <GaugeRange>[
                GaugeRange(
                    color: Color.fromARGB(255, 74, 100, 248),
                    startValue: 0,
                    endValue: 40),
                GaugeRange(
                    color: Color.fromARGB(255, 74, 100, 248),
                    startValue: 40,
                    endValue: 80),
                GaugeRange(color: Color.fromARGB(255, 74, 100, 248), startValue: 80, endValue: 100)
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                  animationType: AnimationType.bounceOut,
                  needleColor: Color.fromARGB(255, 74, 100, 248),
                  enableDragging: true,
                  needleLength: 0.60,
                  enableAnimation: true,
                  animationDuration: 2000,
                  value: double.parse(prueba[1]),
                )
              ],
              minimum: 0,
              maximum: 100,
              showLabels: true,
              showTicks: true,
              axisLineStyle: const AxisLineStyle(
                thickness: 0.3,
                cornerStyle: CornerStyle.bothCurve,
                color: Color.fromARGB(0, 255, 255, 255),
                thicknessUnit: GaugeSizeUnit.factor,
              ),
            )
          ]),
    );
  }
}
