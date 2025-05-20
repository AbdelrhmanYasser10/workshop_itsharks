part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GetProfileLoading extends HomeState {}
final class GetProfileSuccessfully extends HomeState {}
final class GetProfileError extends HomeState {}

final class GetCategoriesLoading extends HomeState {}
final class GetCategoriesSuccessfully extends HomeState {}
final class GetCategoriesError extends HomeState {}

final class GetProductsLoading extends HomeState {}
final class GetProductsSuccessfully extends HomeState {}
final class GetProductsError extends HomeState {}

final class GetProductsFromCategoryLoading extends HomeState {}
final class GetProductsFromCategorySuccessfully extends HomeState {}
final class GetProductsFromCategoryError extends HomeState {}

