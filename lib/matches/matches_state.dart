part of 'matches_cubit.dart';

@immutable
sealed class MatchesState {}

final class MatchesInitial extends MatchesState {}

final class MatchesLoaded extends MatchesState {
  final List<Match> matches;
  final GameType selectedGameType;

  MatchesLoaded({
    required this.matches,
    this.selectedGameType = GameType.all,
  });
}

final class MatchesError extends MatchesState {
  final Object error;

  MatchesError({required this.error});
}
