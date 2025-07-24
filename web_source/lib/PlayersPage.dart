import 'text_styles.dart';
import 'theme.dart';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'components/PlayerCard.dart';
import 'config.dart';

class PlayersPage extends StatelessWidget {
  const PlayersPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Players'.tr()),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? secondaryColor
            : primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2 / 3, // for portrait images
          ),
          itemCount: players.length,
          itemBuilder: (context, index) {
            final player = players[index];
            return PlayerCard(
              name: player['name']!,
              imagePath: player['image']!,
            );
          },
        ),
      ),
    );
  }
}