part of '../sign_up.dart';

enum TextFieldStatus {
  initial,
  success,
  failed,
}

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.hintText,
    this.errorMessage,
    required this.status,
    this.validateMessage = false,
    this.onChanged,
    this.obscure,
    this.decoration,
    this.iconAsset,
    this.updatedIconAsset,
    this.enabled = true,
  }) : assert((obscure != null &&
                iconAsset != null &&
                updatedIconAsset != null) ||
            obscure == null);

  final String? errorMessage;
  final String? hintText;
  final TextFieldStatus status;
  final bool validateMessage;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final bool? obscure;
  final InputDecoration? decoration;
  final bool? enabled;
  final FocusNode focusNode;
  final String? iconAsset;
  final String? updatedIconAsset;

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
                    key: widget.key,
                    focusNode: widget.focusNode,
                    autocorrect: false,
                    enableSuggestions: false,
                    controller: widget.controller,
                    keyboardType: TextInputType.text,
                    obscureText: widget.obscure != null ? obscure : false,
                    cursorColor: CustomTheme.of(context).colors.primary,
                    cursorWidth: 2.0,
                    cursorHeight: 20.0,
                    cursorOpacityAnimates: true,
                    style: CustomTheme.of(context)
                        .typography
                        .body1
                        .copyWith(color: _getTextColor(context)),
                    decoration: widget.decoration ??
                        InputDecoration(
                          fillColor: _getFillColor(context),
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14.0,
                            horizontal: 20.0,
                          ),
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
                          suffixIcon: widget.obscure != null
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      _obscureText.value = !_obscureText.value;
                                    },
                                    child: SvgPicture.asset(
                                      obscure
                                          ? widget.iconAsset ?? ''
                                          : widget.updatedIconAsset ?? '',
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
