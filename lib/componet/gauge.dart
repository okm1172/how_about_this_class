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
              angle: 70,
              positionFactor: 0.1)
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


Widget minibuildRadialGauge(String professor_name,double score,String sem) {
  String year = sem.substring(2, 4); // Extracts the year part
  String semester = sem.substring(4, 6) == "02" ? "2" : "1"; //
  return SfRadialGauge(
    enableLoadingAnimation: true,
    animationDuration: 3000,
    title: GaugeTitle(
        text: "${year}년 ${semester}학기"+'\n'+professor_name,
        textStyle: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold)),
    axes: <RadialAxis>[
      RadialAxis(
        minimum: 0,
        maximum: 5,
        annotations: <GaugeAnnotation>[
          GaugeAnnotation(
              widget: Container(
                  child: Text(score.toStringAsFixed(1),
                      style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold))),
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

Widget miniDetailGauge(String miniDetailGaugeName, String professor_name, double score, String sem) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius:
      BorderRadius.circular(20.0), // 이 부분이 모서리를 둥글게 만듭니다.
    ),
    height: 200,
    width: 130,
    child: Column(
      children: [
        Container(
          height: 30,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                miniDetailGaugeName,
                style: TextStyle(
                    fontSize: 15, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(height: 20,),
        Container(
            height: 120,
            width: 130,
            child: minibuildRadialGauge(professor_name, score ,sem))
      ],
    ),
  );
}