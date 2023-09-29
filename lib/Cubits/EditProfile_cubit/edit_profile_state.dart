part of 'edit_profile_cubit.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}

final class EditProfileImageSuccess extends EditProfileState {}

final class EditProfileSuccess extends EditProfileState {}

final class EditProfileFailure extends EditProfileState {
  final String errMessage;
  EditProfileFailure(this.errMessage);
}

final class EditProfileLoading extends EditProfileState {}
