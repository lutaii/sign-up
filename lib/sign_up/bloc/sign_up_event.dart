part of '../sign_up.dart';

abstract class SignUpEvent {}

class EmailChanged extends SignUpEvent {
  final String email;
  EmailChanged({required this.email});
}

class PasswordChanged extends SignUpEvent {
  final String password;
  PasswordChanged({required this.password});
}

class SignUpSubmitted extends SignUpEvent {}
