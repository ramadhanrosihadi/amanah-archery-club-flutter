import 'package:flutter/material.dart';
import 'package:starter_d/helper/constant/var.dart';
import 'package:starter_d/helper/constant/vcolor.dart';

import 'fun.dart';

class VDialog {
  static Future<dynamic> createDialog(
    BuildContext context, {
    String? title,
    String? message,
    bool withBackButton = true,
    String positiveText = 'OK',
    String? negativeText,
    bool barrierDismissible = true,
    Widget topWidget = const SizedBox(),
    TextStyle? titleStyle,
  }) {
    if (titleStyle == null) {
      titleStyle = const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18,
      );
    }
    return showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
          contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          title: Text(
            Fun.replaceEmpty(title, Var.appName),
            textAlign: TextAlign.center,
            style: titleStyle,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              topWidget,
              Text(
                Fun.replaceEmpty(message),
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
            ],
          ),
          actions: [
            if (withBackButton)
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                elevation: 5.0,
                child: const Text(
                  'Kembali',
                  style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black),
                ),
              ),
            if (negativeText != null)
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                elevation: 5.0,
                child: Text(
                  negativeText,
                  style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.red),
                ),
              ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              elevation: 5.0,
              child: Text(
                positiveText,
                style: TextStyle(fontWeight: FontWeight.w700, color: VColor.colorPrimary),
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<String?> createDialogInputText(
    BuildContext context,
    String title, {
    String submitTitle = 'OK',
    Color? submitTitleColor,
    String hintText = 'Tulis catatanmu disini...',
    String description = '',
    bool withField = true,
    bool noBackButton = false,
    String textBackButton = 'Kembali',
    bool barrierDismissible = false,
  }) {
    TextEditingController customController = TextEditingController();
    if (submitTitleColor == null) {
      submitTitleColor = VColor.colorPrimary;
    }
    return showDialog<String>(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
            contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: VColor.textColor,
              ),
            ),
            content: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (description != '')
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              description,
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 13,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const SizedBox(height: 7),
                        ],
                      ),
                    if (withField)
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: TextField(
                          controller: customController,
                          decoration: InputDecoration(
                            hintText: hintText,
                            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 0.5,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: VColor.colorPrimary,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              if (!noBackButton)
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop(null);
                  },
                  elevation: 5.0,
                  child: Text(
                    textBackButton,
                    style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black),
                  ),
                ),
              MaterialButton(
                onPressed: () {
                  String catatan = customController.text.toString().isEmpty ? '-' : customController.text.toString();
                  Navigator.of(context).pop(catatan);
                },
                elevation: 5.0,
                child: Text(
                  submitTitle,
                  style: TextStyle(fontWeight: FontWeight.w700, color: submitTitleColor),
                ),
              )
            ],
          );
        });
  }

  static Future<String?> showListPopUp(BuildContext context, TapDownDetails tapDownDetails, List<String> options, String? initialValue) async {
    var _tapPosition = tapDownDetails.globalPosition;
    final RenderObject? overlay = Overlay.of(context)!.context.findRenderObject();
    return await showMenu<String>(
      initialValue: initialValue,
      context: context,
      position: RelativeRect.fromRect(_tapPosition & const Size(0, 0), overlay!.paintBounds),
      items: options.map((e) => PopupMenuItem(child: Text(e), value: e)).toList(),
      elevation: 8.0,
    );
  }

  static Future popupError(BuildContext context, String error, {String title = Var.appName}) async {
    return await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            contentPadding: const EdgeInsets.all(20),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
            content: Text(
              error,
              style: const TextStyle(fontWeight: FontWeight.w300),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text('Ok'),
              )
            ],
          );
        });
  }

  static Future popupSuccess(BuildContext context, String message) async {
    return await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: SelectableText(
              Var.appName,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            contentPadding: const EdgeInsets.all(20),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
            content: SelectableText(
              message,
              style: const TextStyle(fontWeight: FontWeight.w300),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text(
                  'Ok',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                ),
              )
            ],
          );
        });
  }
}
