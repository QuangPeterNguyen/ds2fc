import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

import 'PlayersPage.dart';
import 'FixturesPage.dart';
import 'ResultsPage.dart';
import 'JoinUsPage.dart';
import 'GalleryPage.dart';
import 'AboutUsPage.dart';
import 'components/PlayerCard.dart';
import 'widgets/MatchCountdownWidget.dart';

import 'data/fixtures.dart';



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
      const ResultsPage(),
      const GalleryPage(),
      const JoinUsPage(),
      const AboutUsPage(),
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
  decoration: const BoxDecoration(

  ),
  child: Image.asset(
    'assets/images/logo/drawer_icon.png',
    fit: BoxFit.contain,
    width: double.infinity,
    height: double.infinity,
  ),
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
      ListTile(
        title: Text('Results'.tr()),
        onTap: () {
          _onItemTapped(3);
          Navigator.pop(context);
        },
      ),
      ListTile(
        title:  Text('gallery.title'.tr()),
        onTap: () {
          _onItemTapped(4);
          Navigator.pop(context);
        },
      ),
      ListTile(
        title: Text('join_us.title'.tr()),
        onTap: () {
          _onItemTapped(5);
          Navigator.pop(context);
        },
      ),
      ListTile(
        title: Text('about_us.title'.tr()),
        onTap: () {
          _onItemTapped(6);
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

class _HomeContent extends StatefulWidget {
  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent> {
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

  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      setState(() {
        _currentPage = (_currentPage + 1) % bannerImages.length;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
      _startAutoScroll();
    });
  }

  void _goToPrevious() {
    setState(() {
      _currentPage = (_currentPage - 1 + bannerImages.length) % bannerImages.length;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _goToNext() {
    setState(() {
      _currentPage = (_currentPage + 1) % bannerImages.length;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // GMT+7 safe time
DateTime getNowInGMT7() {
  return DateTime.now().toUtc().add(const Duration(hours: 7));
}
DateTime getNextInternalMatchDateTime() {
  final now = getNowInGMT7();
  print("getNextInternalMatchDateTime = $now");
  // Today at 6PM (in GMT+7)
  final todayAt6PM = DateTime.utc(now.year, now.month, now.day, 11); // 6PM GMT+7 = 11AM UTC

  // Check if it's Monday or Friday and still before 6PM
  if ((now.weekday == DateTime.monday || now.weekday == DateTime.friday) &&
      now.isBefore(todayAt6PM.add(Duration(hours: 7)))) {
    return todayAt6PM.add(Duration(hours: 7)); // Return in GMT+7
  }

  // Otherwise find next Monday or Friday
  for (int i = 1; i <= 7; i++) {
    final candidate = now.add(Duration(days: i));
    if (candidate.weekday == DateTime.monday || candidate.weekday == DateTime.friday) {
      return DateTime.utc(candidate.year, candidate.month, candidate.day, 11)
          .add(Duration(hours: 7)); // Return 6PM GMT+7
    }
  }

  return now;
}

DateTime parseFixtureDate(String? dateStr) {
  try {
    final formatter = DateFormat('HH:mm, dd/MM/yyyy');
    if (dateStr == null) throw FormatException("Date string is null");
    return formatter.parse(dateStr).toUtc().add(const Duration(hours: 7));
  } catch (_) {
    return DateTime.now();
  }
}

Map<String, dynamic> getNextMatch(List<Map<String, String>> fixtures) {
  final now = getNowInGMT7();

  // Skip internal match if it's over (past 2 hours)
  final internal = getNextInternalMatchDateTime();
  final internalEnd = internal.add(const Duration(hours: 2));
  final internalAvailable = now.isBefore(internalEnd);

  DateTime? externalTime;
  String? externalOpponent;

  for (var fixture in fixtures) {
    try {
      final dt = parseFixtureDate(fixture['date']);
      final matchEnd = dt.add(const Duration(hours: 2));

      if (now.isBefore(matchEnd)) {
        if (externalTime == null || dt.isBefore(externalTime)) {
          externalTime = dt;
          externalOpponent = fixture['opponent'];
        }
      }
    } catch (_) {}
  }

  // ✅ External only overrides internal if earlier and still not ended
  if (externalTime != null && (!internalAvailable || externalTime.isBefore(internal))) {
    return {
      'datetime': externalTime,
      'opponent': externalOpponent ?? '',
      'isExternal': true,
    };
  }

  // ✅ Otherwise fallback to internal match
  return {
    'datetime': internal,
    'opponent': 'Đ.S 2 FC',
    'isExternal': false,
  };
}

  @override
  Widget build(BuildContext context) {
    final nextMatch = getNextMatch(fixtures);
    final time = nextMatch['datetime'];
    print("nextMatch == $time");
    final double bannerHeight = MediaQuery.of(context).size.width * 0.4;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('home.title'.tr(), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text('home.subtitle'.tr(), style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 20),

          // ✅ Countdown
          MatchCountdownWidget(
            matchDateTime: nextMatch['datetime'],
            livestreamUrl: 'https://www.facebook.com/Phuisg.tv',
            backgroundImage: 'assets/images/stadium.png',
            team1: 'Đ.S 2 FC',
            team2: nextMatch['opponent'],
            stadium: 'home.stadium'.tr(),
            isExternalMatch: nextMatch['isExternal'],
          ),

          const SizedBox(height: 20),
          SizedBox(
            height: bannerHeight,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: bannerImages.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        bannerImages[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  },
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(bannerImages.length, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                        ),
                      );
                    }),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: _goToPrevious,
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onPressed: _goToNext,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Text('home.recent_scorers'.tr(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recentScorers.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2 / 3,
            ),
            itemBuilder: (context, index) {
              final player = recentScorers[index];
              return PlayerCard(
                name: player['name']!,
                imagePath: player['image']!,
              );
            },
          ),
          const SizedBox(height: 30),
          Text('home.schedule_title'.tr(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Text('home.schedule_description'.tr()),
          const SizedBox(height: 30),
          Text('home.event_title'.tr(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Text('home.event_description'.tr()),
          const SizedBox(height: 30),
          Text('home.upcoming_matches'.tr(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Text('home.month_location'.tr()),
          const SizedBox(height: 8),
          ...fixtures.map((match) => Text(tr('home.match_vs', args: [match['opponent']!]))),
          const SizedBox(height: 30),
          Text('home.last_result'.tr(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Text('home.last_score'.tr()),
          Text('home.scorers'.tr()),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () async {
              const url = 'https://www.facebook.com/share/v/1CPgDwRomb/?mibextid=wwXIfr';
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Could not open livestream link')),
                );
              }
            },
            icon: const Icon(Icons.live_tv),
            label: Text('results.watch_livestream'.tr()),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}