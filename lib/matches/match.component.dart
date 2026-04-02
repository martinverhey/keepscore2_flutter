// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

import '../main.dart';

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
  int id;
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
      id: map['id'] as int,
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

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'rank': rank,
    };
  }

  factory RankedPlayer.fromMap(Map<String, dynamic> map) {
    return RankedPlayer(
      id: map['id'] as int,
      name: map['name'] as String,
      rank: map['rank'] as int,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory RankedPlayer.fromJson(String source) =>
      RankedPlayer.fromMap(json.decode(source) as Map<String, dynamic>);
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
  int id;
  int seasonId;
  int competitionId;
  DateTime createdAt;
  PlayerName createdBy;
  // int createdBy;
  int pointsTeam1;
  int pointsTeam2;
  int scoreTeam1;
  int scoreTeam2;
  List<RankedPlayer> playersTeam1;
  List<RankedPlayer> playersTeam2;
  Type type;

  Match({
    required this.id,
    required this.seasonId,
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'seasonId': seasonId,
      'competitionId': competitionId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      // 'createdBy': createdBy.toMap(),
      'createdBy': createdBy,
      'pointsTeam1': pointsTeam1,
      'pointsTeam2': pointsTeam2,
      'scoreTeam1': scoreTeam1,
      'scoreTeam2': scoreTeam2,
      'playersTeam1': playersTeam1.map((x) => x.toMap()).toList(),
      'playersTeam2': playersTeam2.map((x) => x.toMap()).toList(),
      'type': type.name,
    };
  }

  factory Match.fromMap(Map<String, dynamic> map) {
    Match match = Match(
      id: map['id'] as int,
      seasonId: map['season_id'] as int,
      competitionId: map['competition_id'] as int,
      createdAt: DateTime.parse(map['created_at'] as String),
      createdBy: PlayerName.fromMap(map['created_by'] as Map<String, dynamic>),
      pointsTeam1: map['points_team1'] as int,
      pointsTeam2: map['points_team2'] as int,
      scoreTeam1: map['score_team1'] as int,
      scoreTeam2: map['score_team2'] as int,
      playersTeam1: List<RankedPlayer>.from(
        (map['players_team1'] as List<dynamic>).map<RankedPlayer>(
          (x) => RankedPlayer.fromMap(x as Map<String, dynamic>),
        ),
      ),
      playersTeam2: List<RankedPlayer>.from(
        (map['players_team2'] as List<dynamic>).map<RankedPlayer>(
          (x) => RankedPlayer.fromMap(x as Map<String, dynamic>),
        ),
      ),
      type: typeFromString(map['match_type'] as String?),
    );
    return match;
  }

  String toJson() => json.encode(toMap());

  factory Match.fromJson(String source) =>
      Match.fromMap(json.decode(source) as Map<String, dynamic>);
}

Type typeFromString(String? type) {
  if (type == null) return Type.other;

  switch (type) {
    case 'oneVsOne':
      return Type.oneVsOne;
    case 'twoVsTwo':
      return Type.twoVsTwo;
    case 'threeVsThree':
      return Type.threeVsThree;
    case 'fourVsFour':
      return Type.fourVsFour;
    default:
      return Type.other;
  }
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
      RankedPlayer(id: 0, name: 'Player 1', rank: 900);
  static RankedPlayer player2 = RankedPlayer(
    id: 1,
    name: 'Player 22312235',
    rank: 1050,
  );
  static RankedPlayer player3 =
      RankedPlayer(id: 2, name: 'Player 3', rank: 950);
  static RankedPlayer player4 = RankedPlayer(
    id: 3,
    name: 'Player 43152342235235234',
    rank: 1200,
  );
  static RankedPlayer player5 =
      RankedPlayer(id: 4, name: 'Player 5', rank: 900);

  static List<RankedPlayer> team1 = [player1, player2];
  static List<RankedPlayer> team2 = [player3, player4, player5];

  static Match dummyMatch = Match(
    id: -1,
    seasonId: -1,
    competitionId: -1,
    createdAt: DateTime.now(),
    // createdBy: player1.id,
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
      padding: EdgeInsets.symmetric(
        horizontal: $styles.insets.l,
        vertical: $styles.insets.m,
      ),
      decoration: BoxDecoration(
        color: $styles.colors.grey200,
        borderRadius: BorderRadius.all(Radius.circular($styles.corners.l)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _points(match.pointsTeam1),
              const Spacer(),
              _teamScore(score: match.scoreTeam1, paddingLeft: true),
              _scoreDivider(),
              _teamScore(score: match.scoreTeam2, paddingLeft: false),
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

  Widget _teamScore({required int score, required bool paddingLeft}) {
    return Padding(
      padding: EdgeInsets.only(
        left: paddingLeft ? $styles.insets.m : 0,
        right: paddingLeft ? 0 : $styles.insets.m,
      ),
      child: Text(
        '$score',
        style: $styles.text.h1
            .copyWith(color: $styles.colors.black, fontWeight: FontWeight.w600),
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
        ' ',
        '\u{000A0}',
      ), // Replaces all spaces in text with Unicode No-Break Space character.
      style: TextStyle(color: $styles.colors.black),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _points(int points) {
    final bool isPositive = points > 0;
    final String icon = isPositive ? '▲' : '▼';
    final Color color = isPositive ? Colors.green : Colors.red;
    final String pointsText = '${points.abs()}';

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
