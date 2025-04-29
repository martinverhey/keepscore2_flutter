import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keepscore2_flutter/competition/competition.repository.dart';
import 'package:keepscore2_flutter/main.dart';
import 'package:keepscore2_flutter/matches/match.component.dart';

List<RankedPlayer> players = [...MatchComponent.team1, ...MatchComponent.team2];

class SelectPlayersPage extends StatefulWidget {
  final ValueChanged<List<String>> onChanged;
  final List<String> selectedPlayerIds;

  const SelectPlayersPage({
    super.key,
    required this.onChanged,
    required this.selectedPlayerIds,
  });

  @override
  State<SelectPlayersPage> createState() => _SelectPlayersPageState();
}

class _SelectPlayersPageState extends State<SelectPlayersPage> {
  late Stream<DatabaseEvent> stream =
      $db.ref('/competitions/${CompetitionRepository.currentCompetition}/players').onValue;

  @override
  void initState() {
    super.initState();
    print('Players pre-selected: ${widget.selectedPlayerIds}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        _sliverAppBar(context),
        _content(),
      ]),
    );
  }

  Widget _sliverAppBar(BuildContext context) {
    return CupertinoSliverNavigationBar(
      automaticallyImplyLeading: false,
      largeTitle: Text(
        'Select Players',
        style: TextStyle(color: $styles.colors.orange),
      ),
      trailing: TextButton(
        onPressed: () {
          widget.onChanged(widget.selectedPlayerIds);
          Navigator.of(context).pop(widget.selectedPlayerIds);
        },
        child: const Text('Done'),
      ),
    );
  }

  Widget _content() {
    return StreamBuilder(
      stream: stream,
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

        List<PlayerName> players = [];
        for (var i = 0; i < items.values.length; i++) {
          players.add(
            PlayerName(
              id: items.keys.toList()[i],
              name: items.values.toList()[i],
            ),
          );
        }

        players.sort(
          (a, b) => a.name.compareTo(b.name),
        );

        return SliverList(
          delegate: SliverChildListDelegate(
            players.map((e) => _playerItem(e)).toList(),
          ),
        );
      },
    );
  }

  Widget _playerItem(PlayerName player) {
    return InkWell(
      onTap: () => _togglePlayer(player, !widget.selectedPlayerIds.contains(player.id)),
      child: Row(
        children: [
          Checkbox(
            value: widget.selectedPlayerIds.contains(player.id),
            onChanged: (_) {},
          ),
          Expanded(
            child: Text(
              player.name,
              style: $styles.text.body,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Text(
          //   '${player.rank}',
          //   style: $styles.text.body.copyWith(fontWeight: FontWeight.w500),
          // ),
        ],
      ),
    );
  }

  void _togglePlayer(PlayerName player, bool? value) {
    if (value != null) {
      setState(() {
        value
            ? widget.selectedPlayerIds.add(player.id)
            : widget.selectedPlayerIds.remove(player.id);
      });
    }
    print(widget.selectedPlayerIds);
  }
}
