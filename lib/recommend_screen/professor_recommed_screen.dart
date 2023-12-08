import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:how_about_this_class/componet/gauge.dart';
import 'package:how_about_this_class/details_class_screen.dart';
import 'package:how_about_this_class/splash_screen/splash_screen.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:http/http.dart' as http;

import '../class/lecture.dart';
class professor_recommend_screen extends StatefulWidget {
  final String dep_;
  final String professor_;

  const professor_recommend_screen({
    required this.dep_,
    required this.professor_,
    super.key});

  @override
  State<professor_recommend_screen> createState() =>
      _professor_recommend_screenState();
}

class _professor_recommend_screenState
    extends State<professor_recommend_screen> {
    List <Lecture> ?lecture;
    double recommand_score=0;


  Future<void> fetchData() async {
    var url = Uri.parse('http://3.12.111.59/api/v1/search');
    var queryParams = {
      'major': widget.dep_,
      'keyword': widget.professor_,
      'condition':'professor'
    };
    var uri = Uri.http(
        url.authority, url.path, queryParams);
    var headers = {
      'accept':'application/json',
    };
    try {
      var response = await http.get(
          uri,headers: headers);
      if (response.statusCode == 200) {
        // 성공적으로 데이터를 받아왔을 때의 처리
        print('Response data: ${utf8.decode(response.bodyBytes)}');
        List<dynamic> jsonData = (jsonDecode(utf8.decode(response.bodyBytes)));
        List<Lecture> _lectures = jsonData.map((json) => Lecture.fromJson(json)).toList();
        double sum = 0;
        int count = 0;
        for (var lecture_ in _lectures) {
          // option_1 값이 있는지 확인하고, 있으면 합계에 추가
          if (lecture_.options.containsKey('option_1')) {
            sum += double.parse(lecture_.options['option_1']!);
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
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await fetchData();
      setState(() { });
    });
    super.initState();
  }

    List<Widget> buildGestureDetectors(BuildContext context) {
      return lecture!.map((lecture) {
        return GestureDetector(
          onTap: () => Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => details_class_screen(),
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
            child: minibuildRadialGauge(lecture.lectureName, double.parse(lecture.options['option_1']!)),
          ),
        );
      }).toList();
    }




  @override
  Widget build(BuildContext context) {
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
      body: Container(
        color: Colors.white,
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildRadialGauge(widget.professor_, recommand_score),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {},
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
                          '옵션1',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
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
                          '옵션2',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
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
                          '옵션3',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
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
                          '옵션4',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
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
                          '옵션5',
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:  buildGestureDetectors(context),
                ),
              ),
            )
          ],
        ),
      ),
    );

  }

}
