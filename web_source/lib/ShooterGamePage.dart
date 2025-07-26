import 'package:flutter/material.dart';
import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'config.dart';
import 'text_styles.dart';
import 'theme.dart';

class ShooterGamePage extends StatefulWidget {
  const ShooterGamePage({super.key});

  @override
  State<ShooterGamePage> createState() => _ShooterGamePageState();
}

class _ShooterGamePageState extends State<ShooterGamePage> {
  final TextEditingController _shooterController = TextEditingController();
  final List<String> _results = [];
  int _shotsTaken = 0;
  Map<String, String>? _selectedWinner;
  final Random _random = Random();
  bool _winnerDeclared = false;

void _shoot() {

  setState(() {
    bool isGoal = _random.nextBool();
    _results.add(isGoal ? 'goal_text' : 'save_text');
    _shotsTaken++;
  });
}

  void _resetGame() {
    setState(() {
      _results.clear();
      _shotsTaken = 0;
      _selectedWinner = null;
      _winnerDeclared = false;
    });
  }

  void _setWinner() {
    setState(() {
      _selectedWinner = players[_random.nextInt(players.length)];
      _winnerDeclared = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Builder(
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(child:Column(
          children: [
            if(!_winnerDeclared) ...[
            ElevatedButton.icon(
            onPressed: (_shotsTaken < 5) ? _shoot : null,
            icon: const Icon(Icons.sports_soccer, color: AppColors.buttonTextIconColor),
            label: Text(tr('shoot_button', args: ['$_shotsTaken']), style: AppTextStyles.body(context).copyWith(color: AppColors.buttonTextIconColor)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            ),],
            if(!_winnerDeclared) ...[
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _results.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text(tr('shot_number', args: ['${index + 1}']), style: AppTextStyles.body(context)),
                    title: Text(_results[index].tr(), style: AppTextStyles.sectionTitle(context)),
                  );
                },
              ),
            ),],
            const SizedBox(height: 16),
            if (_shotsTaken == 5) ...[
              Text(
                tr('total_goals', args: ['${_results.where((r) => r == 'goal_text').length}']),
                style: AppTextStyles.sectionTitle(context),
              ),
              if(!_winnerDeclared) ...[
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _winnerDeclared ? null : _setWinner,
                icon: const Icon(Icons.emoji_events, color: AppColors.buttonTextIconColor),
                label: Text('declare_winner'.tr(), style: AppTextStyles.body(context).copyWith(color: AppColors.buttonTextIconColor)),
                style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),],
              const SizedBox(height: 8),
              if (_selectedWinner != null)
                Column(
                  children: [
                    Text(
                      tr('winner_text', args: [_selectedWinner!['name']!]),
                      style: AppTextStyles.sectionTitle(context),
                    ),
                    const SizedBox(height: 8),
                    Image.asset(
                      _selectedWinner!['image']!,
                      fit: BoxFit.cover,
                      width: 200,
                    ),
                  ],
                ),
            ],
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _resetGame,
                icon: const Icon(Icons.replay, color: AppColors.buttonTextIconColor),
                label: Text('play_again'.tr(), style: AppTextStyles.body(context).copyWith(color: AppColors.buttonTextIconColor)),
                style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            )),
          ],
        )),
      ),
    );
  }
} 
