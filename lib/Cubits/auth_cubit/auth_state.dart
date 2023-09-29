part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

///////////////////////////

final class PhoneNumInitial extends AuthState {}

final class PhoneNumLoading extends AuthState {}

final class PhoneNumSuccess extends AuthState {}

final class PhoneNumFailure extends AuthState {
  final String errMessage;
  PhoneNumFailure(this.errMessage);
}

/////////////////////////////////////////////////////

final class VerifyOTPInitial extends AuthState {}

final class VerifyOTPLoading extends AuthState {}

final class VerifyOTPSuccess extends AuthState {}

final class VerifyOTPFailure extends AuthState {
  final String errMessage;
  VerifyOTPFailure(this.errMessage);
}

/////////////////////////////////////////////////////////////
final class RegisterInitial extends AuthState {}

final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {}

final class UploadImageSuccess extends AuthState {}

final class RegisterFailure extends AuthState {
  final String errMessage;
  RegisterFailure(this.errMessage);
}
