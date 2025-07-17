import 'package:intl/intl.dart';

final String teamName = "Đ.S 2 FC";

final List<Map<String, String>> fixtures = [
  {'date': '17:45, 09/07/2025', 'opponent': 'ANH KHÔI FC', 'duration': '90', 'result':'6 - 5','scorers':'HOÀNG HÀ (3), THỎA LÊ (1), ĐỨC CHINH (1), QUANG LÃM (1)'},
  {'date': '17:45, 16/07/2025', 'opponent': 'FAST FC', 'duration': '90', 'result':'4 - 4','scorers':'HOÀNG HÀ (2), ĐỨC CHINH (1), ĐỘ NGUYỄN (1)'},
  {'date': '17:45, 23/07/2025', 'opponent': 'OBD FC', 'duration': '90'},
  {'date': '17:45, 30/07/2025', 'opponent': 'ANH EM FC', 'duration': '90'},
  {'date': '17:45, 06/08/2025', 'opponent': 'NHÀ FC', 'duration': '90'},
  {'date': '17:45, 13/08/2025', 'opponent': 'THIẾT BỊ VĂN PHÒNG FC', 'duration': '90'},
  {'date': '17:45, 20/08/2025', 'opponent': 'MIỀN NAM FC', 'duration': '90'},
];

final String internal_match_minutes = '90';

Map<String, String>? getLastMatch(List<Map<String, String>> fixtures) {
  final now = DateTime.now();

  // Convert and filter matches that are in the past and have result
  final pastMatchesWithResults = fixtures
      .where((match) =>
          match.containsKey('result') &&
          DateFormat('HH:mm, dd/MM/yyyy').parse(match['date']!).isBefore(now))
      .toList();

  // Sort by date descending
  pastMatchesWithResults.sort((a, b) {
    final dateA = DateFormat('HH:mm, dd/MM/yyyy').parse(a['date']!);
    final dateB = DateFormat('HH:mm, dd/MM/yyyy').parse(b['date']!);
    return dateB.compareTo(dateA); // descending
  });

  return pastMatchesWithResults.isNotEmpty ? pastMatchesWithResults.first : null;
}