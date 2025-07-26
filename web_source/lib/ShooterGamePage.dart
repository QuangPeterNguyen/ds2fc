import 'package:flutter/material.dart';
import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'config.dart';

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
  if (_shotsTaken >= 5 || _shooterController.text.trim().isEmpty) {
    if (_shooterController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('enter_name_prompt'.tr())),
      );
    }
    return;
  }

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
        child: Column(
          children: [
            TextField(
              controller: _shooterController,
              readOnly: _winnerDeclared, 
              decoration: InputDecoration(
                labelText: 'shooter_name'.tr(),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
            onPressed: (_shotsTaken < 5) ? _shoot : null,
            child: Text(tr('shoot_button', args: ['$_shotsTaken'])),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _results.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text(tr('shot_number', args: ['${index + 1}'])),
                    title: Text(_results[index].tr()),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            if (_shotsTaken == 5) ...[
              Text(
                tr('total_goals', args: ['${_results.where((r) => r == 'goal_text').length}']),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _winnerDeclared ? null : _setWinner,
                child: Text('declare_winner'.tr()),
              ),
              const SizedBox(height: 8),
              if (_selectedWinner != null)
                Column(
                  children: [
                    Text(
                      tr('winner_text', args: [_selectedWinner!['name']!]),
                      style: const TextStyle(fontSize: 20, color: Colors.green),
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
            OutlinedButton(
              onPressed: _resetGame,
              child: Text('play_again'.tr()),
            ),
          ],
        ),
      ),
    );
  }
} 
