import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharsa_app/features/history/api/history_service.dart';
import 'package:gharsa_app/features/history/data/models/history_model.dart';

import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryService historyService;

  HistoryCubit(this.historyService) : super(HistoryInitial());

  List<HistoryItem> _history = [];

  List<HistoryItem> get history => _history;

  /// ================= INIT LOAD =================
  Future<void> loadHistory() async {
    emit(HistoryLoading());

    try {
      final result = await historyService.getHistory();

      final data = result.data;

      if (data == null || data.isEmpty) {
        _history = [];
        emit(HistorySuccess([]));
        return;
      }

      _history = data;

      emit(HistorySuccess(_history));
    } catch (e) {
      emit(HistoryError(_handleError(e)));
    }
  }

  /// ================= REFRESH =================
  Future<void> refreshHistory() async {
    try {
      final result = await historyService.getHistory();

      final data = result.data;

      _history = data ?? [];

      emit(HistorySuccess(_history));
    } catch (e) {
      emit(HistoryError(_handleError(e)));
    }
  }

  /// ================= ERROR HANDLER =================
  String _handleError(dynamic e) {
    final msg = e.toString();

    if (msg.contains("SocketException")) {
      return "No internet connection";
    }

    if (msg.contains("401")) {
      return "Unauthorized - please login again";
    }

    return "Something went wrong";
  }
}