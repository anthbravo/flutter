import 'package:crud/blocs/user/user_bloc.dart';
import 'package:crud/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCreate extends StatelessWidget {
  UserCreate({Key? key}) : super(key: key);

  TextEditingController textEditingName = TextEditingController();
  TextEditingController textEditingLastName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Usuario'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          Header(
            textEditingName: this.textEditingName,
            textEditingLastName: this.textEditingLastName,
          ),
          SizedBox(
            height: 50,
          ),
          Form(
            textEditingName: this.textEditingName,
            textEditingLastName: this.textEditingLastName,
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  TextEditingController textEditingName;
  TextEditingController textEditingLastName;

  Header(
      {Key? key,
      required this.textEditingName,
      required this.textEditingLastName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          BlocProvider.of<UserBloc>(context).add(AddUserEvent(
              UserModel(textEditingName.text, textEditingLastName.text)));
          Navigator.pop(context);
        },
        iconSize: 40,
        icon: Icon(Icons.save));
  }
}

class Form extends StatelessWidget {
  TextEditingController textEditingName;
  TextEditingController textEditingLastName;

  Form(
      {Key? key,
      required this.textEditingName,
      required this.textEditingLastName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          TextField(
              controller: textEditingName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nombres',
              )),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: textEditingLastName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Apellidos',
              ))
        ]));
  }
}
