import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';




class AppValidation {




  String? validateEmail(String valueWithout, BuildContext context) {
    String? msg;
    String value = valueWithout.replaceAll(" ", "");

    if (value.isEmpty) {
      return "you_can't_have_an_empty_field";
    } else {
      if (!EmailValidator.validate(value)) {
        // ignore: avoid_print
        print(value.length);
        return "invalid_email";
      } else {
        return msg;
      }
    }
  }

  String ?validatePassword(String value, BuildContext context) {
    String? msg ;
    if (value.isEmpty) {
      msg = "you_can't_have_an_empty_field";
    } else if (value.length < 6) {
        msg = "password_must_be_at_least_6_characters";
   ///strong pass
      // } else {
      //   String pattern =
      //       r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{6,}$";
      //   RegExp regExp = new RegExp(pattern);
      //   if (!regExp.hasMatch(value)) {
      //     msg = "password_complex_msg";
      //   }
      // }
    }
    return msg;
  }
  String ?validateRePassword(String value, String pass, BuildContext context) {
    String? msg ;
    if (value.isEmpty) {
      msg = "you_can't_have_an_empty_field";
    } else if(!value.startsWith(pass)&&!value.endsWith(pass))
        msg ="not current";


    return msg;
  }

  String? validateField(String value, BuildContext context) {
    String? msg;
    if (value.trim().isEmpty) {
      msg ="you_can't_have_an_empty_field";
    }
    return msg;
  }
  String? validateNoun(String value, BuildContext context) {

    return '';
  }

}

