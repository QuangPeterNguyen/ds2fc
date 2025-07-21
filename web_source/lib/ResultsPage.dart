import 'text_styles.dart';
import 'theme.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';
import 'data/fixtures.dart';
import 'package:intl/intl.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium?.color;

    final results = getHappenedMatches(fixtures);
    for (final match in results) {
      print(match['date']);
    }

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
                          Text('${match['date']}', style: AppTextStyles.body(context)),
                          Text('${'results.opponent'.tr()}: ${match['opponent']}', style: AppTextStyles.body(context)),
                          Text('${'results.score'.tr()}: ${match['score'] ?? 'N/A'}',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: theme.colorScheme.secondary)),
                          Text('${'results.location'.tr(args: [match['location'] as String])}', style: AppTextStyles.body(context)),
                          const SizedBox(height: 8),
                          if (scorers != null) ...[
                            Text('results.scorers'.tr(), style: AppTextStyles.body(context)),
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