import 'text_styles.dart';
import 'theme.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';
import 'data/fixtures.dart';
import 'package:intl/intl.dart';
import 'config.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child:
            Text(
              'results.kinhdo_league'.tr(),
              style: AppTextStyles.sectionTitle(context),
            )),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 0, left: 16.0, right: 16.0, bottom: 16.0),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final match = results[index];
                  final scorers = match['scorers'] as List<dynamic>?;

                  return Card(
                    color: Theme.of(context).cardColor,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: primaryColor.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${match['date']}', style: AppTextStyles.cardTitle(context)),
                          Text('${'results.opponent'.tr()}: ${match['opponent']}', style: AppTextStyles.body(context)),
                          Text('${'results.score'.tr()}: ${match['score'] ?? 'N/A'}',
                              style: AppTextStyles.body(context)),
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
                                style: AppTextStyles.body(context),
                              );
                            }).toList(),
                          ],
                          if (match['livestream'] != null) ...[
                            const SizedBox(height: 10),
                            ElevatedButton.icon(
                              onPressed: () async {
                                final livestream = match['livestream'] as String;
                                final url = Uri.parse(livestream);
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url, mode: LaunchMode.externalApplication);
                                }
                              },
                              icon: const Icon(Icons.live_tv, color: AppColors.buttonTextIconColor),
                              label: Text('results.watch_livestream'.tr(), style: AppTextStyles.body(context).copyWith(color: AppColors.buttonTextIconColor)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              )
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