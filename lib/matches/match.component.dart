// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:keepscore2_flutter/main.dart';

class PlayerRank {
  String id;
  int rank;

  PlayerRank({
    required this.id,
    required this.rank,
  });
}

class Player {
  RankedPlayer player;
  String? userId;
  PlayerName? createdBy;
  DateTime createdAt;
  Competition competition;
  bool isCreator;
  bool isAdmin;
  List<SeasonHistoryEntry>? seasonHistory;

  Player({
    required this.player,
    this.userId,
    this.createdBy,
    required this.createdAt,
    required this.competition,
    required this.isCreator,
    required this.isAdmin,
    this.seasonHistory,
  });
}

class User {
  String id;
  List<Competition> competitions;
  // PlayerId + name necessary?

  User({
    required this.id,
    required this.competitions,
  });
}

class PlayerName {
  String id;
  String name;

  PlayerName({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory PlayerName.fromMap(Map<String, dynamic> map) {
    return PlayerName(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlayerName.fromJson(String source) =>
      PlayerName.fromMap(json.decode(source) as Map<String, dynamic>);
}

class RankedPlayer extends PlayerName {
  int rank;

  RankedPlayer({
    required super.id,
    required super.name,
    required this.rank,
  });
}

class SeasonHistoryEntry {
  String season;
  String endPosition;

  SeasonHistoryEntry({
    required this.season,
    required this.endPosition,
  });
}

class Competition {
  String id;
  String name;

  Competition({
    required this.id,
    required this.name,
  });
}

class Match {
  String id;
  String season;
  String competitionId;
  DateTime createdAt;
  PlayerName createdBy;
  double pointsTeam1;
  double pointsTeam2;
  int scoreTeam1;
  int scoreTeam2;
  List<RankedPlayer> playersTeam1;
  List<RankedPlayer> playersTeam2;
  Type type;

  Match({
    required this.id,
    required this.season,
    required this.competitionId,
    required this.createdAt,
    required this.createdBy,
    required this.pointsTeam1,
    required this.pointsTeam2,
    required this.scoreTeam1,
    required this.scoreTeam2,
    required this.playersTeam1,
    required this.playersTeam2,
    required this.type,
  });
}

class MatchDetails {
  String matchId;
  Map<String, List<PlayerRank>> ranks;
  Map<String, int> averageRank;
  Map<String, int> handicap;
  Map<String, int> winChance;

  MatchDetails({
    required this.matchId,
    required this.ranks,
    required this.averageRank,
    required this.handicap,
    required this.winChance,
  });
}

enum Type { oneVsOne, twoVsTwo, threeVsThree, fourVsFour, other }

class MatchComponent extends StatelessWidget {
  final Match match;

  const MatchComponent({super.key, required this.match});

  static RankedPlayer player1 =
      RankedPlayer(id: '-O-fNjrSviE5POI63WRk', name: 'Player 1', rank: 900);
  static RankedPlayer player2 =
      RankedPlayer(id: '-O-fNkeu_dEbsMe-8rij', name: 'Player 22312235', rank: 1050);
  static RankedPlayer player3 =
      RankedPlayer(id: '-O-fNlLgMXwPADo79dQ_', name: 'Player 3', rank: 950);
  static RankedPlayer player4 =
      RankedPlayer(id: '-O-fNm322faSLmSLRyF4', name: 'Player 43152342235235234', rank: 1200);
  static RankedPlayer player5 =
      RankedPlayer(id: '-O-fNmiIkkmWzg4kq99J', name: 'Player 5', rank: 900);

  static List<RankedPlayer> team1 = [player1, player2];
  static List<RankedPlayer> team2 = [player3, player4, player5];

  static Match dummyMatch = Match(
    id: '',
    season: '',
    competitionId: '',
    createdAt: DateTime.now(),
    createdBy: PlayerName(id: player1.id, name: player1.name),
    type: Type.other,
    playersTeam1: team1,
    playersTeam2: team2,
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
              _points(dummyMatch.pointsTeam1),
              const Spacer(),
              _teamScore(dummyMatch.scoreTeam1, EdgeInsets.only(left: $styles.insets.m)),
              _scoreDivider(),
              _teamScore(dummyMatch.scoreTeam2, EdgeInsets.only(right: $styles.insets.m)),
              const Spacer(),
              _points(dummyMatch.pointsTeam2),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _team1(dummyMatch.playersTeam1),
              SizedBox(width: $styles.insets.l),
              _team2(dummyMatch.playersTeam2),
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

  Widget _team1(List<RankedPlayer> players) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (RankedPlayer player in players) _player(player),
        ],
      ),
    );
  }

  Widget _team2(List<RankedPlayer> players) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (RankedPlayer player in players) _player(player),
        ],
      ),
    );
  }

  Widget _player(RankedPlayer player) {
    return Text(
      player.name.replaceAll(
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
