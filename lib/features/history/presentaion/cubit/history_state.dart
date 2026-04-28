import 'package:gharsa_app/features/history/data/models/history_model.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistorySuccess extends HistoryState {
  final List<HistoryItem> history;

  HistorySuccess(this.history);
}

class HistoryError extends HistoryState {
  final String message;

  HistoryError(this.message);
}