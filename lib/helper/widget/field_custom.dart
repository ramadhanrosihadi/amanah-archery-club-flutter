import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:starter_d/helper/constant/vcolor.dart';
import 'package:starter_d/helper/util/validator.dart';

class FieldCustom extends StatefulWidget {
  FieldCustom({
    Key? key,
    required this.controller,
    this.validator,
    required this.label,
    this.textInputType,
    this.enabled,
    this.suffixIcon,
    this.prefixWidget,
    this.maxLines = 1,
    this.minLines = 1,
    this.fillColor = Colors.white,
    this.height = 50,
    this.borderRadius = 10,
    this.showLabel = false,
    this.topMargin,
    this.isPassword = false,
    this.shadowColor,
    this.hintStyle,
  }) : super(key: key);
  final TextEditingController controller;
  String label;
  final String Function(String?)? validator;
  final TextInputType? textInputType;
  final bool? enabled;
  final Widget? suffixIcon;
  final Widget? prefixWidget;
  final int? maxLines;
  final int? minLines;
  Color? fillColor;
  final double? height;
  final double? borderRadius;
  final bool? showLabel;
  final double? topMargin;
  final bool? isPassword;
  final Color? shadowColor;
  final TextStyle? hintStyle;

  @override
  _FieldCustomState createState() => _FieldCustomState();
}

class _FieldCustomState extends State<FieldCustom> {
  String text = '';
  Function(String?)? validate;

  OutlineInputBorder border() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius!)),
    );
  }

  double getTopMargin() {
    if (widget.topMargin == null) {
      return widget.showLabel != null ? 10 : 15;
    }
    return widget.topMargin!;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.validator != null) {
      validate = widget.validator;
    } else {
      validate = Validator.isTextValid;
    }
    Color? shadowColorx = widget.shadowColor;

    if (shadowColorx == null) {
      shadowColorx = Colors.grey[800]!.withOpacity(0.3);
    }

    TextStyle? hintStylex = widget.hintStyle;
    if (hintStylex == null) {
      hintStylex = TextStyle(color: VColor.hintColor);
    }

    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: shadowColorx,
            spreadRadius: 1.2,
            blurRadius: 1.2,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius!)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (() {
            if (widget.prefixWidget != null) {
              return widget.prefixWidget!;
            }
            return const SizedBox();
          }()),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: getTopMargin()),
              child: TextFormField(
                controller: widget.controller,
                validator: (widget.validator != null)
                    ? widget.validator
                    : (value) {
                        return Validator.isTextValid(value, label: widget.label);
                      },
                keyboardType: widget.textInputType,
                enabled: widget.enabled,
                maxLines: widget.maxLines,
                minLines: widget.minLines,
                obscureText: widget.isPassword!,
                style: TextStyle(color: Colors.grey[700], fontSize: 13),
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  fillColor: widget.fillColor,
                  filled: true,
                  border: InputBorder.none,
                  labelText: widget.showLabel! ? widget.label : null,
                  hintText: widget.showLabel! ? null : widget.label,
                  hintStyle: hintStylex,
                  focusedBorder: border(),
                  enabledBorder: border(),
                  disabledBorder: border(),
                  // prefixText: '  ',
                ),
                onChanged: (value) {
                  setState(() {
                    text = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
