import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:how_about_this_class/details_class_screen.dart';

import '../class/lecture.dart';
import '../componet/contain.dart';
import '../componet/gauge.dart';
import '../splash_screen/splash_screen.dart';
import 'package:http/http.dart' as http;

class class_recommend_screen extends StatefulWidget {
  final String dep_;
  final String class_;
  const class_recommend_screen({
    required this.dep_,
    required this.class_,
    super.key});

  @override
  State<class_recommend_screen> createState() => _class_recommend_screenState();
}

class _class_recommend_screenState extends State<class_recommend_screen> {
  bool op1=true;
  bool op2=false;
  bool op3=false;
  bool op4=false;
  bool op5=false;

  List <Lecture> ?lecture;
  double recommand_score=0;


  Future<void> fetchData() async {
    var url = Uri.parse('http://3.12.111.59/api/v1/search');
    var queryParams = {
      'major': widget.dep_,
      'keyword': widget.class_,
      'condition':'name'
    };
    var uri = Uri.http(
        url.authority, url.path, queryParams);
    var headers = {
      'accept':'application/json',
    };
    try {
      var response = await http.get(
          uri,headers: headers);
      print('Response data: ${utf8.decode(response.bodyBytes)}');
      if (response.statusCode == 200) {
        print('Response data: ${utf8.decode(response.bodyBytes)}');
        List<dynamic> jsonData = (jsonDecode(utf8.decode(response.bodyBytes)));
        List<Lecture> _lectures = jsonData.map((json) => Lecture.fromJson(json)).toList();
        double sum = 0;
        int count = 0;
        for (var lecture_ in _lectures) {
          // option_1 값이 있는지 확인하고, 있으면 합계에 추가
          if (lecture_.options.containsKey('option_5')) {
            sum += double.parse(lecture_.options['option_5']!);
            count++;
          }
        }
        double average = count > 0 ? sum / count : 0;
        setState(() {
          lecture=_lectures;
          recommand_score=average;
        });

      } else {
        // 서버 에러 처리
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      // 네트워크 에러 처리
      print('Exception caught: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await fetchData();
      setState(() { });
    });

  }
/*
  List<Widget> buildGestureDetectors_op1(BuildContext context) {
    if (lecture == null) return [];
    return lecture!.map((lecture) {
      return GestureDetector(
        onTap: () => Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => details_class_screen(uk:lecture.detailUk),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        ),
        child: Container(
          height: 120,
          width: 120,
          child: minibuildRadialGauge(lecture.professors[0].name+'교수님', double.parse(lecture.options['option_1']!),lecture.semester),
        ),
      );
    }).toList();
  }
  List<Widget> buildGestureDetectors_op2(BuildContext context) {
    if (lecture == null) return [];
    return lecture!.map((lecture) {
      return GestureDetector(
        onTap: () => Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => details_class_screen(uk:lecture.detailUk),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        ),
        child: Container(
          height: 120,
          width: 120,
          child: minibuildRadialGauge(lecture.professors[0].name+'교수님', double.parse(lecture.options['option_2']!),lecture.semester),
        ),
      );
    }).toList();
  }
  List<Widget> buildGestureDetectors_op3(BuildContext context) {
    if (lecture == null) return [];
    return lecture!.map((lecture) {
      return GestureDetector(
        onTap: () => Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => details_class_screen(uk:lecture.detailUk),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        ),
        child: Container(
          height: 120,
          width: 120,
          child: minibuildRadialGauge(lecture.professors[0].name+'교수님', double.parse(lecture.options['option_3']!),lecture.semester),
        ),
      );
    }).toList();
  }
  List<Widget> buildGestureDetectors_op4(BuildContext context) {
    if (lecture == null) return [];
    return lecture!.map((lecture) {
      return GestureDetector(
        onTap: () => Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => details_class_screen(uk:lecture.detailUk),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        ),
        child: Container(
          height: 120,
          width: 120,
          child: minibuildRadialGauge(lecture.professors[0].name+'교수님', double.parse(lecture.options['option_4']!),lecture.semester),
        ),
      );
    }).toList();
  }
  List<Widget> buildGestureDetectors_op5(BuildContext context) {
    if (lecture == null) return [];
    return lecture!.map((lecture) {
      return GestureDetector(
        onTap: () => Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => details_class_screen(uk:lecture.detailUk),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        ),
        child: Container(
          height: 120,
          width: 120,
          child: minibuildRadialGauge(lecture.professors[0].name+'교수님', double.parse(lecture.options['option_5']!),lecture.semester),
        ),
      );
    }).toList();
  }

*/


  @override
  Widget build(BuildContext context) {
    List<Widget> gestureDetectors;
    if (op1) {
      gestureDetectors = buildGestureDetectors(context, 'option_1', lecture);
    } else if (op2) {
      gestureDetectors = buildGestureDetectors(context, 'option_2', lecture);
    } else if (op3) {
      gestureDetectors = buildGestureDetectors(context, 'option_3', lecture);
    } else if (op4) {
      gestureDetectors = buildGestureDetectors(context, 'option_4', lecture);
    } else if (op5) {
      gestureDetectors = buildGestureDetectors(context, 'option_5', lecture);
    } else {
      // Default case if none of the options are true정진
      gestureDetectors = []; // Or any default widgets you want to show
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, // 여기서 아이콘 색상을 검정색으로 설정합니다.
        ),
      ),
      body: lecture==null ?  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width :30,height:30
                  ,child: CircularProgressIndicator()),
            ],
          ),
        ],
      ):Container(
        color: Colors.white,
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildRadialGauge(widget.class_, recommand_score),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      op1=true;
                      op2=false;
                      op3=false;
                      op4=false;
                      op5=false;
                    });
                  },
                  child: Container(
                    height: 30,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '강의 계획 적절성',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {

                    setState(() {
                      op1=false;
                      op2=true;
                      op3=false;
                      op4=false;
                      op5=false;
                    });
                  },
                  child: Container(
                    height: 30,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '수업방법 적절성',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                GestureDetector(
                  onTap: () {
                    setState(() {
                      op1=false;
                      op2=false;
                      op3=true;
                      op4=false;
                      op5=false;
                    });
                  },
                  child: Container(
                    height: 30,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '수업성과1',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      op1=false;
                      op2=false;
                      op3=false;
                      op4=true;
                      op5=false;
                    });
                  },
                  child: Container(
                    height: 30,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '수업성과2',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      op1=false;
                      op2=false;
                      op3=false;
                      op4=false;
                      op5=true;
                    });
                  },
                  child: Container(
                    height: 30,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '추천도',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:  SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: gestureDetectors
                ),
              ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
