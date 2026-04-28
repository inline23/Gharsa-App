import 'package:gharsa_app/features/profile/data/models/user_profile_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserData user;

  ProfileSuccess(this.user);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}