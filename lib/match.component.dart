import 'package:flutter/material.dart';
import 'package:keepscore2_flutter/main.dart';

class FMatch {
  List playersTeam1;
  List playersTeam2;
  int scoreTeam1;
  int scoreTeam2;
  double pointsTeam1;
  double pointsTeam2;

  FMatch({
    required this.playersTeam1,
    required this.playersTeam2,
    required this.scoreTeam1,
    required this.scoreTeam2,
    required this.pointsTeam1,
    required this.pointsTeam2,
  });
}

class Match extends StatelessWidget {
  const Match({Key? key}) : super(key: key);

  static FMatch match = FMatch(
    playersTeam1: ['Player 1', 'Player 22312235'],
    playersTeam2: ['Player 3', 'Player 43152342235235234', 'Player 5'],
    scoreTeam1: 99,
    scoreTeam2: 98,
    pointsTeam1: 99,
    pointsTeam2: -98,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: $styles.insets.l, vertical: $styles.insets.m),
      decoration: BoxDecoration(
        color: $styles.colors.grey200,
        borderRadius: BorderRadius.all(Radius.circular($styles.corners.s)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _points(match.pointsTeam1),
              const Spacer(),
              _teamScore(match.scoreTeam1, EdgeInsets.only(left: $styles.insets.m)),
              _scoreDivider(),
              _teamScore(match.scoreTeam2, EdgeInsets.only(right: $styles.insets.m)),
              const Spacer(),
              _points(match.pointsTeam2),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _team1(match.playersTeam1),
              SizedBox(width: $styles.insets.l),
              _team2(match.playersTeam2),
            ],
          ),
        ],
      ),
    );
  }

  Widget _scoreDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: $styles.insets.xxs),
      child: Text(
        '-',
        style: $styles.text.body.copyWith(color: $styles.colors.grey),
      ),
    );
  }

  Widget _teamScore(int score, EdgeInsets edgeInsets) {
    return Padding(
      padding: edgeInsets,
      child: Text(
        '$score',
        style: $styles.text.h1.copyWith(color: $styles.colors.black, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _team1(List players) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (String player in players) _player(player),
        ],
      ),
    );
  }

  Widget _team2(List players) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (String player in players) _player(player),
        ],
      ),
    );
  }

  Widget _player(String player) {
    return Text(
      player.replaceAll(
          ' ', '\u{000A0}'), // Replaces all spaces in text with Unicode No-Break Space character.
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _points(double points) {
    final bool isPositive = points > 0;
    final String icon = isPositive ? '▲' : '▼';
    final Color color = isPositive ? Colors.green : Colors.red;
    final String pointsText = '${points.toInt().abs()}';

    return Row(
      children: [
        Text(
          icon,
          style: TextStyle(color: color),
        ),
        SizedBox(width: $styles.insets.s),
        Text(
          pointsText,
          style: $styles.text.subtitle,
        ),
      ],
    );
  }
}
