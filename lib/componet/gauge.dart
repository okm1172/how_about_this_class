import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

Widget buildRadialGauge(String professor_name,double score) {
  return SfRadialGauge(
    enableLoadingAnimation: true,
    animationDuration: 3000,
    title: GaugeTitle(
        text: professor_name,
        textStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
    axes: <RadialAxis>[
      RadialAxis(
        minimum: 0,
        maximum: 5,
        startAngle: 180,
        endAngle: 0,
        annotations: <GaugeAnnotation>[
          GaugeAnnotation(
              widget: Container(
                  child: Text(score.toStringAsFixed(1),
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
              angle: 90,
              positionFactor: 0.5)
        ],
        pointers: <GaugePointer>[
          RangePointer(
            value: score,
            width: 0.1,
            sizeUnit: GaugeSizeUnit.factor,
            gradient: const SweepGradient(colors: <Color>[
              Colors.redAccent,
              Colors.blueAccent,
            ], stops: <double>[
              0.25,
              0.75
            ]),
          )
        ],
      ),
    ],
  );
}


Widget minibuildRadialGauge(String professor_name,double score) {
  return SfRadialGauge(
    enableLoadingAnimation: true,
    animationDuration: 3000,
    title: GaugeTitle(
        text: professor_name,
        textStyle: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold)),
    axes: <RadialAxis>[
      RadialAxis(
        minimum: 0,
        maximum: 5,
        annotations: <GaugeAnnotation>[
          GaugeAnnotation(
              widget: Container(
                  child: Text(score.toStringAsFixed(1),
                      style: TextStyle(fontSize: 12,))),
              angle: 90,
              positionFactor: 1)
        ],
        pointers: <GaugePointer>[
          RangePointer(
            value: score,
            width: 0.2,
            sizeUnit: GaugeSizeUnit.factor,
            gradient: const SweepGradient(colors: <Color>[
              Colors.greenAccent,
              Colors.blueAccent,
            ], stops: <double>[
              0.25,
              0.75
            ]),
          )
        ],
      ),
    ],
  );
}

