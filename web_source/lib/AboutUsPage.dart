import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'config.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Trigger rebuild when locale changes
    context.locale;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('about_us.title'.tr(args: [teamName]))),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/about_us_banner.png', // Ensure this image is 1200x630
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'about_us.intro'.tr(args: [teamName]),
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          Text(
            'about_us.mission_title'.tr(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text('about_us.mission'.tr()),
          const SizedBox(height: 20),
          Text(
            'about_us.history_title'.tr(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text('about_us.history'.tr(args:[teamName])),
          const SizedBox(height: 20),
          Text(
            'about_us.culture_title'.tr(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text('about_us.culture'.tr()),
        ],
      ),
    );
  }
}
