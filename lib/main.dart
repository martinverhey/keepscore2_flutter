// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'competition/competitions.page.dart';
import 'login/login.page.dart';
import 'matches/add-match/add-match.page.dart';
import 'matches/matches.page.dart';
import 'shared/helpers.dart';
import 'styles/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const KeepScore2());
}

final supabase = Supabase.instance.client;

class KeepScore2 extends StatelessWidget {
  const KeepScore2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KeepScore 2',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.green,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.green,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
          ),
        ),
      ),
      home: supabase.auth.currentSession == null ? const LoginPage() : const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentPageIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[
        const HomePage(),
        const MatchesPage(),
        const CompetitionsPage(),
        // const SegmentedControlExample(),
        const Text('Hi'),
      ][_currentPageIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToPage(context: context, page: const AddMatchPage());
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: // Hmm
          NavigationBar(
        onDestinationSelected: _onItemTapped,
        selectedIndex: _currentPageIndex,
        destinations: [
          NavigationDestination(
            icon: Icon(MdiIcons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(MdiIcons.trophy),
            label: 'Matches',
          ),
          NavigationDestination(
            icon: Icon(MdiIcons.listBox),
            label: 'Competitions',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KeepScore 2'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
            tooltip: 'New',
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                navigateToPage(
                  context: context,
                  page: const LoginPage(),
                );
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> signIn() async {
  // final creds = await FirebaseAuth.instance.signInAnonymously();
  // debugPrint(creds.user?.uid);
  // if (creds.user != null) {
  //   return true;
  // }
  // return false;
  await Future.delayed(Duration.zero);
  return true;
}

class SegmentedControlExample extends StatefulWidget {
  const SegmentedControlExample({super.key});

  @override
  State<SegmentedControlExample> createState() => _SegmentedControlExampleState();
}

class _SegmentedControlExampleState extends State<SegmentedControlExample> {
  int _selectedSegment = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: CupertinoSlidingSegmentedControl(
          groupValue: _selectedSegment,
          onValueChanged: (value) {
            if (value != null) {
              setState(() {
                _selectedSegment = value;
              });
            }
          },
          children: const <int, Widget>{
            0: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Midnight',
              ),
            ),
            1: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Viridian',
              ),
            ),
            2: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Cerulean',
              ),
            ),
          },
        ),
      ),
      child: Center(
        child: Text(
          'Selected Segment: $_selectedSegment',
        ),
      ),
    );
  }
}

AppStyle get $styles => AppStyle();
// FirebaseDatabase get $db => FirebaseDatabase.instanceFor(
//       app: Firebase.app(),
//       databaseURL: 'http://localhost:9000?ns=keepscore2dev',
//       // databaseURL: 'http://localhost:9000',
//     );

extension ContextExtension on BuildContext {
  void showSnackBar(String message, {bool isError = false}) {
    print(message);
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? Theme.of(this).colorScheme.error
            : Theme.of(this).snackBarTheme.backgroundColor,
      ),
    );
  }
}
