import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium?.color;

    final List<Map<String, dynamic>> results = [
      {
        'date': '09/07/2025',
        'opponent': 'ANH KHÔI FC',
        'score': '6 - 5',
        'location': 'Sân Kinh Đô',
        'livestream': 'https://www.facebook.com/share/v/1CPgDwRomb/?mibextid=wwXIfr',
        'scorers': [
          {'name': 'Hoàng Hà', 'goals': 3},
          {'name': 'Văn Thỏa', 'goals': 1},
          {'name': 'Đức Chinh', 'goals': 1},
          {'name': 'Quang Lãm', 'goals': 1},
        ]
      },
    ];

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
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final match = results[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.only(bottom: 20),
                    elevation: 4,
                    color: theme.cardColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${'results.date'.tr()}: ${match['date']}', style: TextStyle(fontSize: 16, color: textColor)),
                          Text('${'results.opponent'.tr()}: ${match['opponent']}', style: TextStyle(fontSize: 16, color: textColor)),
                          Text('${'results.score'.tr()}: ${match['score']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: theme.colorScheme.secondary)),
                          Text('${'results.location'.tr()}: ${match['location']}', style: TextStyle(fontSize: 16, color: textColor)),
                          const SizedBox(height: 8),
                          Text('results.scorers'.tr(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: theme.colorScheme.primary)),
                          const SizedBox(height: 4),
                          ...match['scorers'].map<Widget>((scorer) => Text(
                                '- ${scorer['name']} (${scorer['goals']} ${'results.goal'.tr()})',
                                style: TextStyle(color: textColor),
                              )),
                          if (match['livestream'] != null) ...[
                            const SizedBox(height: 10),
                            TextButton.icon(
                              onPressed: () async {
                                final url = Uri.parse(match['livestream']);
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