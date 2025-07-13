import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';

class MatchCountdownWidget extends StatefulWidget {
  final DateTime matchDateTime;
  final String livestreamUrl;
  final String backgroundImage;

  const MatchCountdownWidget({
    super.key,
    required this.matchDateTime,
    required this.livestreamUrl,
    required this.backgroundImage,
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
    final now = DateTime.now();
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
        child: Text("⚽ Match has started!", style: TextStyle(fontSize: 20)),
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
            "⚽ Next Match Starts In:",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _timeCard('$days', 'Days'),
              _timeCard('$hours', 'Hours'),
              _timeCard('$minutes', 'Minutes'),
              _timeCard('$seconds', 'Seconds'),
            ],
          ),
          SizedBox(height: 14),
          Text(
            "Đ.S 2 FC vs FAST FC",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          Text(
            "Kickoff: ${DateFormat('HH:mm, EEEE dd/MM/yyyy').format(widget.matchDateTime)}",
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
          Text(
            "Location: Đường Số 2 Stadium",
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
          SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => launchUrl(Uri.parse(widget.livestreamUrl)),
            icon: Icon(Icons.live_tv),
            label: Text("Watch Livestream"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          )
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