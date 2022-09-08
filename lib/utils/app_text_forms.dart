
import 'package:diet/widgets/costom_text_form_hint.dart';
import 'package:flutter/material.dart';
import 'app_text_style.dart';
import 'form_text_type.dart';

class AppTextForms {
  static CustomTextFormWithHint registerTextForm(
    GlobalKey<FormState> globalKey,
    BuildContext context,
    String hintText,
    double width,
    double height,
    TextEditingController controller,
    FormTextType type,
    TextInputType textInputType,
    VoidCallback onFieldSubmitted,
    String pass,
  ) {
    return CustomTextFormWithHint(
        formKey: globalKey,
        hintText: hintText,
        hintStyle: AppTextStyle.cairo16RegularGray585858(context),
        textFromStyle: AppTextStyle.cairo16RegularBlack000000(context),
        color: Colors.white,
        width: width,
        height: height,
        radius: 20,
        controller: controller,
        type: type,
        textInputType: textInputType,
        onFieldSubmitted: onFieldSubmitted,
      pass: pass,
    );
  }
}
