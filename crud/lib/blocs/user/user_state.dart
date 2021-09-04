part of 'user_bloc.dart';

class UserState {
  final List<UserModel> userList;
  final UserModel user;

  const UserState({this.userList = const [], this.user = const UserModel('', '')});
}
