part of '../sign_up.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<SignUpSubmitted>(_onLoginSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignUpState> emit) {
    final isValidEmail = _validateEmail(event.email);
    emit(
      state.copyWith(
        isSubmitted: false,
        email: event.email,
        isEmailValid: isValidEmail,
        emailError: '',
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignUpState> emit) {
    final rules = _validatePassword(event.password);
    final isPasswordValid = rules.values.every((isValid) => isValid);

    emit(
      state.copyWith(
        isSubmitted: false,
        password: event.password,
        passwordRules: rules,
        isPasswordValid: isPasswordValid,
      ),
    );
  }

  void _onLoginSubmitted(SignUpSubmitted event, Emitter<SignUpState> emit) {
    final isValidEmail = _validateEmail(state.email);
    final isPasswordValid =
        state.passwordRules.values.every((isValid) => isValid);

    emit(
      state.copyWith(
        isSubmitted: true,
        isEmailValid: isValidEmail,
        emailError: isValidEmail ? '' : 'Invalid email',
        isPasswordValid: isPasswordValid,
      ),
    );
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }

  Map<PasswordRule, bool> _validatePassword(String password) {
    return {
      PasswordRule.minLength: password.length >= 8 && !password.contains(' '),
      PasswordRule.upperLowerCase: password.contains(RegExp(r'[A-Z]')) &&
          password.contains(RegExp(r'[a-z]')),
      PasswordRule.containsDigit: password.contains(RegExp(r'\d')),
    };
  }
}
