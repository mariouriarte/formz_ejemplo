part of 'mi_form_bloc.dart';

class MiFormState extends Equatable {
  const MiFormState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
  });

  final Email email;
  final Password password;
  final FormzStatus status;

  MiFormState copyWith({
    Email email,
    Password password,
    FormzStatus status,
  }) {
    return MiFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, password, status];
}

// class MiFormInitial extends MiFormState {
//   @override
//   List<Object> get props => [];
// }
