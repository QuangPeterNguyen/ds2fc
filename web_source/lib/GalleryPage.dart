import 'text_styles.dart';
import 'theme.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'config.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  // Manually list your images for now (can automate later)
  @override
  Widget build(BuildContext context) {

    context.locale;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: GridView.builder(
          padding: const EdgeInsets.all(16.0),
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