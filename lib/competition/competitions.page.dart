import 'package:flutter/material.dart';
import 'package:keepscore2_flutter/competition/competition.component.dart';
import 'package:keepscore2_flutter/shared/components/custom_cupertino_sliver_navigation_bar.dart';

import '../main.dart';

class CompetitionsPage extends StatelessWidget {
  const CompetitionsPage({super.key});

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
    return CustomCupertinoSliverNavigationBar(
      title: 'Competitions',
      trailing: InkWell(
        onTap: () {
          print('Add competition'); // TODO: Add Competition
        },
        child: Material(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DefaultTextStyle(
                style: TextStyle(
                  color: $styles.colors.orange,
                  fontWeight: FontWeight.bold,
                ),
                child: const Text('Add'),
              ),
            ],
          ),
        ),
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
          child: const CompetitionComponent(
            competitionName: 'Competition X',
            playerName: 'Martini',
            rank: 1250,
          ),
        ),
        childCount: 5,
      ),
    );
  }
}
