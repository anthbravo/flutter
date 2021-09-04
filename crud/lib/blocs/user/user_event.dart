part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserListEvent extends UserEvent {}

class AddUserEvent extends UserEvent {
  final UserModel user;
  AddUserEvent(this.user);
}

class FindUserEvent extends UserEvent {
  final String id;
  FindUserEvent(this.id);
}

class UpdateUserEvent extends UserEvent {
  final UserModel user;
  UpdateUserEvent(this.user);
}

class DeleteUserEvent extends UserEvent {
  final String id;
  DeleteUserEvent(this.id);
}
