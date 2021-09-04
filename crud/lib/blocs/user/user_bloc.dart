import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crud/models/user_model.dart';
import 'package:crud/repositories/user_repository.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState());

  UserRepository userRepository = UserRepository();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserListEvent) {
      print('UserListEvent');
      var userList = await userRepository.getUsers();

      yield UserState(userList: userList);
    } else if (event is AddUserEvent) {
      print('AddUserEvent');
      print(event.user.name);
      await userRepository.addUser(event.user);
      yield UserState();
    } else if (event is FindUserEvent) {
      print('FindUserEvent');
      yield UserState();
    } else if (event is UpdateUserEvent) {
      print('UpdateUserEvent');
      await userRepository.updateUser(event.user);
      yield UserState();
    } else if (event is DeleteUserEvent) {
      print('DeleteUserEvent');
      await userRepository.deleteUser(event.id);

      yield UserState();
    }
  }
}
