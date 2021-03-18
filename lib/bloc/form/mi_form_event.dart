part of 'mi_form_bloc.dart';

abstract class MiFormEvent extends Equatable {
  const MiFormEvent();

  @override
  List<Object> get props => [];
}

class EmailChangedEvent extends MiFormEvent {
  EmailChangedEvent({@required this.email});

  final String email;

  List<Object> get props => [email];
}

class EmailUnfocusedEvent extends MiFormEvent {}

class PasswordChangedEvent extends MiFormEvent {
  PasswordChangedEvent({@required this.password});

  final String password;

  List<Object> get props => [password];
}

class PasswordUnfocusedEvent extends MiFormEvent {}

class FormSubmittedEvent extends MiFormEvent {}
