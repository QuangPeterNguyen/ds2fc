import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  // Manually list your images for now (can automate later)
  final List<String> imagePaths = const [
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
    // Add more as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gallery')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: imagePaths.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 columns (adjust based on screen)
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      child: InteractiveViewer(
                        child: Image.asset(imagePaths[index], fit: BoxFit.contain),
                      ),
                    ),
                  );
                },
                child: Image.asset(
                  imagePaths[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}