import 'package:crud/blocs/user/user_bloc.dart';
import 'package:crud/widgets/user_update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de Usuarios'),
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Header(),
                SizedBox(height: 50),
                List()
              ],
            ),
          ),
        ));
  }
}

class List extends StatelessWidget {
  const List({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(UserListEvent());
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Expanded(
            child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: state.userList?.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: const EdgeInsets.all(8),
              color: Colors.amber[600],
              child: Row(
                children: [
                  Text('${state.userList?[index].name} '),
                  Text('${state.userList?[index].lastName}'),
                  Expanded(child: Container()),
                  IconButton(
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserUpdate(
                                    idUser: '${state.userList?[index].id}')));
                        BlocProvider.of<UserBloc>(context).add(UserListEvent());
                      },
                      icon: Icon(Icons.update)),
                  IconButton(
                      onPressed: () {
                        BlocProvider.of<UserBloc>(context).add(
                            DeleteUserEvent('${state.userList?[index].id}'));
                        BlocProvider.of<UserBloc>(context).add(UserListEvent());
                      },
                      icon: Icon(Icons.remove))
                ],
              ),
            );
          },
        ));
      },
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        iconSize: 40,
        onPressed: () async {
          await Navigator.pushNamed(context, '/user_create');
          BlocProvider.of<UserBloc>(context).add(UserListEvent());
        },
        icon: Icon(Icons.add));
  }
}
