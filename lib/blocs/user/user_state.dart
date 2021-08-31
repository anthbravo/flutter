part of 'user_bloc.dart';

class UserState {
  List<UserModel>? userList = [];
  UserModel? user;

  UserState([this.userList, this.user]);
}
