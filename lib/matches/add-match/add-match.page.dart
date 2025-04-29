import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keepscore2_flutter/shared/helpers.dart';
import 'package:keepscore2_flutter/main.dart';
import 'package:keepscore2_flutter/matches/add-match/select-players.page.dart';
import 'package:keepscore2_flutter/matches/match.component.dart';

List<RankedPlayer> players = [...MatchComponent.team1, ...MatchComponent.team2];

class AddMatchPage extends StatefulWidget {
  const AddMatchPage({super.key});

  @override
  State<AddMatchPage> createState() => _AddMatchPageState();
}

class _AddMatchPageState extends State<AddMatchPage> {
  final List<String> playersIdsTeam1 = [
    MatchComponent.player1.id,
    MatchComponent.player2.id,
  ];
  final List<String> playersIdsTeam2 = [
    MatchComponent.player3.id,
    MatchComponent.player4.id,
    MatchComponent.player5.id
  ];
  int scoreTeam1 = 0;
  int scoreTeam2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        _sliverAppBar(),
        _content(context),
      ]),
    );
  }

  Widget _sliverAppBar() {
    return CupertinoSliverNavigationBar(
      largeTitle: Text(
        'New Match',
        style: TextStyle(color: $styles.colors.orange),
      ),
      trailing: TextButton(
        onPressed: () {},
        child: const Text('Save'),
      ),
    );
  }

  Widget _content(BuildContext context) {
    List<RankedPlayer> playersTeam1 =
        players.where((RankedPlayer player) => playersIdsTeam1.contains(player.id)).toList();
    List<RankedPlayer> playersTeam2 =
        players.where((RankedPlayer player) => playersIdsTeam2.contains(player.id)).toList();

    return SliverToBoxAdapter(
      child: Column(
        children: [
          _team(
            context,
            name: 'Team 1',
            players: playersTeam1,
            selectedPlayers: playersIdsTeam1,
          ),
          _scoreInput(),
          _team(
            context,
            name: 'Team 2',
            players: playersTeam2,
            selectedPlayers: playersIdsTeam2,
          ),
        ],
      ),
    );
  }

  Widget _scoreInput() {
    TextStyle scoreStyle = $styles.text.h1.copyWith(
      color: $styles.colors.black,
      fontWeight: FontWeight.bold,
    );

    return InkWell(
      onTap: () {
        print('Enter Score');
      },
      child: Container(
        width: double.infinity,
        height: 90,
        decoration: BoxDecoration(
          color: $styles.colors.grey100,
        ),
        child: Form(
          child: Row(
            children: [
              const Spacer(),
              _scoreTextField(scoreStyle),
              SizedBox(width: $styles.insets.m),
              Text('-', style: $styles.text.h1.copyWith(color: $styles.colors.grey)),
              SizedBox(width: $styles.insets.m),
              _scoreTextField(scoreStyle),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _scoreTextField(TextStyle scoreStyle) {
    return SizedBox(
      width: 80,
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: $styles.colors.grey500, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: $styles.colors.red, width: 2),
          ),
          disabledBorder: InputBorder.none,
          hintText: '0',
          hintStyle: scoreStyle,
        ),
        style: scoreStyle,
        textAlign: TextAlign.center,
        validator: (value) {
          if (value?.isEmpty == true) {
            return 'Please enter a score';
          }
          return null;
        },
        keyboardType: TextInputType.number,
        onSaved: (newValue) => scoreTeam1 = int.parse(newValue ?? '0'),
      ),
    );
  }

  Widget _team(
    BuildContext context, {
    required String name,
    required List<RankedPlayer> players,
    required List<String> selectedPlayers,
  }) {
    int playersAverageRank = players.isEmpty
        ? 0
        : players.map((player) => player.rank).reduce((sum, value) => sum + value) ~/
            players.length;
    return Padding(
      padding: EdgeInsets.all($styles.insets.xl),
      child: InkWell(
        onTap: () {
          navigateToPage(
            context: context,
            page: SelectPlayersPage(
                selectedPlayerIds: selectedPlayers,
                onChanged: (players) {
                  print('Done. Players selected: $players');
                  setState(() {});
                }),
            fullScreen: true,
          );
        },
        child: Stack(
          children: [
            Container(
              width: 360,
              height: 200,
              decoration: BoxDecoration(
                color: $styles.colors.grey100,
                borderRadius: BorderRadius.circular($styles.corners.m),
              ),
            ),
            Padding(
              padding: EdgeInsets.all($styles.insets.l),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(
                      name,
                      style: $styles.text.h2.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      'avg',
                      style: $styles.text.body.copyWith(
                        fontWeight: FontWeight.w500,
                        color: $styles.colors.grey500,
                      ),
                    ),
                    SizedBox(width: $styles.insets.s),
                    Text(
                      '$playersAverageRank',
                      style: $styles.text.h2.copyWith(
                        fontWeight: FontWeight.bold,
                        color: $styles.colors.grey500,
                      ),
                    ),
                  ]),
                  for (RankedPlayer player in players) _playerRow(player.name, player.rank),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _playerRow(String name, int rank) {
    return Row(
      children: [
        Expanded(
          child: Text(
            name,
            style: $styles.text.h3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          rank.toString(),
          style: $styles.text.h3.copyWith(
            color: $styles.colors.grey500,
            fontWeight: FontWeight.w300,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
