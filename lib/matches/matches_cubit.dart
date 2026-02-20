import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../main.dart';
import 'match.component.dart';
import 'matches.page.dart';

part 'matches_state.dart';

class MatchesCubit extends Cubit<MatchesState> {
  MatchesCubit() : super(MatchesInitial()) {
    _init();
  }

  void _init() async {
    try {
      final data = await supabase.from('match').select('''
            id,
            created_at,
            competition_id,
            season_id,
            created_by(id, name), 
            points_team1,
            points_team2,
            score_team1,
            score_team2,
            players_team1(id, match_id),
            players_team2(id, match_id),
            match_type
          ''').eq('competition_id', 1);
      if (isClosed) return;

      List<Match> matches = data
          .map(
            (matchData) => Match.fromMap(matchData),
            // Match(
            //   id: (matchData['id'] ?? 0) as int,
            //   season: (matchData['season_id'] ?? 0) as int,
            //   competitionId: (matchData['competition_id'] ?? 0) as int,
            //   createdAt: DateTime.parse(matchData['created_at']),
            //   createdBy: PlayerName(
            //     id: (matchData['created_by'] ?? 0) as int,
            //     name: 'Henkie',
            //   ),
            //   pointsTeam1: (matchData['points_team1'] ?? 0).toDouble(),
            //   pointsTeam2: (matchData['points_team2'] ?? 0).toDouble(),
            //   scoreTeam1: (matchData['score_team1'] ?? 0) as int,
            //   scoreTeam2: (matchData['score_team2'] ?? 0) as int,
            //   playersTeam1: List<RankedPlayer>.from(
            //     (matchData['players_team1'] ?? []).map(
            //       (player) => RankedPlayer(
            //         id: player as int,
            //         name: 'Uhhhhhmmm', // TODO: How to resolve?
            //         rank: 5,
            //       ),
            //     ),
            //   ).toList(),
            //   playersTeam2: List<RankedPlayer>.from(
            //     (matchData['players_team2'] ?? [])
            //         .map(
            //           (player) => RankedPlayer(
            //             id: player as int,
            //             name: 'Yeahhhh', // TODO: Fix
            //             rank: 5,
            //           ),
            //         )
            //         .toList(),
            //   ),
            //   type: Type.values[(matchData['match_type'] ?? Type.other) as int],
            // ),
          )
          .toList();
      emit(MatchesLoaded(matches: matches));
    } catch (e) {
      emit(MatchesError(error: e));
    }
  }
}
