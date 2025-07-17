import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';
import 'data/fixtures.dart';
import 'package:intl/intl.dart';

List<Map<String, Object>> getHappenedMatches(List<Map<String, Object>> fixtures) {
  final now = DateTime.now();
  final dateFormat = DateFormat('HH:mm, dd/MM/yyyy');

  final happened = fixtures.where((match) {
    final dateStr = match['date'] as String;
    final matchDate = dateFormat.parse(dateStr);
    return matchDate.isBefore(now);
  }).toList();

  happened.sort((a, b) {
    final dateA = dateFormat.parse(a['date'] as String);
    final dateB = dateFormat.parse(b['date'] as String);
    return dateA.compareTo(dateB); // ascending
  });

  return happened;
}

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium?.color;

    final results = getHappenedMatches(fixtures);

    return Scaffold(
      appBar: AppBar(
        title: Text('results.title'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'results.kinhdo_league'.tr(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final match = results[index];
                  final scorers = match['scorers'] as List<dynamic>?;

                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.only(bottom: 20),
                    elevation: 4,
                    color: theme.cardColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${match['date']}', style: TextStyle(fontSize: 16, color: textColor)),
                          Text('${'results.opponent'.tr()}: ${match['opponent']}', style: TextStyle(fontSize: 16, color: textColor)),
                          Text('${'results.score'.tr()}: ${match['score'] ?? 'N/A'}',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: theme.colorScheme.secondary)),
                          Text('${'results.location'.tr(args: [match['location'] as String])}', style: TextStyle(fontSize: 16, color: textColor)),
                          const SizedBox(height: 8),
                          if (scorers != null) ...[
                            Text('results.scorers'.tr(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: theme.colorScheme.primary)),
                            const SizedBox(height: 4),
                            ...scorers.map<Widget>((scorer) {
                              final name = scorer['name'] as String;
                              final goals = scorer['goals'].toString();
                              return Text(
                                '- $name ($goals ${'results.goal'.tr()})',
                                style: TextStyle(color: textColor),
                              );
                            }).toList(),
                          ],
                          if (match['livestream'] != null) ...[
                            const SizedBox(height: 10),
                            TextButton.icon(
                              onPressed: () async {
                                final livestream = match['livestream'] as String;
                                final url = Uri.parse(livestream);
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url, mode: LaunchMode.externalApplication);
                                }
                              },
                              icon: const Icon(Icons.live_tv),
                              label: Text('results.watch_livestream'.tr()),
                            )
                          ]
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}