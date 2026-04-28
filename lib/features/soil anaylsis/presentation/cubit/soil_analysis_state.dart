part of 'soil_analysis_cubit.dart';

abstract class SoilAnalysisState {}

class SoilAnalysisInitial extends SoilAnalysisState {}
class SoilAnalysisLoading extends SoilAnalysisState {}

class SoilAnalysisSuccess extends SoilAnalysisState {
  final SoilAnalysisModel result;
  SoilAnalysisSuccess(this.result);
}

class SoilAnalysisError extends SoilAnalysisState {
  final String message;
  SoilAnalysisError(this.message);
}