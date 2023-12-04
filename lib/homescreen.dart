import 'dart:ffi';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:how_about_this_class/recommend_screen/class_recommend_screen.dart';
import 'package:how_about_this_class/recommend_screen/professor_recommed_screen.dart';
import 'package:how_about_this_class/splash_screen/splash_screen.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'Integrated_analysis_screen.dart';
import 'componet/item.dart';

class search_screen extends StatefulWidget {
  const search_screen({super.key});

  @override
  State<search_screen> createState() => _search_screenState();
}

class _search_screenState extends State<search_screen> {
  TextEditingController _controller = TextEditingController();
  bool professor_search = false;
  bool class_search = false;
  String searchText = '';
  String _selected_dep = '전체';
  int _selectedItem1 = 0;

  List<String> recentSearches = ['자료구조', '권구인', '심정섭', '컴퓨터 보안'];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 250,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    GradientText(
                      "이 수업 어때 ?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'righteous',
                          fontWeight: FontWeight.w800),
                      colors: [Colors.blueAccent, Colors.cyanAccent],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          'asset/img/Logo.png',
                          fit: BoxFit.fitWidth,
                        )),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius:
                          BorderRadius.circular(10.0), // 이 부분이 모서리를 둥글게 만듭니다.
                    ),
                    child: CupertinoButton(
                        child: Text(
                          '학과 : ' + _selected_dep,
                          style: TextStyle(fontSize: 15, color: Colors.white),
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
                                      _selectedItem1 = value;
                                      _selected_dep = dep_list[value];
                                    });
                                  },
                                  children: List<Widget>.generate(dep_list.length,
                                      (int index) {
                                    return Center(child: Text(dep_list[index]));
                                  }),
                                ),
                              );
                            })),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius:
                          BorderRadius.circular(10.0), // 이 부분이 모서리를 둥글게 만듭니다.
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 220, // 검색 필드의 너비를 조정할 수 있습니다.
                            child:TypeAheadField<String>(
                              controller: _controller,
                              suggestionsCallback: (pattern) async {

                                if(professor_search==true)
                                return professor_list.where((fruit) => fruit.toLowerCase().contains(pattern.toLowerCase())).toList();
                                else
                                  return class_list.where((fruit) => fruit.toLowerCase().contains(pattern.toLowerCase())).toList();
                              },
                              builder: (context,controller, focusNode) {
                                return TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      searchText = value; // 검색 텍스트를 업데이트합니다.
                                    });
                                  },
                                  focusNode: focusNode,
                                  controller: _controller,
                                  style: TextStyle(fontSize: 15, color: Colors.black),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    hintText: '과목 / 교수명 검색',
                                    border: InputBorder.none,
                                  ),
                                );
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },
                              onSelected: (sug) {
                                setState(() {
                                  searchText = sug;
                                  _controller.text = sug;
                                });
                                print('선택한 항목: $sug');
                              },
                            ),
                        ),
                        IconButton(
                          icon: Icon(Icons.search, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        class_recommend_screen(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ),
                            );

                            setState(() {
                              recentSearches.add(searchText);
                            });
                            // 검색 버튼이 눌렸을 때의 로직을 구현하세요.
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: professor_search,
                  onChanged: (bool? value) {
                    setState(() {
                      professor_search = value!;
                      class_search = !value;
                    });
                  },
                ),
                Text('교수명'),
                Checkbox(
                  value: class_search,
                  onChanged: (bool? value) {
                    setState(() {
                      class_search = value!;
                      professor_search = !value;
                    });
                  },
                ),
                Text('과목명'),
              ],
            ),


            SizedBox(height: 300,),
            GestureDetector(
                onTap: () => Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            homescreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    ),
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
                          ]),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 3),
                        )
                      ]),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ' 순위 검색 ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )),
            SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
