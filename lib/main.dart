import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      home: MyHomePage(title: 'formz flutter_bloc'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocProvider(
        create: (context) => MiFormBloc(),
        child: ConstruirForm(),
      ),
    );
  }
}

class ConstruirForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<MiFormBloc, MiFormState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Scaffold.of(context).hideCurrentSnackBar();
          showDialog<void>(
            context: context,
            builder: (_) => SuccessDialog(),
          );
        }
        if (state.status.isSubmissionInProgress) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Submitting...')),
            );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            EmailInput(),
            PasswordInput(),
            SubmitButton(),
          ],
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  // const EmailInput({Key key, this.focusNode}) : super(key: key);
  // final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MiFormBloc, MiFormState>(
      buildWhen: (previous, current) {
        //todo
        //print()
        return previous.email != current.email;
      },
      builder: (context, state) {
        return TextFormField(
          initialValue: state.email.value,
          // focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.email),
            labelText: 'Email',
            helperText: 'A complete, valid email e.g. joe@gmail.com',
            errorText: state.email.invalid
                ? 'Please ensure the email entered is valid'
                : null,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            context.read<MiFormBloc>().add(EmailChangedEvent(email: value));
          },
          // textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  // const PasswordInput({Key key, this.focusNode}) : super(key: key);
  // final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MiFormBloc, MiFormState>(
      buildWhen: (previous, current) {
        //todo
        //print()
        return previous.password != current.password;
      },
      builder: (context, state) {
        return TextFormField(
          initialValue: state.password.value,
          decoration: InputDecoration(
            icon: const Icon(Icons.lock),
            helperText:
                '''Password should be at least 8 characters with at least one letter and number''',
            helperMaxLines: 2,
            labelText: 'Password',
            errorMaxLines: 2,
            errorText: state.password.invalid
                ? '''Password must be at least 8 characters and contain at least one letter and number'''
                : null,
          ),
          obscureText: true,
          onChanged: (value) {
            context
                .read<MiFormBloc>()
                .add(PasswordChangedEvent(password: value));
          },
          // textInputAction: TextInputAction.done,
        );
      },
    );
  }
}

class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MiFormBloc, MiFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return RaisedButton(
          onPressed: state.status.isValidated
              ? () => context.read<MiFormBloc>().add(FormSubmittedEvent())
              : null,
          child: const Text('Submit'),
        );
      },
    );
  }
}

class SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const Icon(Icons.info),
                const Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Form Submitted Successfully!',
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            RaisedButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
