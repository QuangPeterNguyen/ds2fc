import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    supportedLocales: [Locale('en'), Locale('vi')],
    path: 'assets/translations',
    fallbackLocale: Locale('vi'),
    startLocale: Locale('vi'),
    child: const DS2FCApp(),
  ));
}

class DS2FCApp extends StatefulWidget {
  const DS2FCApp({super.key});

  @override
  State<DS2FCApp> createState() => _DS2FCAppState();
}

class _DS2FCAppState extends State<DS2FCApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Đ.S 2 FC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      themeMode: _themeMode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: HomePage(toggleTheme: toggleTheme),
    );
  }
}

class HomePage extends StatelessWidget {
  final VoidCallback toggleTheme;
  const HomePage({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isVietnamese = context.locale.languageCode == 'vi';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đ.S 2 FC'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: toggleTheme,
            tooltip: 'Toggle Light/Dark Mode',
          ),
          IconButton(
            icon: Image.asset(
              isVietnamese ? 'assets/icons/us.png' : 'assets/icons/vn.png',
              width: 24,
              height: 24,
            ),
            onPressed: () {
              context.setLocale(isVietnamese ? const Locale('en') : const Locale('vi'));
            },
            tooltip: 'Toggle Language',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Đ.S 2 FC', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              title: Text('Home'.tr()),
              onTap: () {},
            ),
            ListTile(
              title: Text('Players'.tr()),
              onTap: () {},
            ),
            ListTile(
              title: Text('Fixtures'.tr()),
              onTap: () {},
            ),
            ListTile(
              title: Text('Results'.tr()),
              onTap: () {},
            ),
            ListTile(
              title: Text('Gallery'.tr()),
              onTap: () {},
            ),
            ListTile(
              title: Text('Contact'.tr()),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Welcome to Đ.S 2 FC!'.tr(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
