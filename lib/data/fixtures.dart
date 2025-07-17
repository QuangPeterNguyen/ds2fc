import 'package:intl/intl.dart';

final String teamName = "Đ.S 2 FC";
final String intermalStadium = "KINH ĐÔ";

final List<Map<String, Object>> fixtures = [
  {
    'date': '17:45, 09/07/2025',
    'opponent': 'ANH KHÔI FC',
    'duration': '90',
    'score': '6 - 5',
    'location': 'KINH ĐÔ',
    'livestream': 'https://www.facebook.com/watch/?v=1128690712641187',
    'scorers': [
      {'name': 'Hoàng Hà', 'goals': 3},
      {'name': 'Văn Thỏa', 'goals': 1},
      {'name': 'Đức Chinh', 'goals': 1},
      {'name': 'Quang Lãm', 'goals': 1},
    ]
  },
  {
    'date': '17:45, 16/07/2025',
    'opponent': 'FAST FC',
    'duration': '90',
    'score': '4 - 4',
    'location': 'KINH ĐÔ',
    'livestream': 'https://www.facebook.com/watch/?v=2009868119546685',
    'scorers': [
      {'name': 'Hoàng Hà', 'goals': 2},
      {'name': 'Đức Chinh', 'goals': 1},
      {'name': 'Đô Nguyễn', 'goals': 1},
    ]
  },
  {
    'date': '17:45, 23/07/2025',
    'opponent': 'OBD FC',
    'duration': '90',
    'location': 'KINH ĐÔ',
  },
  {
    'date': '17:45, 30/07/2025',
    'opponent': 'ANH EM FC',
    'duration': '90',
    'location': 'KINH ĐÔ',
  },
  {
    'date': '17:45, 06/08/2025',
    'opponent': 'NHÀ FC',
    'duration': '90',
    'location': 'KINH ĐÔ',
  },
  {
    'date': '17:45, 13/08/2025',
    'opponent': 'THIẾT BỊ VĂN PHÒNG FC',
    'duration': '90',
    'location': 'KINH ĐÔ',
  },
  {
    'date': '17:45, 20/08/2025',
    'opponent': 'MIỀN NAM FC',
    'duration': '90',
    'location': 'KINH ĐÔ',
  },
];

final String internal_match_minutes = '90';

Map<String, Object>? getLastMatch(List<Map<String, Object>> fixtures) {
  final now = DateTime.now();
  final dateFormat = DateFormat('HH:mm, dd/MM/yyyy');

  final pastMatchesWithResults = fixtures
      .where((match) =>
          match.containsKey('score') &&
          dateFormat.parse(match['date'] as String).isBefore(now))
      .toList();

  pastMatchesWithResults.sort((a, b) {
    final dateA = dateFormat.parse(a['date'] as String);
    final dateB = dateFormat.parse(b['date'] as String);
    return dateB.compareTo(dateA); // descending
  });

  return pastMatchesWithResults.isNotEmpty ? pastMatchesWithResults.first : null;
}

List<Map<String, Object>> getUpcomingMatches(List<Map<String, Object>> fixtures) {
  final now = DateTime.now();
  final dateFormat = DateFormat('HH:mm, dd/MM/yyyy');

  final upcoming = fixtures
      .where((match) {
        final matchDate = dateFormat.parse(match['date'] as String);
        return matchDate.isAfter(now);
      })
      .toList();

  upcoming.sort((a, b) {
    final dateA = dateFormat.parse(a['date'] as String);
    final dateB = dateFormat.parse(b['date'] as String);
    return dateA.compareTo(dateB); // ascending
  });

  return upcoming;
}

List<Map<String, Object>> getHappenedMatches(List<Map<String, Object>> fixtures) {
  final now = DateTime.now();
  final dateFormat = DateFormat('HH:mm, dd/MM/yyyy');

  final happened = fixtures
      .where((match) {
        final matchDate = dateFormat.parse(match['date'] as String);
        return matchDate.isBefore(now);
      })
      .toList();

  happened.sort((a, b) {
    final dateA = dateFormat.parse(a['date'] as String);
    final dateB = dateFormat.parse(b['date'] as String);
    return dateA.compareTo(dateB); // ascending order
  });

  return happened;
}

String formatScorers(List<dynamic> scorers) {
  return scorers.map((scorer) {
    final name = (scorer['name'] as String);
    final goals = scorer['goals'].toString();
    return '$name ($goals)';
  }).join(', ');
}