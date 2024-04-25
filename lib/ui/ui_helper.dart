import 'package:flutter/material.dart';
import 'package:orange_yatri/constant/constant_color.dart';
import 'package:pinput/pinput.dart';

class UiHelper {
  /// Custom TextField
  static customTextField(
      TextEditingController controller, String text, bool toHide) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: controller,
        obscureText: toHide,
        decoration: InputDecoration(
            hintText: text,
            hintStyle: const TextStyle(color: Constant.textColor),
            // labelText: text,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                    color: Constant.textColor,
                    width: 1,
                    style: BorderStyle.solid))),
      ),
    );
  }

  /// Custom textField with icon
  static customTextFieldWithIconAndCharaterSize(
      TextEditingController controller,
      String text,
      bool toHide,
      IconData iconData,
      int characterCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        obscureText: toHide,
        maxLines: 1,
        autocorrect: true,
        autofocus: true,
        style: const TextStyle(fontSize: 20),
        maxLength: characterCount,
        decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Constant.textBtnColor)),
            hintText: text,
            hintStyle: const TextStyle(color: Constant.textColor, fontSize: 20),
            suffixIcon: Icon(iconData),
            suffixIconColor: Colors.black,
            // labelText: text,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                    color: Constant.textColor,
                    width: 1,
                    style: BorderStyle.solid))),
      ),
    );
  }

  /// custum textField with icon
  static customTextFieldWithIcon(TextEditingController controller, String text,
      bool toHide, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        obscureText: toHide,
        maxLines: 1,
        autocorrect: true,
        autofocus: true,
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Constant.textBtnColor)),
            hintText: text,
            hintStyle: const TextStyle(color: Constant.textColor, fontSize: 20),
            suffixIcon: Icon(iconData),
            suffixIconColor: Colors.black,
            // labelText: text,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                    color: Constant.textColor,
                    width: 1,
                    style: BorderStyle.solid))),
      ),
    );
  }

  /// custom textField with label
  static customTextFieldWithLabel(TextEditingController controller, String text,
      bool toHide) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        obscureText: toHide,
        maxLines: 1,
        autocorrect: true,
        autofocus: true,
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Constant.textBtnColor)),
            hintText: text,
            hintStyle: const TextStyle(color: Constant.textColor, fontSize: 20),
            // suffixIcon: Icon(iconData),
            // suffixIconColor: Colors.black,
            labelText: text,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                    color: Constant.textColor,
                    width: 1,
                    style: BorderStyle.solid))),
      ),
    );
  }

  /// Custom TextField With IconButton
  static customTextFieldWithIconButton(
      VoidCallback voidCallback,
      TextEditingController controller,
      String text,
      bool toHide,
      IconData iconData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        obscureText: toHide,
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
            hintText: text,
            hintStyle: const TextStyle(color: Constant.textColor),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Constant.textBtnColor)),
            suffixIcon: IconButton(
              onPressed: () {
                voidCallback();
              },
              icon: Icon(iconData),
            ),
            suffixIconColor: Colors.black,
            // labelText: text,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                    color: Constant.textColor,
                    width: 1,
                    style: BorderStyle.solid))),
      ),
    );
  }

  /// Custom TextButton
  static customTextButton(VoidCallback voidCallback, String text) {
    return TextButton(
      onPressed: () {
        voidCallback();
      },
      child: Text(text,
          style: const TextStyle(fontSize: 16, color: Constant.textBtnColor)),
    );
  }

  /// Custom Button
  static customButton(VoidCallback voidCallback, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Container(
        height: Constant.height * .07,
        width: Constant.width * .99,
        decoration: const BoxDecoration(),
        child: ElevatedButton(
            onPressed: () {
              voidCallback();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Constant.textBtnColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: Text(text,
                style: TextStyle(color: Colors.white, fontSize: Constant.width * .06, fontWeight: FontWeight.w500))),
      ),
    );
  }

  /// custom Circular Progress Indecater
  static customButtonCPI() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Container(
        height: Constant.height * .07,
        width: Constant.width * .99,
        decoration: BoxDecoration(
          color: Constant.textBtnColor,
          borderRadius: BorderRadius.circular(10)
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  /// Custom OTP Box (TestField)
  static customOtpBox(TextEditingController controller) {
    return Pinput(
      controller: controller,
      length: 4,
      autofocus: true,
      closeKeyboardWhenCompleted: true,
      keyboardType: TextInputType.number,
    );
  }

  /// Custom Alert Box
  static customAlertBox(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(text),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok')),
            ],
          );
        });
  }

  /// Custom Home Card
  static customHomeCard(
      VoidCallback voidCallback, String text, IconData iconData) {
    return Container(
      height: Constant.height * .18,
      width: Constant.width * .45,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 5,
              // spreadRadius: 1,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            iconData,
            size: 70,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  /// Custom Full Width Home Card
  static customFullWidthHomeCard(
      VoidCallback voidCallback, String text, IconData iconData) {
    return GestureDetector(
      onTap: voidCallback,
      child: Container(
        height: Constant.height * .16,
        width: Constant.width * .44,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade500,
                  blurRadius: 2,
                  spreadRadius: 1,
                  offset: const Offset(2.0, 2.0))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              iconData,
              size: Constant.height * .1,
              color: Colors.grey.shade800,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.grey.shade800),
            )
          ],
        ),
      ),
    );
  }

  /// customOneByFourButton
  static customOneByFourButton(VoidCallback voidCallback, String text) {
    return Container(
      height: Constant.height * .05,
      width: Constant.width * .23,
      decoration: const BoxDecoration(),
      child: ElevatedButton(
          onPressed: () {
            voidCallback();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Constant.textBtnColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: Text(text,
              style: TextStyle(color: Colors.white, fontSize: Constant.width * .035), maxLines: 1,)),
    );
  }

}
