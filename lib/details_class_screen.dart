import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:how_about_this_class/componet/contain.dart';
import 'package:how_about_this_class/componet/gauge.dart';
import 'package:how_about_this_class/homescreen.dart';
import 'package:how_about_this_class/splash_screen/splash_screen.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class details_class_screen extends StatefulWidget {
  const details_class_screen({super.key});

  @override
  State<details_class_screen> createState() => _details_class_screenState();
}

class _details_class_screenState extends State<details_class_screen> {

  final List<semeData> chartData = [
    semeData('20-2', 5),
    semeData('21-1', 4),
    semeData('21-2', 3),
    semeData('22-1', 2),
    semeData('22-2', 1),
    semeData('23-1', 5),

  ];
  final List<semeData> chartData2= [
    semeData('20-2', 4),
    semeData('21-1', 4.6),
    semeData('21-2', 4.5),
    semeData('22-1', 4.5),
    semeData('22-2', 4.6),
    semeData('23-1', 4.9),

  ];

  List<String> grade =['2022년 2학기','2023년 1학기'];
  String sel_grade="없음";
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
      body: SingleChildScrollView(
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
                        '학기 : ' +sel_grade,
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
                                    sel_grade= grade[value];
                                  });
                                },
                                children: List<Widget>.generate(grade.length,
                                        (int index) {
                                      return Center(child: Text(grade[index]));
                                    }),
                              ),
                            );
                          })),
                ),
                  SizedBox(width: 20,),

                  ElevatedButton(
                    onPressed: null,//todo 여기다 바뀌는거 넣기
                    child: Text("확인",style: TextStyle(
                      color: Colors.white,fontWeight: FontWeight.bold
                    ),),
                  ),
                  SizedBox(width: 20,)
                ],

              ),
              buildRadialGauge('과목명', 4.5),
                Text("전체 수강자 수 : "+"숫자"),
                Text("설문 참여자 수 : "+"숫자"),
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
                      children: [
                        buildprofessrodWidget("교수1"),
                        buildprofessrodWidget("교수1"),
                      ],
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
                    Container(
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
                            height: 50,
                            width: 70,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '강의 계획 적절성',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Container(
                              height: 120,
                              width: 130,
                              child: minibuildRadialGauge('', 4.7,"202020"),)
                        ],
                      ),
                    ),
                    SizedBox(width: 20,),
                    Container(
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
                            height: 50,
                            width: 70,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '수업 방법 적절성',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Container(
                              height: 120,
                              width: 130,
                              child: minibuildRadialGauge('', 4.7,'202202'))
                        ],
                      ),
                    ),
                    SizedBox(width: 20,),
                    Container(
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
                                  '수업 성과',
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
                              child: minibuildRadialGauge('', 4.7,'202202'))
                        ],
                      ),
                    ),
                    SizedBox(width: 20,),
                    Container(
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
                                  '수업 성과2',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                              height:120,
                              width: 130,
                              child: minibuildRadialGauge('', 4.7,'202202'))
                        ],
                      ),
                    ),
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
                  child: Text('2023년도 1학기 보기'),
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
                          children: [
                            buildKeywordWidget('글자수에 따라 잘 늘어나는 키워드'),
                            buildKeywordWidget('row를 넘어가는지 확인을 하는 키워드'),
                            buildKeywordWidget('키워드1'),
                            buildKeywordWidget('키워드1'),
                            buildKeywordWidget('키워드1'),
                          ],
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
                          children: [
                            buildKeywordWidget1('글자수에 따라 잘 늘어나는 키워드'),
                            buildKeywordWidget1('row를 넘어가는지 확인을 하는 키워드'),
                            buildKeywordWidget1('키워드1'),
                            buildKeywordWidget1('키워드1'),
                            buildKeywordWidget1('키워드1'),
                          ],
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
                  child: Text('2022년도 2학기 보기'),
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
                            children: [
                              buildKeywordWidget('글자수에 따라 잘 늘어나는 키워드'),
                              buildKeywordWidget('row를 넘어가는지 확인을 하는 키워드'),
                              buildKeywordWidget('키워드1'),
                              buildKeywordWidget('키워드1'),
                              buildKeywordWidget('키워드1'),
                            ],
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
                            children: [
                              buildKeywordWidget1('글자수에 따라 잘 늘어나는 키워드'),
                              buildKeywordWidget1('row를 넘어가는지 확인을 하는 키워드'),
                              buildKeywordWidget1('키워드1'),
                              buildKeywordWidget1('키워드1'),
                              buildKeywordWidget1('키워드1'),
                            ],
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
                                  dataSource: chartData,
                                  xValueMapper: (semeData sales, _) => sales.seme,
                                  yValueMapper: (semeData sales, _) => sales.score,
                                name:  '포털데이터',
                                  markerSettings: MarkerSettings(
                                      isVisible: true
                                  )
                              ),
                              LineSeries<semeData, String>(
                                dataSource: chartData2,
                                xValueMapper: (semeData data, _) => data.seme,
                                yValueMapper: (semeData data, _) => data.score,
                                name: '에브리타임 데이터',
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
