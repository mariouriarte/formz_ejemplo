import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:formz_ejemplo/validator/validators.dart';

part 'mi_form_event.dart';
part 'mi_form_state.dart';

class MiFormBloc extends Bloc<MiFormEvent, MiFormState> {
  MiFormBloc() : super(MiFormState());

  @override
  void onTransition(Transition<MiFormEvent, MiFormState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<MiFormState> mapEventToState(MiFormEvent event) async* {
    if (event is EmailChangedEvent) {
      final email = Email.dirty(event.email);
      yield state.copyWith(
        // email: email.valid ? email : Email.pure(event.email),
        email: email,
        status: Formz.validate([email, state.password]),
      );
    } else if (event is PasswordChangedEvent) {
      final password = Password.dirty(event.password);
      yield state.copyWith(
        // password: password.valid ? password : Password.pure(event.password),
        password: password,
        status: Formz.validate([state.email, password]),
      );
    } else if (event is FormSubmittedEvent) {
      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);
        await Future<void>.delayed(const Duration(seconds: 3));
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      }
    }
  }
}
