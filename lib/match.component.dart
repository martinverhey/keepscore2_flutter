import 'package:flutter/material.dart';

class Match {
  List playersTeam1;
  List playersTeam2;
  int scoreTeam1;
  int scoreTeam2;
  double pointsTeam1;
  double pointsTeam2;

  Match({
    required this.playersTeam1,
    required this.playersTeam2,
    required this.scoreTeam1,
    required this.scoreTeam2,
    required this.pointsTeam1,
    required this.pointsTeam2,
  });
}

class MatchComponent extends StatelessWidget {
  const MatchComponent({Key? key}) : super(key: key);

  static Match match = Match(
    playersTeam1: ['Player 1', 'Player 22312235'],
    playersTeam2: ['Player 3', 'Player 43152342235235234'],
    scoreTeam1: 99,
    scoreTeam2: 98,
    pointsTeam1: 99,
    pointsTeam2: -98,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Expanded(
        child: Row(
          children: [
            _points(match.pointsTeam1),
            Column(
              children: [
                Row(
                  children: [
                    _teamScore(match.scoreTeam1, const EdgeInsets.only(left: 8)),
                    _scoreDivider(),
                    _teamScore(match.scoreTeam2, const EdgeInsets.only(right: 8))
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [for (String player in match.playersTeam1) _player(player)],
                    ),
                    Column(
                      children: [for (String player in match.playersTeam2) _player(player)],
                    )
                  ],
                ),
              ],
            ),
            _points(match.pointsTeam2),
          ],
        ),
      ),
      // Column(
      //   children: [
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         _teamScore(match.scoreTeam1, const EdgeInsets.only(left: 8)),
      //         _scoreDivider(),
      //         _teamScore(match.scoreTeam2, const EdgeInsets.only(right: 8)),
      //       ],
      //     ),
      //     Row(
      //       children: [
      //         _points(match.pointsTeam1),
      //         _team1(match.playersTeam1),
      //         const SizedBox(width: 16),
      //         _team2(match.playersTeam2),
      //         _points(match.pointsTeam2),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }

  Widget _scoreDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 1),
      child: Text('-',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          )),
    );
  }

  Widget _teamScore(int score, EdgeInsets edgeInsets) {
    return Padding(
      padding: edgeInsets,
      child: Text(
        '$score',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _team1(List players) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
        mainAxisAlignment: MainAxisAlignment.center,
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

  _score(int scoreTeam1, int scoreTeam2) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$scoreTeam1',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            const TextSpan(
                text: '-',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 28,
                )),
            TextSpan(
              text: '$scoreTeam2',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _points(double points) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: _pointsArrow(points),
    );
  }

  Widget _pointsArrow(double points) => Row(
        children: [
          Text(
            points > 0 ? '▲' : '▼',
            style: TextStyle(color: points > 0 ? Colors.green : Colors.red),
          ),
          const SizedBox(width: 4),
          Text(
            '${points.toInt().abs()}',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      );
}
