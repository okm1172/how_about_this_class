import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:how_about_this_class/componet/item.dart';
import 'package:how_about_this_class/details_class_screen.dart';
import 'package:how_about_this_class/homescreen.dart';
import 'package:how_about_this_class/recommend_screen/professor_recommed_screen.dart';
import 'package:how_about_this_class/splash_screen/splash_screen.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:http/http.dart' as http;
class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  TextEditingController _controller = TextEditingController();
  int? selectedidx;
  int _selectedItem1=0 ;
  int _selectedItem2=0 ;
  int _selectedItem3=0 ;


  String _selected_major='전체';
  List<String> items = ['자료구조', '컴퓨터 네트워크', '클라우드 컴퓨팅', '이산수학','객체지향프로그래밍1','객체지향프로그래밍2','오픈소스응용프로그래밍','문제해결기법','컴퓨터종합설계','컴퓨터보안'];
  List<String> items0 = ['심정섭교수님', '권구인교수님', '권구인교수님', '이연교수님','이욱교수님','정진만교수님','심정섭교수님','김영호교수님','이문규교수님','이문규교수님'];
  List<String> items1 = ['컴퓨터공학과', '기계공학과', '체육교육과', '국어국문과'];
  List<String> items2 = ['1학년', '2학년', '3학년', '4학년'];
  List<String> items3 = ['교양', '전공'];
  List<String> items4 = ['5.0', '4.9','4.8','4.7','4.5','4.4','4.3','4.2','4.1','4.0'];

  String searchText = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, // 여기서 아이콘 색상을 검정색으로 설정합니다.
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title:GradientText("이 수업 어때 ?"
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
      ),

       body: Container(
         width: MediaQuery.of(context).size.width,
         height: MediaQuery.of(context).size.height,
         color: Colors.white,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
           SingleChildScrollView(
           scrollDirection: Axis.horizontal,
             child:
             Row(
               children:<Widget> [
                 SizedBox(width: 10,),
                 Container(
                   decoration: BoxDecoration(
                     color: Colors.grey.shade400,
                     borderRadius: BorderRadius.circular(30.0), // 이 부분이 모서리를 둥글게 만듭니다.
                   ),
                   child: CupertinoButton(child: Text('전공/교양:'+_selected_major,style: TextStyle(fontSize: 15,color: Colors.white),),
                       onPressed: () => showCupertinoModalPopup(context: context, builder: (BuildContext builder){
                         return Container(
                           height: MediaQuery.of(context).size.height / 3,
                           color: Colors.white,
                           child: CupertinoPicker(
                             itemExtent: 30,
                             onSelectedItemChanged: (int value3) {
                               setState(() {
                                 _selectedItem3 = value3;
                                 _selected_major=dep_list[value3];
                               });
                             },
                             children: List<Widget>.generate(dep_list.length, (int index) {
                               return Center(child: Text(dep_list[index]));
                             }),
                           ),
                         );
                       } )
                   ),),
                 SizedBox(width: 10,),
                 Container(
                   decoration: BoxDecoration(
                     color: Colors.grey.shade400,
                     borderRadius: BorderRadius.circular(30.0), // 이 부분이 모서리를 둥글게 만듭니다.
                   ),
                   child: Row(
                     children: [
                       SizedBox(
                         width: 220, // 검색 필드의 너비를 조정할 수 있습니다.
                         child: TypeAheadField<String>(
                           controller: _controller,
                           suggestionsCallback: (pattern) async {


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
                                 hintText: '과목 검색',
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
                           // 검색 버튼이 눌렸을 때의 로직을 구현하세요.
                         },
                       )
                     ],
                   ),
                 ),
               ],
             )
           ),
             Divider(color: Colors.grey, thickness: 2,),
             Row(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 SizedBox(width: 15,),
                 Text('순위',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                 SizedBox(width: 20,),
                 Text('과목',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                 Spacer(),
                 Text('추천도',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                 SizedBox(width: 15,)
               ],
             ),
             Divider(color: Colors.grey, thickness: 2,),
             Expanded(
               child: ListView.builder(
                   itemCount: items.length,
                   itemBuilder: (BuildContext context, int index){
                     if(searchText.isNotEmpty && !items[index].toLowerCase()
                         .contains(searchText.toLowerCase())){
                       return SizedBox.shrink();
                     }
                     else{
                       return Card(
                         elevation: 1,

                         child: GestureDetector(
                              onTap: (){setState(() {selectedidx=index;});
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) =>
                                      details_class_screen(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                                },


                           child: Container(
                             height: 60,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.all(Radius.circular(10)),
                               gradient: LinearGradient(
                                   begin: Alignment.centerLeft,
                                   end: Alignment.bottomRight,
                                   colors: selectedidx==index?[
                                     Colors.blueAccent,
                                     Colors.cyan,

                                   ]:[

                                     Colors.white,
                                     Colors.white,
                                   ]
                               ),
                             ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 15,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text((index+1).toString(), style: TextStyle(fontSize: 20),)
                                    ],
                                  ),
                                  SizedBox(width: 15,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    // Text(items[index]+' CSE1010'+'(23년2학기 기준)', style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                      Text.rich(TextSpan(
                                        text:items[index]+' CSE1010 ', style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                        children: <TextSpan> [TextSpan(
                                          text: '(23학년2학기 기준)',style: TextStyle(fontSize: 13 ,fontWeight: FontWeight.bold,color: Colors.grey)
                                        )]
                                      )),
                                      Text(items0[index], style: TextStyle(fontSize: 13,color: Colors.grey.shade700),),
                                      Text('학과: 컴퓨터공학과', style: TextStyle(fontSize: 13,color: Colors.grey.shade700),),

                                    ],
                                  ),
                                  Spacer(),
                                  Text(items4[index],style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: index<3? Colors.red:Colors.black )),
                                  SizedBox(width: 15,),
                                ],
                              ),
                           ),
                         ),
                       );
                     }
                   }
               ),
             ),

              SizedBox(height: 15,)

           ],
         ),
       ),
    );
  }




}

