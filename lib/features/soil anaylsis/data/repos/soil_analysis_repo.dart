import 'package:gharsa_app/features/auth/api/api_service.dart';
import 'package:gharsa_app/features/soil%20anaylsis/data/models/soil_analysis_model.dart';

class SoilAnalysisRepo {
  final ApiService apiService;

  SoilAnalysisRepo({required this.apiService});

  Future<SoilAnalysisModel?> predictSoilQuality({
    required double ec,
    required double sar,
    required double caco3,
    required double gypsum,
    required double om,
    required double n,
    required double p,
    required double k,
    required double fe,
    required double mn,
    required double zn,
    required double cu,
    required int eDepth,
    required double ph,
    required String texture,
  }) async {
    return await apiService.predict(
      ec: ec,
      sar: sar,
      caco3: caco3,
      gypsum: gypsum,
      om: om,
      n: n,
      p: p,
      k: k,
      fe: fe,
      mn: mn,
      zn: zn,
      cu: cu,
      eDepth: eDepth,
      ph: ph,
      texture: texture,
    );
  }

}
