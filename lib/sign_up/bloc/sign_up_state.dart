part of '../sign_up.dart';

class SignUpState {
  final String email;
  final String emailError;
  final String password;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitted;
  final Map<PasswordRule, bool> passwordRules;

  SignUpState({
    this.email = '',
    this.emailError = '',
    this.password = '',
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.isSubmitted = false,
    Map<PasswordRule, bool>? passwordRules,
  }) : passwordRules = passwordRules ??
            {
              PasswordRule.minLength: false,
              PasswordRule.upperLowerCase: false,
              PasswordRule.containsDigit: false,
            };

  SignUpState copyWith({
    String? email,
    String? emailError,
    String? password,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isSubmitted,
    Map<PasswordRule, bool>? passwordRules,
  }) {
    return SignUpState(
      email: email ?? this.email,
      emailError: emailError ?? this.emailError,
      password: password ?? this.password,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      passwordRules: passwordRules ?? this.passwordRules,
    );
  }
}

enum PasswordRule {
  minLength,
  upperLowerCase,
  containsDigit,
}
