import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:keepscore2_flutter/main.dart';
import 'package:keepscore2_flutter/matches/match.component.dart';

import '../competition/competition.repository.dart';
import '../shared/components/custom_cupertino_sliver_navigation_bar.dart';

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
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  // late Stream<DatabaseEvent> stream = $db
  //     .ref(
  //         '/matches/${CompetitionRepository.currentCompetition}/${CompetitionRepository.currentSeason}')
  //     .onValue;
  GameType selectedGameType = GameType.all;
  FirebaseDatabase database = FirebaseDatabase.instance;
  // FirebaseDatabase database =
  //     FirebaseDatabase.instanceFor(app: Firebase.app(), databaseURL: '$emulatorHost:$emulatorPort');
  // FirebaseDatabase database = FirebaseDatabase.instanceFor(
  //     app: Firebase.app(), databaseURL: '$emulatorHost:$emulatorPort?ns=keepscore2dev');

  @override
  void initState() {
    //     .instanceFor(
    //   app: Firebase.app(),
    //   databaseURL: 'http://127.0.0.1:9000?ns=keepscore2dev',
    // )
    // FirebaseDatabase.instance.ref('hello').onValue.listen((DatabaseEvent event) {
    //   if (event.snapshot.exists) {
    //     print(event.snapshot);
    //   }
    //   print('no snapshot');
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        _sliverAppBar(),
        SliverToBoxAdapter(
          child: IconButton(
              onPressed: () async {
                try {
                  database.ref('test/').push().set({'1': '2'});
                } catch (e) {
                  print(e);
                }
              },
              icon: Icon(Icons.add)),
        ),
        // _content(), TODO: ENABLE
      ]),
    );
  }

  Widget _sliverAppBar() {
    return CustomCupertinoSliverNavigationBar(
      title: 'Matches',
      trailing: Material(
        child: Row(
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
      ),
    );
  }

  Widget _content() {
    return StreamBuilder(
      stream: FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL: 'http://localhost:9000?ns=keepscore2dev',
      ).ref('/matches').onValue,
      // matches/-O11dCvm7qNoGpjhq0FJ/2024m07
      // stream: $db
      //     .ref(
      //         '/matches/${CompetitionRepository.currentCompetition}/${CompetitionRepository.currentSeason}')
      //     .onValue,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
        }

        print('Data: ${snapshot.data?.snapshot.value}');
        if (!snapshot.hasData || snapshot.data?.snapshot.value == null) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        Map<dynamic, dynamic> items = snapshot.data?.snapshot.value as Map<dynamic, dynamic>;

        print(items);

        List<Match> matches = [];
        // for (var i = 0; i < items.values.length; i++) {
        //   matches.add(
        //     Match(
        //       id: items.keys.toList()[i],
        //       name: items.values.toList()[i],
        //     ),
        //   );
        // }

        // matches.sort(
        //   (a, b) => a.name.compareTo(b.name),
        // );

        return SliverList(
          delegate: SliverChildListDelegate(
            matches.map((e) => MatchComponent(match: e)).toList(),
          ),
        );
      },
    );

    // return SliverList(
    //   delegate: SliverChildBuilderDelegate(
    //     (context, index) => Padding(
    //       padding: EdgeInsets.only(
    //         bottom: $styles.insets.m,
    //         left: $styles.insets.m,
    //         right: $styles.insets.m,
    //       ),
    //       child: const MatchComponent(),
    //     ),
    //     childCount: 5,
    //   ),
    // );
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