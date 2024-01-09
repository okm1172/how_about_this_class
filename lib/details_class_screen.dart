import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:how_about_this_class/componet/contain.dart';
import 'package:how_about_this_class/componet/gauge.dart';
import 'package:how_about_this_class/homescreen.dart';
import 'package:how_about_this_class/splash_screen/splash_screen.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

import 'class/detail_lecture.dart';

class details_class_screen extends StatefulWidget {
  final int uk;

  const details_class_screen({
    required this.uk,
    super.key});

  @override
  State<details_class_screen> createState() => _details_class_screenState();
}
String to_hakgi(String sem){
  String year = sem.substring(2, 4); // Extracts the year part
  String semester = sem.substring(4, 6) == "02" ? "2" : "1"; //
  return "${year}년 ${semester}학기";
}

List<semeData> createSemeDataList(List<dynamic> portalData) {
  return portalData.map((data) {
    String semester = to_hakgi(data['semester']);
    double score = double.tryParse(data['option_5'].toString()) ?? 0.0;
    return semeData(semester, score);
  }).toList();
}


List<semeData> createSemeDataList1(List<dynamic> everytimeData) {
  return everytimeData.map((data) {
    String semester = to_hakgi(data['semester']);
    double score = double.tryParse(data['rating_average'].toString()) ?? 0.0;
    return semeData(semester, score);
  }).toList();
}


class _details_class_screenState extends State<details_class_screen> {
  Lecture? lecture;


  Future<void> fetchData() async {
    var url = Uri.parse('https://xgojt37mn2ddxibp2uova4k32u0bffwr.lambda-url.us-east-2.on.aws');
    var queryParams = {
      'uk': widget.uk.toString()
    };
    var uri = Uri.https(
        url.authority, url.path, queryParams);
    var headers = {
      'accept':'application/json',
    };
    try {
      var response = await http.get(
          uri,headers: headers);
      //print('Response data: ${utf8.decode(response.bodyBytes)}');


      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = json.decode(utf8.decode(response.bodyBytes));


        Lecture _lecture = Lecture.fromJson(jsonMap);
        setState(() {
          lecture=_lecture;
          sel_grade=lecture!.portal[0].semester;
          List<semeData> semeDataList = createSemeDataList(jsonMap['portal']);
          semeDataList.sort((a, b) => a.seme.compareTo(b.seme));
          if(_lecture.everytime.isNotEmpty){

            List<dynamic> everytimeData = jsonMap['everytime'];
            List<semeData> semeDataList1 = createSemeDataList1(everytimeData);
              semeDataList1.sort((a, b) => a.seme.compareTo(b.seme));
              chartData1=semeDataList1;



          }

          chartData2=semeDataList;
          chartData1!.sort((a, b) => a.seme.compareTo(b.seme));
          chartData2!.sort((a, b) => a.seme.compareTo(b.seme));


        });

      } else {
        // 서버 에러 처리
        print('디테일 페이지 failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      // 네트워크 에러 처리
      print('디테일 페이지 Exception caught: $e');
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

  List<Widget> buildKeywordWidgetsbad(List<String> keywords) {
    return keywords.map((keyword) {
      return buildKeywordWidget1(keyword); // 여기서 buildKeywordWidget1은 주어진 키워드로 위젯을 생성하는 함수
    }).toList();
  }

  List<Widget> buildKeywordWidgetsgood(List<String> keywords) {
    return keywords.map((keyword) {
      return buildKeywordWidget(keyword); // 여기서 buildKeywordWidget1은 주어진 키워드로 위젯을 생성하는 함수
    }).toList();
  }




   List<semeData> ?chartData2;
   List<semeData> ?chartData1;


  String ?sel_grade;
  int sel_num=0;
  bool isParagraphVisible=true;
  bool first_semester=true;
  bool second_semester=true;
  bool another_professor=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title:GradientText("상세 통계 보기"
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
        ),
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
      ): SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius:
                    BorderRadius.circular(10.0), // 이 부분이 모서리를 둥글게 만듭니다.
                  ),
                  child: CupertinoButton(
                      child: Text(
                        '학기 : ' +sel_grade!,
                        style: TextStyle(fontSize: 15, color: Colors.white,fontWeight: FontWeight.bold),
                      ),
                      onPressed: () => showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext builder) {
                            return Container(
                              height: MediaQuery.of(context).size.height / 3,
                              color: Colors.white,
                              child: CupertinoPicker(
                                itemExtent: 30,
                                onSelectedItemChanged: (int value) {
                                  setState(() {
                                    sel_num= value;
                                    sel_grade= lecture!.portal[value].semester;
                                  });
                                },
                                children: List<Widget>.generate(lecture!.portal.length,
                                        (int index) {
                                      return Center(child: Text(lecture!.portal[index].semester));
                                    }),
                              ),
                            );
                          })),
                ),
                  SizedBox(width: 20,),


                  SizedBox(width: 20,)
                ],

              ),
              buildRadialGauge(lecture!.lectureName,double.parse(lecture!.portal[sel_num].option5)),
                Text("전체 수강자 수 : "+lecture!.portal[sel_num].totalCnt.toString()),
                Text("설문 참여자 수 : "+lecture!.portal[sel_num].surveyCnt.toString()),
              SizedBox(height: 10,),
              Container(
                height: 30,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(30.0), // 이 부분이 모서리를 둥글게 만듭니다.
                ),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      another_professor = !another_professor;
                    });
                  },
                  child: Text('수업 개설 교수'),
                ),
              ),
              Visibility(
                visible: another_professor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(lecture!.professorNames.length, (index) {
                        return buildprofessrodWidget(lecture!.professorNames[index]);
                      }),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    miniDetailGauge('강의 계획 적절성',lecture!.portal[sel_num].option1, double.parse(lecture!.portal[sel_num].option1),lecture!.portal[sel_num].semester),
                    SizedBox(width: 20,),
                    miniDetailGauge('수업 방법 적절성',lecture!.portal[sel_num].option2, double.parse(lecture!.portal[sel_num].option2),lecture!.portal[sel_num].semester),
                    SizedBox(width: 20,),
                    miniDetailGauge('수업 성과',lecture!.portal[sel_num].option3, double.parse(lecture!.portal[sel_num].option3),lecture!.portal[sel_num].semester),
                    SizedBox(width: 20,),
                    miniDetailGauge('수업 성과2',lecture!.portal[sel_num].option4, double.parse(lecture!.portal[sel_num].option4),lecture!.portal[sel_num].semester),
                  ],
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Container(
                height: 30,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(30.0), // 이 부분이 모서리를 둥글게 만듭니다.
                ),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      first_semester = !first_semester;
                    });
                  },
                  child:lecture!.everytime.isNotEmpty==true?Text(to_hakgi(lecture!.everytime[0].semester)+' 보기'):Text("데이터 없음")
                ),
              ),
              Visibility(
                visible: first_semester,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child:  Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 30,
                          width: 130,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '긍정적인 키워드',
                                style: TextStyle(fontSize: 15, color: Colors.blueAccent),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Wrap(
                          spacing: 8.0, // 각 자식 위젯 사이의 가로 간격
                          runSpacing: 8.0,
                          children:lecture!.everytime.isNotEmpty==true?
                            buildKeywordWidgetsgood(lecture!.everytime[0].positiveKeywords)
                          :[
                            buildKeywordWidget('없음'),
                          ]

                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 30,
                          width: 130,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '부정적인 키워드',
                                style: TextStyle(fontSize: 15, color: Colors.redAccent),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Wrap(
                          spacing: 8.0, // 각 자식 위젯 사이의 가로 간격
                          runSpacing: 8.0,
                          children: lecture!.everytime.isNotEmpty==true?
                          buildKeywordWidgetsbad(lecture!.everytime[0].negativeKeywords)
                              :[
                            buildKeywordWidget('없음'),
                          ]
                        ),
                      ],
                    )
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Container(
                height: 30,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(30.0), // 이 부분이 모서리를 둥글게 만듭니다.
                ),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      second_semester = !second_semester;
                    });
                  },
                  child:lecture!.everytime.isNotEmpty==true?Text(to_hakgi(lecture!.everytime[1].semester)+' 보기'):Text("데이터 없음")
                ),
              ),

              Visibility(
                visible: second_semester,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child:  Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 30,
                            width: 130,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '긍정적인 키워드',
                                  style: TextStyle(fontSize: 15, color: Colors.blueAccent),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Wrap(
                            spacing: 8.0, // 각 자식 위젯 사이의 가로 간격
                            runSpacing: 8.0,
                            children: lecture!.everytime.isNotEmpty==true?
                            buildKeywordWidgetsgood(lecture!.everytime[1].positiveKeywords)
                                :[
                              buildKeywordWidget('없음'),
                            ]
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 30,
                            width: 130,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '부정적인 키워드',
                                  style: TextStyle(fontSize: 15, color: Colors.redAccent),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Wrap(
                            spacing: 8.0, // 각 자식 위젯 사이의 가로 간격
                            runSpacing: 8.0,
                            children: lecture!.everytime.isNotEmpty==true?
                            buildKeywordWidgetsbad(lecture!.everytime[1].negativeKeywords)
                                :[
                              buildKeywordWidget('없음'),
                            ]
                          ),
                        ],
                      )
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 30,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(30.0), // 이 부분이 모서리를 둥글게 만듭니다.
                ),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isParagraphVisible = !isParagraphVisible;
                    });
                  },
                  child: Text('에타/포털 비교 보기 '),
                ),
              ),

              Visibility(
                visible: isParagraphVisible,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child:  Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: 400,
                    child: Container(
                        child: SfCartesianChart(
                            legend: Legend(
                                isVisible: true,
                                toggleSeriesVisibility: true
                            ),
                            primaryXAxis: CategoryAxis(),
                            series: <ChartSeries>[

                              LineSeries<semeData, String>(
                                dataSource: chartData2!,
                                xValueMapper: (semeData data, _) => data.seme,
                                yValueMapper: (semeData data, _) => data.score,
                                name: '포털 데이터',
                                  markerSettings: MarkerSettings(
                                      isVisible: true
                                  )
                              ),
                              if(chartData1!=null)
                                LineSeries<semeData, String>(
                                dataSource: chartData1!,
                                xValueMapper: (semeData data, _) => data.seme,
                                yValueMapper: (semeData data, _) => data.score,
                                name: '에타 데이터',
                                  markerSettings: MarkerSettings(
                                      isVisible: true
                                  )
                              ),
                            ]
                        )
                    )
                  ),
                ),
              ),
              SizedBox(height: 20,),

              GestureDetector(
                  onTap: ()  =>Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => search_screen(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,);},),),
                  child: Container(
                    height: 60,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.cyanAccent,
                              Colors.blue,
                            ]
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 3),
                          )
                        ]
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ' 다시 검색 ',textAlign: TextAlign.center, style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 30,)
            ],
          ),

        ),
      ),
    );
  }
}
class semeData {
  semeData(this.seme, this.score);
  final String seme;
  final double score;
}
