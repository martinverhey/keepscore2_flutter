import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../main.dart';
import '../shared/components/custom_cupertino_sliver_navigation_bar.dart';
import 'match.component.dart';
import 'matches_cubit.dart';

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

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MatchesCubit(),
      child: BlocBuilder<MatchesCubit, MatchesState>(
        builder: (context, state) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                if (state is MatchesInitial) ...[
                  SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
                if (state is MatchesLoaded) ...[
                  _sliverAppBar(state),
                  _content(state),
                ],
                if (state is MatchesError) ...[
                  SliverToBoxAdapter(
                    child: Center(
                      child: Text(state.error.toString()),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _sliverAppBar(MatchesLoaded state) {
    return CustomCupertinoSliverNavigationBar(
      title: 'Matches',
      trailing: Material(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (state.selectedGameType != GameType.all)
              Text(
                state.selectedGameType.value,
                style: TextStyle(
                  color: $styles.colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            PopupMenuButton<GameType>(
              initialValue: state.selectedGameType,
              onSelected: (value) {
                // TODO: emit value as new selectedGameType;
                // setState(() {
                //   selectedGameType = value;
                // });
              },
              child: Icon(
                state.selectedGameType == GameType.all
                    ? Icons.filter_alt_outlined
                    : Icons.filter_alt,
                color: $styles.colors.orange,
              ),
              itemBuilder: (context) {
                return [
                  for (GameType gameType in GameType.values)
                    PopupMenuItem<GameType>(
                      value: gameType,
                      child: Text(gameType.value),
                    ),
                ];
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _content(MatchesLoaded state) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: EdgeInsets.only(
            bottom: $styles.insets.m,
            left: $styles.insets.m,
            right: $styles.insets.m,
          ),
          child: MatchComponent(match: state.matches[index]),
        ),
        childCount: state.matches.length,
      ),
    );
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
}
