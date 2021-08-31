import 'package:crud/blocs/user/user_bloc.dart';
import 'package:crud/widgets/user_create.dart';
import 'package:crud/widgets/user_list.dart';
import 'package:crud/widgets/user_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(StateApp());
}

class StateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider<UserBloc>(create: (_) => UserBloc())],
        child: MyApp());
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xFFE0F2F1),
          accentColor: Color(0xFFE0F2F1),
          primarySwatch: Colors.teal,
          fontFamily: 'Urbanist',
          backgroundColor: Color.fromRGBO(150, 160, 150, 0.2)),
      routes: {
        '/user_list': (BuildContext context) => UserList(),
        '/user_create': (BuildContext context) => UserCreate(),
        '/user_update': (BuildContext context) => UserUpdate()
      },
      initialRoute: '/user_list',
      home: UserList(),
      // MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
