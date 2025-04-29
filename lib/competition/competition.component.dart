import 'package:flutter/material.dart';
import 'package:keepscore2_flutter/main.dart';

class CompetitionComponent extends StatelessWidget {
  final String competitionName;
  final String playerName;
  final int rank;

  const CompetitionComponent({
    super.key,
    required this.competitionName,
    required this.playerName,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Competition X',
        style: $styles.text.body,
      ),
      subtitle: Text(
        'Martini',
        style: $styles.text.subtitle,
      ),
      trailing: Text(
        '1500',
        style: $styles.text.body,
      ),
    );
  }
}
