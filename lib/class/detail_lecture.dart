class Lecture {
  final String lectureName;
  final List<String> professorNames;
  final String department;
  final List<PortalInfo> portal;
  final List<EverytimeInfo> everytime; // everytime 리스트 추가


  Lecture({
    required this.lectureName,
    required this.professorNames,
    required this.department,
    required this.portal,
    required this.everytime, // 생성자에 everytime 추가
  });

  factory Lecture.fromJson(Map<String, dynamic> json) {
    var professorNamesFromJson = List<String>.from(json['professor_name']);
    var portalList = List<PortalInfo>.from(json['portal'].map((x) => PortalInfo.fromJson(x)));
    // everytime 데이터가 없는 경우를 고려
    var everytimeList = json.containsKey('everytime')
        ? List<EverytimeInfo>.from(json['everytime'].map((x) => EverytimeInfo.fromJson(x)))
        : <EverytimeInfo>[];

    return Lecture(
      lectureName: json['lecture_name'],
      professorNames: professorNamesFromJson,
      department: json['department'],
      portal: portalList,
      everytime: everytimeList, //

    );
  }
}

class PortalInfo {
  final String option4;
  final String academicNumber;
  final String option5;
  final String totalCnt;
  final String option2;
  final String option3;
  final String lectureType;
  final String semester;
  final String surveyCnt;
  final String option1;

  PortalInfo({
    required this.option4,
    required this.academicNumber,
    required this.option5,
    required this.totalCnt,
    required this.option2,
    required this.option3,
    required this.lectureType,
    required this.semester,
    required this.surveyCnt,
    required this.option1,
  });

  factory PortalInfo.fromJson(Map<String, dynamic> json) {
    return PortalInfo(
      option4: json['option_4'],
      academicNumber: json['academic_number'],
      option5: json['option_5'],
      totalCnt: json['total_cnt'],
      option2: json['option_2'],
      option3: json['option_3'],
      lectureType: json['lecture_type'],
      semester: json['semester'],
      surveyCnt: json['survey_cnt'],
      option1: json['option_1'],
    );
  }
}

class EverytimeInfo {
  final String score4Cnt;
  final String ratingAverage;
  final String score3Cnt;
  final List<String> positiveKeywords;
  final String count;
  final String score1Cnt;
  final String negativeRatio;
  final String positiveRatio;
  final String semester;
  final String score2Cnt;
  final String score5Cnt;
  final List<String> negativeKeywords;

  EverytimeInfo({
    required this.score4Cnt,
    required this.ratingAverage,
    required this.score3Cnt,
    required this.positiveKeywords,
    required this.count,
    required this.score1Cnt,
    required this.negativeRatio,
    required this.positiveRatio,
    required this.semester,
    required this.score2Cnt,
    required this.score5Cnt,
    required this.negativeKeywords,
  });

  factory EverytimeInfo.fromJson(Map<String, dynamic> json) {
    return EverytimeInfo(
      score4Cnt: json['score_4_cnt'] ?? '0',
      ratingAverage: json['rating_average'] ?? '0.0',
      score3Cnt: json['score_3_cnt'] ?? '0',
      positiveKeywords: json['positive_kewords'] != null
          ? List<String>.from(json['positive_kewords'])
          : [],
      count: json['count'] ?? '0',
      score1Cnt: json['score_1_cnt'] ?? '0',
      negativeRatio: json['negative_ratio'] ?? '0.0',
      positiveRatio: json['positive_ratio'] ?? '0.0',
      semester: json['semester'] ?? '',
      score2Cnt: json['score_2_cnt'] ?? '0',
      score5Cnt: json['score_5_cnt'] ?? '0',
      negativeKeywords: json['negative_kewords'] != null
          ? List<String>.from(json['negative_kewords'])
          : [],
    );
  }
}
