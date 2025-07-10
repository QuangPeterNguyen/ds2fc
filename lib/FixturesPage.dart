import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class FixturesPage extends StatelessWidget {
  const FixturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> fixtures = [
      {'date': 'Thứ 4, 10/07/2025', 'opponent': 'ANH KHÔI FC'},
      {'date': 'Thứ 4, 17/07/2025', 'opponent': 'OBD FC'},
      {'date': 'Thứ 4, 24/07/2025', 'opponent': 'FAST FC'},
      {'date': 'Thứ 4, 31/07/2025', 'opponent': 'ANH EM FC'},
      {'date': 'Thứ 4, 07/08/2025', 'opponent': 'NHÀ FC'},
      {'date': 'Thứ 4, 14/08/2025', 'opponent': 'THIẾT BỊ VĂN PHÒNG FC'},
      {'date': 'Thứ 4, 21/08/2025', 'opponent': 'MIỀN NAM FC'},
    ];

    final Color primaryColor = const Color(0xFF50BFE6); // Sky blue
    final Color accentColor = const Color(0xFF003366); // Navy

    return Scaffold(
      appBar: AppBar(
        title: Text('fixtures.title'.tr()),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? accentColor
            : primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'fixtures.regular_schedule'.tr(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.dark
                    ? primaryColor
                    : accentColor,
              ),
            ),
            const SizedBox(height: 8),
            Text('fixtures.regular_description'.tr()),
            const SizedBox(height: 24),
            Text(
              'fixtures.upcoming_matches'.tr(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.dark
                    ? primaryColor
                    : accentColor,
              ),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: fixtures.length,
              itemBuilder: (context, index) {
                final match = fixtures[index];
                return Card(
                  color: Theme.of(context).cardColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: primaryColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          match['date']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'fixtures.match_vs'.tr(args: [match['opponent']!]),
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text('fixtures.time_location'.tr()),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}