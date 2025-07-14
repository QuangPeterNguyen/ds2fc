
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'components/PlayerCard.dart';

class PlayersPage extends StatelessWidget {
  const PlayersPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            {'name': 'Hưng', 'image': 'assets/images/players/hung.png'},            

            {'name': 'Quang Tèo', 'image': 'assets/images/players/quangteo.png'},
            {'name': 'Đình Lâm', 'image': 'assets/images/players/dinhlam.png'},
            {'name': 'Nguyễn Thanh Tâm', 'image': 'assets/images/players/nguyenthanhtam.png'},

            {'name': 'Trương Tuấn Phương', 'image': 'assets/images/players/truongtuanphuong.png'},
            {'name': 'Hoàng Trí', 'image': 'assets/images/players/hoangtri.png'},
            {'name': 'Hoanglich', 'image': 'assets/images/players/hoanglich.png'},
            {'name': 'Hoàng Doãn Viên', 'image': 'assets/images/players/hoangdoanvien.png'},
            {'name': 'NGUYENCUONG', 'image': 'assets/images/players/nguyencuong.png'},
            {'name': 'Hiếu', 'image': 'assets/images/players/hieu.png'},
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

    final Color primaryColor = const Color(0xFF50BFE6); // Sky blue
    final Color accentColor = const Color(0xFF003366); // Navy blue

    return Scaffold(
      appBar: AppBar(
        title: Text('Players'.tr()),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? accentColor
            : primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
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