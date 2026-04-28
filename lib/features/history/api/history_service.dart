import 'dart:convert';
import 'package:gharsa_app/features/auth/api/api_service.dart';
import 'package:gharsa_app/features/history/data/models/history_model.dart';
import 'package:http/http.dart' as http;

class HistoryService {
  final ApiService apiService;

  HistoryService(this.apiService);

  Future<HistoryModel> getHistory() async {
    try {
      final url = Uri.parse("${ApiService.baseUrl}/api/soil/history?per_page=10");

      final response = await http.get(
        url,
        headers: await apiService.getHeaders(), 
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return HistoryModel.fromJson(data);
      } else {
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to fetch history: $e");
    }
  }
}