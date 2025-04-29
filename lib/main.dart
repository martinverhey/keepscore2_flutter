// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keepscore2_flutter/competition/competitions.page.dart';
import 'package:keepscore2_flutter/matches/add-match/add-match.page.dart';
import 'package:keepscore2_flutter/matches/matches.page.dart';
import 'package:keepscore2_flutter/styles/styles.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Change to false to use live database instance.
const useDatabaseEmulator = true;
// The port we've set the Firebase Database emulator to run on via the
// `firebase.json` configuration file.
const emulatorPort = 9000;
const authPort = 9099;
// Android device emulators consider localhost of the host machine as 10.0.2.2
// so let's use that if running on Android.
final emulatorHost =
    (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) ? '10.0.2.2' : 'localhost';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (useDatabaseEmulator) {
    // FirebaseDatabase.instanceFor(
    //         app: Firebase.app(), databaseURL: '$emulatorHost:$emulatorPort?ns=keepscore2dev')
    //     .useDatabaseEmulator(emulatorHost, emulatorPort);
    FirebaseDatabase.instance.useDatabaseEmulator(emulatorHost, emulatorPort);
    FirebaseAuth.instance.useAuthEmulator(emulatorHost, authPort);
  }

  runApp(const KeepScore2());
}

class KeepScore2 extends StatelessWidget {
  const KeepScore2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'KeepScore 2',
      home: Home(),
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddMatchPage()),
          );
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
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                debugPrint('Trying to sign in');
                final success = await signIn();
                if (success && context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                }
              },
              child: const Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}

Future<bool> signIn() async {
  final creds = await FirebaseAuth.instance.signInAnonymously();
  debugPrint(creds.user?.uid);
  if (creds.user != null) {
    return true;
  }
  return false;
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
          onValueChanged: (int? value) {
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
FirebaseDatabase get $db => FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'http://localhost:9000?ns=keepscore2dev',
      // databaseURL: 'http://localhost:9000',
    );
