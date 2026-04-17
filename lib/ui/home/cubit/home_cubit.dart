import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../services/api_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiService apiService;

  HomeCubit({required this.apiService}) : super(HomeInitial());

  Future<void> fetchProducts() async {
    try {
      emit(HomeLoading());
      final products = await apiService.fetchProducts();
      emit(HomeLoaded(products));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
