import 'package:flutter/material.dart';
import 'package:how_about_this_class/Integrated_analysis_screen.dart';
import 'dart:async';
import 'package:how_about_this_class/homescreen.dart';

import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../recommend_screen/professor_recommed_screen.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => search_screen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                    width: 150,
                    child: Image.asset('asset/img/Logo.png')),
                GradientText("이 수업 어때 ?"
                  ,textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'righteous',
                      fontWeight: FontWeight.w800
                  ),
                  colors: [
                    Colors.blueAccent,
                    Colors.cyanAccent
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  children: [GradientText("made by 졸업 예정자들"
                    ,textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'righteous',
                        fontWeight: FontWeight.w800
                    ),
                    colors: [
                      Colors.blueAccent,
                      Colors.cyanAccent
                    ],
                  ),],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

