part of '../sign_up.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          gradient: CustomTheme.of(context).colors.backgroundGradient,
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 23,
                left: 70,
                child: SvgPicture.asset(
                  'assets/svg/background_stars.svg',
                  width: 250,
                  height: 720,
                ),
              ),
              Positioned(
                top: 94,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: BlocProvider(
                    create: (context) => SignUpBloc(),
                    child: BlocConsumer<SignUpBloc, SignUpState>(
                      listener: (context, state) {
                        if (state.isSubmitted &&
                            state.isEmailValid &&
                            state.isPasswordValid) {
                          showSuccessDialog(context);
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Sign up',
                              style: CustomTheme.of(context)
                                  .typography
                                  .headline
                                  .copyWith(
                                      color: CustomTheme.of(context)
                                          .colors
                                          .primary),
                            ),
                            const SizedBox(height: 40),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: CustomTextField(
                                hintText: 'Email',
                                controller: _emailTextController,
                                validateMessage: true,
                                focusNode: _emailFocusNode,
                                errorMessage: 'Invalid email',
                                status: _textFieldValidationStatus(
                                  isSubmitted: state.isSubmitted,
                                  isValidate: state.isEmailValid,
                                ),
                                onChanged: (email) => context
                                    .read<SignUpBloc>()
                                    .add(EmailChanged(email: email)),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: CustomTextField(
                                hintText: 'Create your password',
                                controller: _passwordTextController,
                                focusNode: _passwordFocusNode,
                                status: _textFieldValidationStatus(
                                  isSubmitted: state.isSubmitted,
                                  isValidate: state.isPasswordValid,
                                ),
                                obscure: true,
                                iconAsset: 'assets/svg/eye_closed.svg',
                                updatedIconAsset: 'assets/svg/eye_open.svg',
                                onChanged: (password) => context
                                    .read<SignUpBloc>()
                                    .add(PasswordChanged(password: password)),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                      state.passwordRules.entries.map((entry) {
                                    final rule = entry.key;
                                    final isValid = entry.value;
                                    final color = !state.isSubmitted
                                        ? (isValid
                                            ? CustomTheme.of(context)
                                                .colors
                                                .successBorder
                                            : CustomTheme.of(context)
                                                .colors
                                                .rulesInitial)
                                        : (isValid
                                            ? CustomTheme.of(context)
                                                .colors
                                                .successBorder
                                            : CustomTheme.of(context)
                                                .colors
                                                .warning);

                                    return Text(
                                      _passwordRuleDescription(rule),
                                      style: TextStyle(color: color),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                            GradientButton(
                              text: "Sign up",
                              width: 240,
                              height: 48,
                              onPressed: () {
                                context
                                    .read<SignUpBloc>()
                                    .add(SignUpSubmitted());
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFieldStatus _textFieldValidationStatus({
    required bool isSubmitted,
    required bool isValidate,
  }) {
    if (!isSubmitted) {
      return TextFieldStatus.initial;
    } else if (isValidate) {
      return TextFieldStatus.success;
    } else {
      return TextFieldStatus.failed;
    }
  }

  String _passwordRuleDescription(PasswordRule rule) {
    switch (rule) {
      case PasswordRule.minLength:
        return '8 characters or more (no spaces)';
      case PasswordRule.upperLowerCase:
        return 'Uppercase and lowercase letters';
      case PasswordRule.containsDigit:
        return 'At least one digit';
    }
  }
}
