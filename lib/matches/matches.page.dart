import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keepscore2_flutter/main.dart';
import 'package:keepscore2_flutter/match.component.dart';

enum GameType {
  all('All'),
  oneVsOne('1v1'),
  twoVsTwo('2v2'),
  threeVsThree('3v3'),
  fourVsFour('4v4'),
  other('Other');

  final String value;
  const GameType(this.value);
}

class MatchesPage extends StatefulWidget {
  const MatchesPage({Key? key}) : super(key: key);

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  GameType selectedGameType = GameType.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        _sliverAppBar(),
        _content(),
      ]),
    );
  }

  Widget _sliverAppBar() {
    return CupertinoSliverNavigationBar(
      largeTitle: Text(
        'Matches',
        style: TextStyle(color: $styles.colors.orange),
      ),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (selectedGameType != GameType.all)
            Text(
              selectedGameType.value,
              style: TextStyle(
                color: $styles.colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          PopupMenuButton<GameType>(
              initialValue: selectedGameType,
              onSelected: (GameType value) {
                setState(() {
                  selectedGameType = value;
                });
              },
              child: Icon(
                selectedGameType == GameType.all ? Icons.filter_alt_outlined : Icons.filter_alt,
                color: $styles.colors.orange,
              ),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem<GameType>(value: GameType.all, child: Text('All')),
                  const PopupMenuItem<GameType>(value: GameType.oneVsOne, child: Text('1v1')),
                  const PopupMenuItem<GameType>(value: GameType.twoVsTwo, child: Text('2v2')),
                  const PopupMenuItem<GameType>(value: GameType.other, child: Text('Other')),
                ];
              }),
        ],
      ),
    );
  }

  Widget _content() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: EdgeInsets.only(
            bottom: $styles.insets.m,
            left: $styles.insets.m,
            right: $styles.insets.m,
          ),
          child: const Match(),
        ),
        childCount: 5,
      ),
    );
  }
}

// final double _sliverAppBarHeight = 160.0;

// return SliverAppBar(
//   pinned: true,
//   snap: false,
//   floating: false,
//   expandedHeight: _sliverAppBarHeight,
//   backgroundColor: $styles.colors.orange,
//   title: Text('Matches'),
//   flexibleSpace: FlexibleSpaceBar(
//     title: const Text('Matches'),
//     background: Container(
//       color: $styles.colors.deepOrange,
//     ),
//     centerTitle: false,
//     // titlePadding: EdgeInsets.only(left: $styles.insets.xl, bottom: $styles.insets.xl),
//   ),
// );


// int _selectedSegment = 0;
// final List<String> segmentedControlTitles = ['All', '1v1', '2v2', 'Other'];

// SliverPadding(
//   padding: EdgeInsets.only(
//     top: $styles.insets.s,
//     bottom: $styles.insets.m,
//     left: $styles.insets.s,
//     right: $styles.insets.s,
//   ),
//   sliver: SliverList(
//     delegate: SliverChildListDelegate([
//       CupertinoSlidingSegmentedControl(
//         groupValue: _selectedSegment,
//         onValueChanged: (int? value) {
//           if (value != null) {
//             setState(() {
//               _selectedSegment = value;
//             });
//           }
//         },
//         children: _segmentedControlItems(),
//       ),
//     ]),
//   ),
// ),

// _segmentedControlItems() {
//   Map<int, Widget> segmentedControlMap = {};
//   for (int i = 0; i < segmentedControlTitles.length; i++) {
//     segmentedControlMap[i] = Text(
//       segmentedControlTitles[i],
//       style: i == _selectedSegment ? const TextStyle(fontWeight: FontWeight.w600) : null,
//     );
//   }
//   return segmentedControlMap;
// }