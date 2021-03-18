import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz_ejemplo/src/inicio_page/inicio_page.dart';

import 'bloc/form/mi_form_bloc.dart';
import 'package:formz/formz.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: InicioPage(title: 'formz flutter_blocss'),
    );
  }
}
