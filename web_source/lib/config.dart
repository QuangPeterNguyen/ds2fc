import 'text_styles.dart';
import 'theme.dart';
import 'package:flutter/material.dart';

//generals
final String teamID = "aefc";
final String teamName = "AE FC";
final String intermalStadium = "KINH ĐÔ";
final Color primaryColor = AppColors.primary; // Sky Blue
final Color secondaryColor = AppColors.secondary; // Navy Blue
final String teamLogo = 'assets/images/logo.png';

//main.dart
final List<String> bannerImages = [
'assets/images/about_us_banner.png',
'assets/images/about_us_banner.png',
'assets/images/about_us_banner.png',
'assets/images/about_us_banner.png',
];

final List<Map<String, String>> recentScorers = [
{'name': 'Hà Hoàng', 'image': 'assets/images/recent_scorers/haohoang.jpg'},
{'name': 'Tran Nguyen Thailand', 'image': 'assets/images/recent_scorers/trannguyenthailand.jpg'},
{'name': 'Tran Nguyen Thailand', 'image': 'assets/images/recent_scorers/trannguyenthailand.jpg'},
{'name': 'Tran Nguyen Thailand', 'image': 'assets/images/recent_scorers/trannguyenthailand.jpg'},
];

//Players.dart
final players = [
{'name': 'Hưng Đoàn', 'image': 'assets/images/players/hungdoan.png'},
{'name': 'Dung Nguyen', 'image': 'assets/images/players/dungnguyen.png'},
{'name': 'Dung Nguyen', 'image': 'assets/images/players/dungnguyen.png'},
{'name': 'Dung Nguyen', 'image': 'assets/images/players/dungnguyen.png'},
];

//GaleryPage.dart
final List<String> imagePaths = [
'assets/images/dungnguyen.png',
'assets/images/hungdoan.png',
'assets/images/hungdoan.png',
'assets/images/hungdoan.png',
];