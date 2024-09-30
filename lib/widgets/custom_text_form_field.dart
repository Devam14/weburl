import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/app_colors.dart';
import '../generated/assets.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final int lineCount;
  final int maxLength;
  final String prefixIcon;
  final String suffixIcon;
  final double fontSize;
  final bool isRequired;
  final bool isReadOnly;
  final bool isEnabled;
  final bool isPassword;
  final bool isPreFixIcon;
  final Widget? isSufixIcon;
  final TextInputAction inputAction;
  final TextInputType inputType;
  final TextCapitalization capitalization;
  final Color textColor;
  final Color hintTextColor;
  final Color? borderColor;
  final Function? onChanged;

  final EdgeInsets? contentPadding;

  const CustomTextFormField(
      {super.key,
      required this.labelText,
      this.textEditingController,
      this.focusNode,
      this.nextFocus,
      this.lineCount = 1,
      this.maxLength = 60,
      required this.fontSize,
      this.capitalization = TextCapitalization.none,
      this.isRequired = false,
      this.isReadOnly = false,
      this.isEnabled = true,
      this.isPassword = false,
      this.isPreFixIcon = false,
      this.isSufixIcon,
      this.onChanged,
      this.prefixIcon = Assets.imagesIcLogo,
      this.suffixIcon = Assets.imagesIcLogo,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      this.textColor = AppColors.textColor,
      this.hintTextColor = AppColors.hintColor,
      this.contentPadding,
      this.borderColor = AppColors.borderColor});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: widget.lineCount,
      maxLines: widget.lineCount,
      maxLength: widget.maxLength,
      controller: widget.textEditingController,
      focusNode: widget.focusNode,
      style: TextStyle(
        color: widget.textColor,
        fontWeight: FontWeight.w500,
        fontSize: widget.fontSize,
      ),
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      cursorColor: Theme.of(context).primaryColor,
      textCapitalization: widget.capitalization,
      readOnly: widget.isReadOnly,
      enabled: widget.isEnabled,
      autofocus: false,
      inputFormatters: widget.inputType == TextInputType.phone
          ? [
              // for below version 2 use this
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              // for version 2 and greater youcan also use this
              FilteringTextInputFormatter.digitsOnly
            ]
          : [],
      textAlign: TextAlign.left,
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        hintText: widget.labelText,
        hintStyle: TextStyle(
          color: widget.hintTextColor,
          fontWeight: FontWeight.w500,
          fontSize: widget.fontSize,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        // contentPadding: widget.isPreFixIcon == false
        //     ? const EdgeInsets.only(right: 5, bottom: 8, top: 8, left: 8)
        //     : EdgeInsets.zero,

        contentPadding: widget.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        filled: true,
        counterText: "",
        fillColor: widget.isEnabled ? AppColors.white : AppColors.white,
        prefixIcon: widget.isPreFixIcon
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                child: SvgPicture.asset(
                  widget.prefixIcon,
                ),
              )
            : null,
        suffixIcon: widget.isPassword
            ? Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    if (widget.textEditingController?.text.isNotEmpty == true) {
                      _toggle();
                    }
                  },
                  child: SvgPicture.asset(
                    _obscureText
                        ? Assets.imagesIcEyeHide
                        : Assets.imagesIcEyeShow,
                  ),
                ),
              )
            : widget.isSufixIcon,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide:
              BorderSide(color: widget.borderColor ?? AppColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide:
              BorderSide(color: widget.borderColor ?? AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide:
              BorderSide(color: widget.borderColor ?? AppColors.borderColor),
        ),
      ),
      onChanged: widget.onChanged as void Function(String)?,
      onFieldSubmitted: (v) {
        FocusScope.of(context).requestFocus(widget.nextFocus);
      },
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
