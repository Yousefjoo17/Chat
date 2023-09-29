part of 'user_tile_cubit.dart';

@immutable
sealed class UserTileState {}

final class UserTileInitial extends UserTileState {}
final class UserTileLoading extends UserTileState {}
final class UserTileSuccess extends UserTileState {}
