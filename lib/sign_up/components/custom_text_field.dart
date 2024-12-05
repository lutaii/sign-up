part of '../sign_up.dart';

enum TextFieldStatus {
  initial,
  success,
  failed,
}

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.labelText,
    this.initialText,
    required this.controller,
    required this.focusNode,
    this.hintText,
    this.errorMessage,
    this.onTap,
    required this.status,
    this.validateMessage = false,
    this.onChanged,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.validator,
    this.inputFormatters,
    this.maxLength,
    this.showCounter = false,
    this.obscure,
    this.decoration,
    this.style,
    this.onFieldSubmitted,
    this.autoFocus = false,
    this.textInputAction,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.enabled = true,
    this.cursorColor,
    this.textAlignVertical,
    this.labelStyle,
    this.focusedBorderColor,
    this.enabledBorderColor,
  }) : assert(initialText == null);

  final String? errorMessage;
  final String? labelText;
  final String? initialText;
  final String? hintText;
  final TextFieldStatus status;
  final bool validateMessage;
  final TextEditingController controller;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final AutovalidateMode autovalidateMode;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool showCounter;
  final bool? obscure;
  final InputDecoration? decoration;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final bool autoFocus;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final bool? enabled;
  final Color? cursorColor;
  final TextAlignVertical? textAlignVertical;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;
  final FocusNode focusNode;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final ValueNotifier<bool> _isFocusedNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _showHintNotifier = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _obscureText = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();

    widget.focusNode.addListener(() {
      _isFocusedNotifier.value = widget.focusNode.hasFocus;
    });

    widget.controller.addListener(() {
      _showHintNotifier.value = widget.controller.text.isEmpty;
    });
  }

  @override
  void dispose() {
    widget.focusNode.dispose();
    widget.controller.dispose();
    _showHintNotifier.dispose();
    _isFocusedNotifier.dispose();
    _obscureText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            ValueListenableBuilder<bool>(
                valueListenable: _obscureText,
                builder: (context, obscure, child) {
                  return TextFormField(
                    // key: key,
                    focusNode: widget.focusNode,
                    autocorrect: false,
                    enableSuggestions: false,
                    autofocus: widget.autoFocus,
                    validator: widget.validator,
                    autovalidateMode: widget.autovalidateMode,
                    initialValue: widget.initialText,
                    controller: widget.controller,
                    keyboardType: TextInputType.text,
                    obscureText: widget.obscure != null ? obscure : false,
                    inputFormatters: widget.inputFormatters,
                    maxLength: widget.maxLength,
                    cursorColor: CustomTheme.of(context).colors.primary,
                    cursorWidth: 2.0,
                    cursorHeight: 20.0,
                    cursorOpacityAnimates: true,
                    style: CustomTheme.of(context)
                        .typography
                        .body1
                        .copyWith(color: _getTextColor(context)),
                    textAlignVertical: widget.textAlignVertical,
                    decoration: widget.decoration ??
                        InputDecoration(
                          fillColor: _getFillColor(context),
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14.0,
                            horizontal: 20.0,
                          ),
                          labelText: widget.labelText,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: _getBorderColor(
                                context,
                                whileFocused: true,
                              ),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: _getBorderColor(
                                context,
                                whileFocused: false,
                              ),
                            ),
                          ),
                          counterText: widget.showCounter ? null : '',
                          suffixIcon: widget.obscure != null
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      _obscureText.value = !_obscureText.value;
                                    },
                                    child: SvgPicture.asset(
                                      obscure
                                          ? 'assets/svg/eye_closed.svg'
                                          : 'assets/svg/eye_open.svg',
                                      colorFilter: ColorFilter.mode(
                                        _getSuffixIconColor(context),
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                )
                              : null,
                          suffixIconConstraints: const BoxConstraints(
                            maxWidth: 60,
                            maxHeight: 60,
                          ),
                        ),
                    onChanged: widget.onChanged,
                    textInputAction: widget.textInputAction,
                    onFieldSubmitted: widget.onFieldSubmitted,
                    enabled: widget.enabled,
                  );
                }),
            ValueListenableBuilder<bool>(
                valueListenable: _showHintNotifier,
                builder: (context, showHint, child) {
                  return ValueListenableBuilder<bool>(
                    valueListenable: _isFocusedNotifier,
                    builder: (context, isFocused, child) {
                      return showHint
                          ? AnimatedPositioned(
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.easeInOut,
                              left: isFocused ? 24 : 20,
                              child: IgnorePointer(
                                child: Text(
                                  widget.hintText ?? '',
                                  style: CustomTheme.of(context)
                                      .typography
                                      .body1
                                      .copyWith(
                                          color: isFocused
                                              ? CustomTheme.of(context)
                                                  .colors
                                                  .hintFocused
                                              : CustomTheme.of(context)
                                                  .colors
                                                  .hint),
                                ),
                              ),
                            )
                          : const SizedBox.shrink();
                    },
                  );
                }),
          ],
        ),
        widget.validateMessage
            ? Column(
                children: [
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      widget.status == TextFieldStatus.failed
                          ? widget.errorMessage ?? ''
                          : '',
                      style: CustomTheme.of(context).typography.body2.copyWith(
                          color: CustomTheme.of(context).colors.warning),
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Color _getBorderColor(BuildContext context, {required bool whileFocused}) {
    switch (widget.status) {
      case TextFieldStatus.initial:
        return whileFocused
            ? CustomTheme.of(context).colors.primary
            : CustomTheme.of(context).colors.primary.withOpacity(0.2);
      case TextFieldStatus.success:
        return CustomTheme.of(context).colors.successBorder;
      case TextFieldStatus.failed:
        return CustomTheme.of(context).colors.warning;
    }
  }

  Color _getFillColor(BuildContext context) {
    switch (widget.status) {
      case TextFieldStatus.initial:
        return Colors.white;
      case TextFieldStatus.success:
        return CustomTheme.of(context).colors.successAccent;
      case TextFieldStatus.failed:
        return CustomTheme.of(context).colors.warningAccent;
    }
  }

  Color _getSuffixIconColor(BuildContext context) {
    switch (widget.status) {
      case TextFieldStatus.initial:
        return CustomTheme.of(context).colors.suffixIconColor;
      case TextFieldStatus.success:
        return CustomTheme.of(context).colors.successBorder;
      case TextFieldStatus.failed:
        return CustomTheme.of(context).colors.warning;
    }
  }

  Color _getTextColor(BuildContext context) {
    switch (widget.status) {
      case TextFieldStatus.initial:
        return CustomTheme.of(context).colors.primary;
      case TextFieldStatus.success:
        return CustomTheme.of(context).colors.successBorder;
      case TextFieldStatus.failed:
        return CustomTheme.of(context).colors.warning;
    }
  }
}
