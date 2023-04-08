import 'package:flutter/material.dart';
import 'package:keepscore2_flutter/match.component.dart';

class MatchesPage extends StatelessWidget {
  const MatchesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matches'),
      ),
      body: _matches(),
    );
  }

  Widget _matches() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.separated(
        itemCount: 5,
        itemBuilder: (context, index) {
          return const MatchComponent();
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8);
        },
      ),
    );
  }
}
