import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';
import 'package:easy_localization/easy_localization.dart';

class MatchCountdownWidget extends StatefulWidget {
  final DateTime matchDateTime;
  final String livestreamUrl;
  final String backgroundImage;
  final String team1;
  final String team2;
  final String stadium;
  final bool isExternalMatch; // ✅ NEW PARAM

  const MatchCountdownWidget({
    super.key,
    required this.matchDateTime,
    required this.livestreamUrl,
    required this.backgroundImage,
    required this.team1,
    required this.team2,
    required this.stadium,
    required this.isExternalMatch, // ✅ NEW PARAM
  });

  @override
  State<MatchCountdownWidget> createState() => _MatchCountdownWidgetState();
}

class _MatchCountdownWidgetState extends State<MatchCountdownWidget> {
  late Timer _timer;
  Duration? _timeRemaining;

  @override
  void initState() {
    super.initState();
    _updateCountdown();
    _timer = Timer.periodic(Duration(seconds: 1), (_) => _updateCountdown());
  }

void _updateCountdown() {
  final now = DateTime.now().toUtc().add(const Duration(hours: 7)); // match your timezone
  final difference = widget.matchDateTime.difference(now);
  if (!difference.isNegative) {
    setState(() {
      _timeRemaining = difference;
    });
  }
}

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_timeRemaining == null) {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 250,
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      );
    }

    if (_timeRemaining!.isNegative) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          tr("match_countdown.match_started"),
          style: TextStyle(fontSize: 20),
        ),
      );
    }

    final days = _timeRemaining!.inDays;
    final hours = _timeRemaining!.inHours % 24;
    final minutes = _timeRemaining!.inMinutes % 60;
    final seconds = _timeRemaining!.inSeconds % 60;

    return Container(
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.backgroundImage),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
                    Text(
            widget.isExternalMatch
                ? tr("match_countdown.title")  // vs other team
                : tr("match_countdown.title"), // internal match title
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _timeCard('$days', tr("match_countdown.days")),
              _timeCard('$hours', tr("match_countdown.hours")),
              _timeCard('$minutes', tr("match_countdown.minutes")),
              _timeCard('$seconds', tr("match_countdown.seconds")),
            ],
          ),
          SizedBox(height: 14),
          Text(
  widget.team1 == widget.team2
      ? tr("match_countdown.internal_title", args: [widget.team1])
      : tr("match_countdown.matchup", args: [widget.team1, widget.team2]),
  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
),
          Text(
            tr("match_countdown.kickoff", args: [
              DateFormat('HH:mm, dd/MM/yyyy').format(widget.matchDateTime)
            ]),
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
          Text(
            tr("match_countdown.location", args: [widget.stadium]),
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),

          if (widget.isExternalMatch) ...[
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => launchUrl(Uri.parse(widget.livestreamUrl)),
                icon: const Icon(Icons.live_tv),
                label: Text(tr("match_countdown.watch_livestream")),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ],
        ],
      ),
    );
  }

  Widget _timeCard(String time, String label) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(time, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
          Text(label, style: TextStyle(fontSize: 14, color: Colors.white)),
        ],
      ),
    );
  }
}