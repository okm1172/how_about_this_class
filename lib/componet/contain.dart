import 'package:flutter/material.dart';

Widget buildKeywordWidget(String keyword) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0), // 좌우 패딩 추가
    decoration: BoxDecoration(
      color: Colors.grey.shade400,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min, // 최소 크기로 설정하여 텍스트 길이만큼만 차지하도록 함
      children: [
        Icon(
          Icons.sentiment_satisfied_alt,
          color: Colors.white,
        ),
        SizedBox(width: 5.0), // 아이콘과 텍스트 간격 조절
        Text(
          keyword,
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ],
    ),
  );
}
Widget buildKeywordWidget1(String keyword) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0), // 좌우 패딩 추가
    decoration: BoxDecoration(
      color: Colors.grey.shade400,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min, // 최소 크기로 설정하여 텍스트 길이만큼만 차지하도록 함
      children: [
        Icon(
          Icons.sentiment_dissatisfied_outlined,
          color: Colors.white,
        ),
        SizedBox(width: 5.0), // 아이콘과 텍스트 간격 조절
        Text(
          keyword,
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ],
    ),
  );
}Widget buildprofessrodWidget(String keyword) {
  return GestureDetector(
    onTap: (){},
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0), // 좌우 패딩 추가
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // 최소 크기로 설정하여 텍스트 길이만큼만 차지하도록 함
        children: [
          SizedBox(width: 5.0), // 아이콘과 텍스트 간격 조절
          Text(
            keyword,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ],
      ),
    ),
  );
}
