import 'package:flutter/material.dart';

import 'package:formz_ejemplo/src/formulario_page/formulario_page.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text('Ejemplo para lanzar un form y validarlo'),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FormularioPage()),
                  );
                },
                child: Text('Ingresar al Form'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
