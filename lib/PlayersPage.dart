import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class PlayersPage extends StatelessWidget {
  const PlayersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final players = [
      'Buithanhvu',
      'Hưng Đoàn',
      'Dung Nguyen',
      'Hồ Công Hòa',
      'Hà Hoàng',
      'Trung Lê',
      'Sinhgia2020',
      'ABC',
      'Nguyễn Định',
      'Quang Tèo',
      'Nguyễn Thanh Tâm',
      'Hậu Lê',
      'Thanh Tra',
      'Tran Nguyen Thailand',
      'V Hiếu',
      'Tiến Nguyễn',
      'Tung Lam',
      'Quang Lãm',
      'Đình Lâm',
      'Binh Nguyen Danh',
      'Vietho Cons',
      'Trương Tuấn Phương',
      'Hoàng Trí',
      'Hoanglich',
      'Hoàng',
      'Hoàng Doãn Viên',
      'NGUYENCUONG',
      'Hiếu',
      'Duy Mập',
      'Khải',
      'Buôn Sỉ Nội Y Backda',
      'Tuấn',
      'Việt Tiến',
      'Hưng',
      'Thỏa Lê',
      'Trần Hưng',
      'Nguyen Thuy',
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
            childAspectRatio: 3 / 2,
          ),
          itemCount: players.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? primaryColor.withOpacity(0.3)
                      : accentColor.withOpacity(0.2),
                ),
              ),
              elevation: 2,
              color: Theme.of(context).cardColor,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: const AssetImage('assets/images/avatar_placeholder.png'),
                      radius: 32,
                      backgroundColor: Theme.of(context).brightness == Brightness.dark
                          ? primaryColor.withOpacity(0.2)
                          : accentColor.withOpacity(0.1),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      players[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}