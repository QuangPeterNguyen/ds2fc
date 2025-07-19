import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final String teamName = "Đ.S 2 FC";
final String intermalStadium = "KINH ĐÔ";

List<Map<String, dynamic>> fixtures = [];

final String internal_match_minutes = '90';

Future<List<Map<String, dynamic>>> getFixturesForClub(String clubId) async {
  final firestore = FirebaseFirestore.instance;

  final snapshot = await firestore
      .collection('clubs')
      .doc(clubId)
      .collection('fixtures')
      .orderBy('date') // Optional: sort by 'date' string
      .get();

  return snapshot.docs.map((doc) => doc.data()).toList();
}

Map<String, dynamic>? getLastMatch(List<Map<String, dynamic>> fixtures) {
  final now = DateTime.now();
  final dateFormat = DateFormat('HH:mm, dd/MM/yyyy');

  final pastMatchesWithResults = fixtures
      .where((match) =>
          dateFormat.parse(match['date'] as String).isBefore(now))
      .toList();

  pastMatchesWithResults.sort((a, b) {
    final dateA = dateFormat.parse(a['date'] as String);
    final dateB = dateFormat.parse(b['date'] as String);
    return dateB.compareTo(dateA); // descending
  });

  return pastMatchesWithResults.isNotEmpty ? pastMatchesWithResults.first : null;
}

List<Map<String, dynamic>> getUpcomingMatches(List<Map<String, dynamic>> fixtures) {
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


List<Map<String, dynamic>> getHappenedMatches(List<Map<String, dynamic>> fixtures) {
  final now = DateTime.now();
  final dateFormat = DateFormat('HH:mm, dd/MM/yyyy');
  final happened = fixtures
      .where((match) {
        final parsedDate = dateFormat.parse(match['date'] as String); // Local time
        return parsedDate.isBefore(now);
      })
      .toList();

  happened.sort((a, b) {
    final dateA = dateFormat.parse(a['date'] as String);
    final dateB = dateFormat.parse(b['date'] as String);
    return dateB.compareTo(dateA); // Sort descending
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