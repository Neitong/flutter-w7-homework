import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nested/nested.dart';
import 'package:provider/single_child_widget.dart';
import 'ui/screens/favorite/favorite_screen.dart';
import 'ui/screens/library/library_screen.dart';
import 'ui/screens/settings/settings_screen.dart';
import 'ui/states/settings_state.dart';
import 'ui/theme/theme.dart';

///
/// Launch the application with the given list of providers
///
void mainCommon(List<SingleChildWidget> providers) {
  runApp(
    MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp()),
    ),
  );
}
 

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 1;

  final List<Widget> _pages = [
    const LibraryScreen(),
    const FavoriteScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    AppSettingsState settingsState = context.watch<AppSettingsState>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(
        body: _pages[_currentIndex],

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: settingsState.theme.color,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.library_music),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.heart_broken),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
