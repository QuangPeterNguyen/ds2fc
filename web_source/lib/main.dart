// main.dart (Updated with AppTextStyles and AppColors)
import 'text_styles.dart';
import 'theme.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'config.dart';

import 'PlayersPage.dart';
import 'FixturesPage.dart';
import 'ResultsPage.dart';
import 'JoinUsPage.dart';
import 'GalleryPage.dart';
import 'AboutUsPage.dart';
import 'AdminFixturesPage.dart';
import 'LoginPage.dart';

import 'firebase_options.dart';
import 'components/PlayerCard.dart';
import 'widgets/MatchCountdownWidget.dart';

import 'data/fixtures.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGate extends StatelessWidget {
  final Widget child;
  const AuthGate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Future.microtask(() => Navigator.pushReplacementNamed(context, '/login'));
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else {
      return child;
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  fixtures = await getFixturesForClub(teamID);

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

  @override
  void initState() {
    super.initState();
    _loadThemeFromPrefs();
  }

  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final themeStr = prefs.getString('themeMode');
    setState(() {
      _themeMode = themeStr == 'light' ? ThemeMode.light : ThemeMode.dark;
    });
  }

  Future<void> _saveThemeToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', _themeMode.name);
  }

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
    _saveThemeToPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/admin': (context) => AuthGate(child: AdminFixturesPage(clubId: teamID)),
        '/login': (context) => const LoginPage(),
      },
      title: teamName,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
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
    final menuItems = [
              'Home',
              'Players',
              'Fixtures',
              'Results',
              'gallery.title',
              'join_us.title',
              'about_us.title'
            ];
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 6 ? menuItems[_selectedIndex].tr(args: [teamName]) : menuItems[_selectedIndex].tr()),
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
              decoration: const BoxDecoration(),
              child: Image.asset(
                teamLogo,
                fit: BoxFit.contain,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            ...[
              'Home',
              'Players',
              'Fixtures',
              'Results',
              'gallery.title',
              'join_us.title',
              'about_us.title'
            ].asMap().entries.map((entry) {
              final i = entry.key;
              final key = entry.value;
              return ListTile(
                title: Text(i == 6 ? key.tr(args: [teamName]) : key.tr(), style: AppTextStyles.body(context)),
                onTap: () {
                  _onItemTapped(i);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ],
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: pages[_selectedIndex],
      ),
    );
  }
}

// _HomeContent widget with theme and text style applied
class _HomeContent extends StatefulWidget {
  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent> {
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

Map<String, dynamic> getNextMatch(List<Map<String, dynamic>> fixtures) {
  final now = getNowInGMT7();

  // Internal match timing
  final internal = getNextInternalMatchDateTime();

  int internalDuration = int.parse(internal_match_minutes);
  int hours = internalDuration ~/ 60;
  int minutes = internalDuration % 60;
  final internalEnd = internal.add(Duration(hours: hours, minutes: minutes));
  final internalAvailable = now.isBefore(internalEnd);

  DateTime? externalTime;
  String? externalOpponent;
  String? duration;
  String? location;
  String? livestream;

  for (var fixture in fixtures) {
    try {
      final dt = parseFixtureDate(fixture['date'] as String);
      final fixtureDuration = int.parse(fixture['duration'] as String);

      final matchEnd = dt.add(Duration(
        hours: fixtureDuration ~/ 60,
        minutes: fixtureDuration % 60,
      ));

      if (now.isBefore(matchEnd)) {
        if (externalTime == null || dt.isBefore(externalTime)) {
          externalTime = dt;
          externalOpponent = fixture['opponent'] as String;
          duration = fixture['duration'] as String;
          location = fixture['location'] as String;
          if(fixture['livestream'] == null)
          {
            livestream = '';
          }else
          {
            livestream = fixture['livestream'] as String;
          }
        }
      }
    } catch (_) {
      // ignore parse errors
    }
  }

  if (externalTime != null &&
      (!internalAvailable || externalTime.isBefore(internal))) {
    return {
      'datetime': externalTime,
      'opponent': externalOpponent ?? '',
      'isExternal': true,
      'duration': duration,
      'location':location,
      'livestream':livestream,
    };
  }

  return {
    'datetime': internal,
    'opponent': teamName,
    'isExternal': false,
    'duration': internal_match_minutes,
    'location':intermalStadium,
    'livestream':""
  };
}

  @override
  Widget build(BuildContext context) {
    final nextMatch = getNextMatch(fixtures);
    final double bannerHeight = MediaQuery.of(context).size.width * 0.4;
    final lastMatch = getLastMatch(fixtures);
    final formatted = formatScorers(lastMatch!['scorers'] as List<dynamic>);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('home.title'.tr(args: [teamName]), style: AppTextStyles.headline(context)),
          const SizedBox(height: 10),
          Text('home.subtitle'.tr(args: [teamName]), style: AppTextStyles.body(context)),
          const SizedBox(height: 20),

          MatchCountdownWidget(
            matchDateTime: nextMatch['datetime'],
            livestreamUrl: nextMatch['livestream'],
            backgroundImage: 'assets/images/stadium.png',
            team1: teamName,
            team2: nextMatch['opponent'],
            stadium: 'home.stadium'.tr(args: [nextMatch['location'] as String]),
            duration: int.parse(nextMatch['duration']),
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
          Text('home.recent_scorers'.tr(), style: AppTextStyles.sectionTitle(context)),
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
          Text('home.schedule_title'.tr(), style: AppTextStyles.sectionTitle(context)),
          const SizedBox(height: 10),
          Text('home.schedule_description'.tr(args: [teamName]), style: AppTextStyles.body(context)),
          const SizedBox(height: 30),
          Text('home.event_title'.tr(), style: AppTextStyles.sectionTitle(context)),
          const SizedBox(height: 10),
          Text('home.event_description'.tr(args: [teamName]), style: AppTextStyles.body(context)),
          const SizedBox(height: 30),
          Text('home.upcoming_matches'.tr(), style: AppTextStyles.sectionTitle(context)),
          const SizedBox(height: 10),
          Text('home.month_location'.tr(), style: AppTextStyles.body(context)),
          const SizedBox(height: 8),
          ...fixtures.map((match) => Text(
            tr('home.match_vs', args: [teamName, match['opponent'] as String]),
            style: AppTextStyles.body(context),
          )),
          const SizedBox(height: 30),
          Text('home.last_result'.tr(), style: AppTextStyles.sectionTitle(context)),
          const SizedBox(height: 10),
          Text('${teamName} ${lastMatch['score'] ?? ''} ${lastMatch['opponent'] ?? ''}', style: AppTextStyles.body(context)),
          Text('${'home.scorers'.tr()}: ${formatted ?? ''}', style: AppTextStyles.body(context)),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () async {
              if (await canLaunchUrl(Uri.parse('${lastMatch['livestream'] ?? ''}'))) {
                await launchUrl(Uri.parse('${lastMatch['livestream'] ?? ''}'), mode: LaunchMode.externalApplication);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Could not open livestream link')),
                );
              }
            },
            icon: const Icon(Icons.live_tv, color: AppColors.buttonTextIconColor),
            label: Text('results.watch_livestream'.tr(), style: AppTextStyles.body(context).copyWith(color: AppColors.buttonTextIconColor)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
