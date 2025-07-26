import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'text_styles.dart';
import 'theme.dart';

class PartyRules extends StatelessWidget {
  const PartyRules({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> rules = List.generate(10, (index) {
      return {
        'title': 'party_rules.title_$index'.tr(),
        'content': 'party_rules.content_$index'.tr(),
      };
    });

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: rules.length,
        itemBuilder: (context, index) {
          return Ds2fcCard(
            title: rules[index]['title']!,
            content: rules[index]['content']!,
          );
        },
      ),
    );
  }
}

class Ds2fcCard extends StatelessWidget {
  final String title;
  final String content;

  const Ds2fcCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 40),
            padding: const EdgeInsets.fromLTRB(16, 60, 16, 60),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor, width: 3),
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.sectionTitle(context)),
                const SizedBox(height: 12),
                Text(content, style: AppTextStyles.body(context)),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/images/logo.png',
              width: 96,
            ),
          ),
        ],
      ),
    );
  }
}