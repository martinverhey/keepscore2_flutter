// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keepscore2_flutter/matches/matches.page.dart';
import 'package:keepscore2_flutter/styles/styles.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void main() {
  runApp(const KeepScore2());
}

class KeepScore2 extends StatelessWidget {
  const KeepScore2({Key? key}) : super(key: key);

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
  const Home({Key? key}) : super(key: key);

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
        const SegmentedControlExample(),
        const Text('Hi'),
      ][_currentPageIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: // Hmm
          NavigationBar(
        onDestinationSelected: _onItemTapped,
        selectedIndex: _currentPageIndex,
        destinations: const [
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
  const HomePage({Key? key}) : super(key: key);

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
      body: const Text('K'),
    );
  }
}

class SegmentedControlExample extends StatefulWidget {
  const SegmentedControlExample({Key? key}) : super(key: key);

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
