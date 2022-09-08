import 'package:diet/utils/app_suitable_widget_size.dart';
import '../app_function/app_validation.dart';
import 'package:diet/utils/form_text_type.dart';
import 'package:flutter/material.dart';



class CustomTextFormWithHint extends StatefulWidget {
  late String hintText;
  late TextStyle hintStyle;
  late TextStyle textFromStyle;
  late Color color;
  late double width;
  late double height;
  late double radius;
  late TextEditingController controller;
  late FormTextType type;
  late TextInputType textInputType;
  late VoidCallback onFieldSubmitted;
  var pass;
  GlobalKey<FormState> formKey= new GlobalKey<FormState>();
  CustomTextFormWithHint({
    required this.formKey,
    required this.hintText,
    required this.hintStyle,
    required this.textFromStyle,
    required this.color,
    required this.width,
    required this.height,
    required this.radius,
    required this.controller,
    required this.type,
    required this.textInputType,
    required this.onFieldSubmitted,
    this.pass,
  });

  @override
  _CustomTextFormWithHintState createState() => _CustomTextFormWithHintState();
}

class _CustomTextFormWithHintState extends State<CustomTextFormWithHint> {
  AppValidation _validation = AppValidation();
  bool _passwordVisible = false;



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * widget.width,
      // height: AppSuitableWidgetSize()
      //     .getSuitableWidgedgetSize()
      //     .getSuitableWidgetHeight(widget.height, context),
      child: Stack(
        children: [
          Container(
            // height: AppSuitableWidgetSize()
            //     .getSuitableWidgetHeight(widget.height * 0.7, context),
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
              // ignore: prefer_const_constructors
              borderRadius: BorderRadius.all(
                // ignore: prefer_const_constructors
                Radius.circular(20),
              ),
            ),
          ),
          Form(
            key: widget.formKey,
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TextFormField(
              keyboardType: widget.textInputType,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: _passwordVisible,
              textAlign: TextAlign.start,
              style: widget.textFromStyle,
              onFieldSubmitted: (value) {
                widget.onFieldSubmitted.call();
              },
              controller: widget.controller,
              validator: (value) {
                switch (widget.type) {
                  case FormTextType.Email:
                    return _validation.validateEmail(value!, context);
                  case FormTextType.Password:
                    return _validation.validatePassword(value!, context);
                  case FormTextType.Field:
                    return _validation.validateField(value!, context);
                  case FormTextType.RePassword:
                    return _validation.validateRePassword(value!,widget.pass, context);
                  case FormTextType.Noun:
                    return _validation.validateNoun(value!, context);
                }
              },
              decoration: InputDecoration(
                suffixIcon: widget.type == FormTextType.Password
                    ? IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ) : null,

                fillColor: widget.color,
                filled: true,
                hintStyle: widget.hintStyle,
                hintText:  widget.hintText,
                // AppLocalizations.of(context)!.translate(widget.hintText),
                contentPadding: EdgeInsets.symmetric(
                    vertical: AppSuitableWidgetSize()
                        .getSuitableWidgetHeight(10, context),
                    horizontal: AppSuitableWidgetSize()
                        .getSuitableWidgetHeight(10, context)),
                border: OutlineInputBorder(
                  borderSide: widget.type!=FormTextType.Noun?BorderSide(
                    width: AppSuitableWidgetSize().getSuitableWidgetHeight(
                        AppSuitableWidgetSize()
                            .getSuitableWidgetHeight(1, context),
                        context),
                    color: Colors.grey,
                  ):BorderSide.none,
                  borderRadius: BorderRadius.circular(widget.radius),
                ),
                // focusedErrorBorder: OutlineInputBorder(
                //   borderSide: BorderSide(
                //     width: AppSuitableWidgetSize().getSuitableWidgetHeight(
                //         AppSuitableWidgetSize()
                //             .getSuitableWidgetHeight(1, context),
                //         context),
                //     color: Colors.grey,
                //   ),
                //   borderRadius: BorderRadius.circular(widget.radius),
                // ),
                // disabledBorder: OutlineInputBorder(
                //   borderSide: widget.type==FormTextType.Noun?BorderSide(
                //     width: AppSuitableWidgetSize().getSuitableWidgetHeight(
                //         AppSuitableWidgetSize()
                //             .getSuitableWidgetHeight(1, context),
                //         context),
                //     color: Colors.grey,
                //   ):BorderSide.none,
                //   borderRadius: BorderRadius.circular(widget.radius),
                // ),
                // enabledBorder: OutlineInputBorder(
                //   borderSide: BorderSide(
                //     width: AppSuitableWidgetSize().getSuitableWidgetHeight(
                //         AppSuitableWidgetSize()
                //             .getSuitableWidgetHeight(1, context),
                //         context),
                //     color: Colors.grey,
                //   ),
                //   borderRadius: BorderRadius.circular(widget.radius),
                // ),
                // focusedBorder: OutlineInputBorder(
                //   borderSide: BorderSide(
                //     width: AppSuitableWidgetSize().getSuitableWidgetHeight(
                //         AppSuitableWidgetSize()
                //             .getSuitableWidgetHeight(1, context),
                //         context),
                //     color: Colors.grey,
                //   ),
                //   borderRadius: BorderRadius.circular(widget.radius),
                // ),
                // errorBorder: OutlineInputBorder(
                //   borderSide: BorderSide(
                //     width: AppSuitableWidgetSize().getSuitableWidgetHeight(
                //         AppSuitableWidgetSize()
                //             .getSuitableWidgetHeight(1, context),
                //         context),
                //     color: Colors.grey,
                //   ),
                //   borderRadius: BorderRadius.circular(widget.radius),
                // ),
                // errorStyle: AppTextStyle.cairo13RegularRed_ff0000(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
