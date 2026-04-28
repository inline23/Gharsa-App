import 'package:bloc/bloc.dart';
import 'package:gharsa_app/features/soil%20anaylsis/data/models/soil_analysis_model.dart';
import 'package:gharsa_app/features/soil%20anaylsis/data/repos/soil_analysis_repo.dart';

part 'soil_analysis_state.dart';

class SoilAnalysisCubit extends Cubit<SoilAnalysisState> {
  final SoilAnalysisRepo repo;
  SoilAnalysisCubit({required this.repo}) : super(SoilAnalysisInitial());

  Future<void> predictSoilQuality({
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
    emit(SoilAnalysisLoading());
    try {
      final result = await repo.predictSoilQuality(
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
      if (result != null) {
        emit(SoilAnalysisSuccess(result));
      } else {
        emit(SoilAnalysisError('Failed to predict soil quality'));
        throw Exception('Failed to predict soil quality');
      }
    } catch (e) {
      emit(SoilAnalysisError(e.toString()));
      throw Exception(e.toString());
    }
  }

}
