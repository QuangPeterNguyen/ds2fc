import 'package:flutter/material.dart';
import 'text_styles.dart';
import 'theme.dart';

class PartyRules extends StatelessWidget {
  const PartyRules({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> rules = [
      {
        'title': 'Không ai bị bỏ lại phía sau',
        'content':
            'Ai tham gia đá bóng thì được (và khuyến khích) tham gia nhậu. Không phân biệt ghi bàn hay thủ môn thủng lưới 😁',
      },
      {
        'title': 'Tôn trọng người mời – tôn trọng người mời lại',
        'content':
            'Ai mời bia thì người khác mời lại bằng đồ nhắm. Đội mình là đội công bằng và nghĩa tình!',
      },
      {
        'title': 'Không say không về (trừ khi có vợ gọi 😅)',
        'content':
            'Nhưng say phải có người dắt – tuyệt đối không ai được để bạn say một mình.',
      },
      {
        'title': 'Thua trận uống cho quên buồn – Thắng trận uống mừng thêm',
        'content':
            'Dù kết quả ra sao, anh em vẫn vui vẻ quây quần bên nhau. Đó mới là chiến thắng lớn nhất.',
      },
      {
        'title': 'Lên bàn là đồng đội – Xuống bàn là anh em',
        'content':
            'Không nói chuyện thua – chỉ nói chuyện vui. Tuyệt đối không cãi vã, nói lời khó nghe khi đã có men.',
      },
      {
        'title': 'Không lôi người vắng mặt ra bàn nhậu',
        'content':
            'Ai không tham gia hôm đó thì để bữa sau nói sau. Không nói sau lưng – nói trước mặt!',
      },
      {
        'title': 'Ăn nhậu có tâm – rửa chén có tầm',
        'content':
            'Người đến sau phụ dọn bàn. Người về sớm rửa chén trước. Ai không làm thì lần sau không được chọn món 😎',
      },
      {
        'title': 'Hát là phải có nhạc – Nhậu là phải có vui',
        'content':
            'Đội khuyến khích mang theo loa kéo, guitar, và cả giọng ca tiềm ẩn. Thể hiện đam mê, không chê bai!',
      },
      {
        'title': 'Kết thúc vui vẻ – Về nhà an toàn',
        'content':
            'Uống có kiểm soát. Tuyệt đối không tự lái xe về nếu đã có men. Đội luôn có người chở nhau về tận nhà.',
      },
      {
        'title': 'Góp tiền đúng giờ – Nhậu mới nở hoa',
        'content':
            'Mỗi buổi nhậu đều có quỹ. Góp đúng, góp đủ – nhậu mới bền, tình mới sâu.',
      },
    ];

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
          // Auto-sized card base
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
                Text(
                  title,
                  style: AppTextStyles.sectionTitle(context),
                ),
                const SizedBox(height: 12),
                Text(
                  content,
                  style: AppTextStyles.body(context),
                ),
              ],
            ),
          ),
          // Logo top-left overlapping
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
