class Lecture {
  final String lectureName;
  final String department;
  final String academicNumber;
  final String surveyCnt;
  final String totalCnt;
  final String semester;
  final Map<String, String> options;
  final int detailUk;
  final List<Professor> professors;

  Lecture({
    required this.lectureName,
    required this.department,
    required this.academicNumber,
    required this.surveyCnt,
    required this.totalCnt,
    required this.semester,
    required this.options,
    required this.detailUk,
    required this.professors,
  });

  factory Lecture.fromJson(Map<String, dynamic> json) {
    var options = <String, String>{
      'option_1': json['option_1'],
      'option_2': json['option_2'],
      'option_3': json['option_3'],
      'option_4': json['option_4'],
      'option_5': json['option_5'],
    };

    return Lecture(
      lectureName: json['lecture_name'],
      department: json['department'],
      academicNumber: json['academic_number'],
      surveyCnt: json['survey_cnt'],
      totalCnt: json['total_cnt'],
      semester: json['semester'],
      options: options,
      detailUk: json['detail_uk'],
      professors: (json['professors'] as List)
          .map((p) => Professor.fromJson(p))
          .toList(),
    );
  }
}

class Professor {
  final String name;

  Professor({required this.name});

  factory Professor.fromJson(Map<String, dynamic> json) {
    return Professor(name: json['name']);
  }
}
