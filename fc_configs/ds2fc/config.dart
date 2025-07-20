import 'text_styles.dart';
import 'theme.dart';
import 'package:flutter/material.dart';

//generals
final String teamID = "ds2fc";
final String teamName = "Đ.S 2 FC";
final String intermalStadium = "KINH ĐÔ";
final Color primaryColor = const AppColors.primary; // Sky Blue
final Color secondaryColor = const AppColors.secondary; // Navy Blue
final String teamLogo = 'assets/images/logo.png';

//main.dart
final List<String> bannerImages = [
'assets/images/about_us_banner.png',
'assets/images/banner1.jpg',
'assets/images/banner2.jpg',
'assets/images/banner3.jpg',
'assets/images/banner4.jpg',
'assets/images/banner5.jpg',
'assets/images/banner6.jpg',
'assets/images/banner7.jpg',
'assets/images/banner8.jpg',
'assets/images/banner9.jpg',
'assets/images/banner10.jpg',
'assets/images/banner11.jpg',
'assets/images/banner12.jpg',
'assets/images/banner13.jpg',
'assets/images/banner14.jpg',
'assets/images/banner15.jpg',
];

final List<Map<String, String>> recentScorers = [
{'name': 'Hà Hoàng', 'image': 'assets/images/recent_scorers/haohoang.jpg'},
{'name': 'Tran Nguyen Thailand', 'image': 'assets/images/recent_scorers/trannguyenthailand.jpg'},
{'name': 'Thỏa Lê', 'image': 'assets/images/recent_scorers/thoale.jpg'},
{'name': 'Quang Lãm', 'image': 'assets/images/recent_scorers/quanglam.jpg'},
];

//Players.dart
final players = [
{'name': 'Hưng Đoàn', 'image': 'assets/images/players/hungdoan.jpg'},
{'name': 'Dung Nguyen', 'image': 'assets/images/players/dungnguyen.jpg'},
{'name': 'Hồ Công Hòa', 'image': 'assets/images/players/hoconghoa.jpg'},
{'name': 'Hà Hoàng', 'image': 'assets/images/players/haohoang.jpg'},
{'name': 'Trung Lê', 'image': 'assets/images/players/trungle.jpg'},
{'name': 'Hoàng', 'image': 'assets/images/players/hoang.jpg'},
{'name': 'Nguyen Thuy', 'image': 'assets/images/players/nguyenthuy.png'},
{'name': 'Sinhgia2020', 'image': 'assets/images/players/sinhgia2020.jpg'},
{'name': 'Duy Mập', 'image': 'assets/images/players/duymap.jpg'},

{'name': 'Hậu Lê', 'image': 'assets/images/players/haule.jpg'},
{'name': 'Thanh Tra', 'image': 'assets/images/players/thanhtra.jpg'},
{'name': 'Tran Nguyen Thailand', 'image': 'assets/images/players/trannguyenthailand.jpg'},
{'name': 'Thỏa Lê', 'image': 'assets/images/players/thoale.jpg'},

{'name': 'Tung Lam', 'image': 'assets/images/players/tunglam.png'},
{'name': 'Binh Nguyen Danh', 'image': 'assets/images/players/binhnguyendanh.png'},
{'name': 'Quang Lãm', 'image': 'assets/images/players/quanglam.png'},
{'name': 'Vietho Cons', 'image': 'assets/images/players/viethocons.png'},
{'name': 'Buôn Sỉ Nội Y Backda', 'image': 'assets/images/players/buonsinoiybackda.png'},
{'name': 'Hiếu', 'image': 'assets/images/players/hieu.png'},
{'name': 'Hưng', 'image': 'assets/images/players/hung.png'},            

{'name': 'Quang Tèo', 'image': 'assets/images/players/quangteo.png'},
{'name': 'Đình Lâm', 'image': 'assets/images/players/dinhlam.png'},
{'name': 'Nguyễn Thanh Tâm', 'image': 'assets/images/players/nguyenthanhtam.png'},

{'name': 'Trương Tuấn Phương', 'image': 'assets/images/players/truongtuanphuong.png'},
{'name': 'Hoàng Trí', 'image': 'assets/images/players/hoangtri.png'},
{'name': 'Hoanglich', 'image': 'assets/images/players/hoanglich.png'},
{'name': 'Hoàng Doãn Viên', 'image': 'assets/images/players/hoangdoanvien.png'},
{'name': 'NGUYENCUONG', 'image': 'assets/images/players/nguyencuong.png'},

{'name': 'Khải', 'image': 'assets/images/players/khai.png'},

{'name': 'Tuấn', 'image': 'assets/images/players/tuan.png'},
{'name': 'Việt Tiến', 'image': 'assets/images/players/viettien.png'},

{'name': 'Trần Hưng', 'image': 'assets/images/players/tranhung.png'},
{'name': 'ABC', 'image': 'assets/images/players/abc.png'},
{'name': 'Nguyễn Định', 'image': 'assets/images/players/nguyendinh.png'},
            {'name': 'V Hiếu', 'image': 'assets/images/players/vhieu.png'},
{'name': 'Buithanhvu', 'image': 'assets/images/players/buithanhvu.png'},
{'name': 'Tiến Nguyễn', 'image': 'assets/images/players/tiennguyen.png'},

];

//GaleryPage.dart
final List<String> imagePaths = [
'assets/images/banner1.jpg',
'assets/images/banner2.jpg',
'assets/images/banner3.jpg',
'assets/images/banner4.jpg',
'assets/images/banner5.jpg',
'assets/images/banner6.jpg',
'assets/images/banner7.jpg',
'assets/images/banner8.jpg',
'assets/images/banner9.jpg',
'assets/images/banner10.jpg',
'assets/images/banner11.jpg',
'assets/images/banner12.jpg',
'assets/images/banner13.jpg',
'assets/images/banner14.jpg',
'assets/images/banner15.jpg',
];