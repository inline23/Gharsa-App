import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharsa_app/features/profile/data/service/profile_service.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileService profileService;

  ProfileCubit(this.profileService) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());

    try {
      final response = await profileService.getMe();

      final user = response.data;

      if (user == null) {
        emit(ProfileError("User data is empty"));
        return;
      }

      emit(ProfileSuccess(user));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateProfile({
    String? name,
    String? phoneNumber,
    int? cityId,
    String? imagePath,
  }) async {
    emit(ProfileUpdating());

    try {
      final response = await profileService.updateProfile(
        name: name,
        phoneNumber: phoneNumber,
        cityId: cityId,
        imagePath: imagePath,
      );

      emit(ProfileUpdated(response.data!));
      emit(ProfileSuccess(response.data!));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
