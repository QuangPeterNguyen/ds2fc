import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'PlayersPage.dart';
import 'FixturesPage.dart';

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
  ThemeMode _themeMode = ThemeMode.dark;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  final Color primaryColor = const Color(0xFF50BFE6); // Sky Blue
  final Color secondaryColor = const Color(0xFF003366); // Navy Blue

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Đ.S 2 FC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Colors.white,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: AppBarTheme(
          backgroundColor: secondaryColor,
          foregroundColor: Colors.white,
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color(0xFF1E1E1E),
        ),
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

class HomePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  const HomePage({super.key, required this.toggleTheme});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isVietnamese = context.locale.languageCode == 'vi';

    final List<Widget> pages = [
      _HomeContent(),
      const PlayersPage(),
      const FixturesPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đ.S 2 FC'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.toggleTheme,
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
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: const Text('Đ.S 2 FC', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              title: Text('Home'.tr()),
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Players'.tr()),
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Fixtures'.tr()),
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: pages[_selectedIndex],
    );
  }
}

class _HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> opponents = [
      'OBD FC',
      'FAST FC',
      'ANH EM FC',
      'NHÀ FC',
      'THIẾT BỊ VĂN PHÒNG FC',
      'MIỀN NAM FC',
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'home.title'.tr(),
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'home.subtitle'.tr(),
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 30),
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/banner.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'home.schedule_title'.tr(),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Text('home.schedule_description'.tr()),
          const SizedBox(height: 30),
          Text(
            'home.event_title'.tr(),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Text('home.event_description'.tr()),
          const SizedBox(height: 30),
          Text(
            'home.upcoming_matches'.tr(),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Text('home.month_location'.tr()),
          const SizedBox(height: 8),
          ...opponents.map((team) => Text(tr('home.match_vs', args: [team]))),
          const SizedBox(height: 30),
          Text(
            'home.last_result'.tr(),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Text('home.last_score'.tr()),
          Text('home.scorers'.tr()),
        ],
      ),
    );
  }
}
