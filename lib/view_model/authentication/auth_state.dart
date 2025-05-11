part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class PickImageSuccessfully extends AuthState {}
final class PickImageError extends AuthState {}

final class CropImageSuccessfully extends AuthState {}
final class CropImageError extends AuthState {}

final class RegisterLoading extends AuthState {}
final class RegisterSuccessfully extends AuthState {}
final class RegisterError extends AuthState {}

final class UploadImageLoading extends AuthState {}
final class UploadImageSuccessfully extends AuthState {}
final class UploadImageError extends AuthState {}