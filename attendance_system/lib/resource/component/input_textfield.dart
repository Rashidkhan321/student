
import 'package:flutter/material.dart';

import '../color.dart';


class textfield extends StatelessWidget {
  const textfield({Key? key,
    required this.mycontroller,
    required this.focusNode,
    required this.fieldSetter,
    required this.keyBoradtype,
    required this.obscureText,
    required this.hint,
    this.enable=true,
    required this.fieldValidator,
    this.autoFocus= false,
    required this.icon,
   required this.label,

  }) : super(key: key);
  final TextEditingController  mycontroller;
  final FocusNode focusNode;
  final FormFieldSetter fieldSetter;
  final FormFieldValidator fieldValidator;
  final TextInputType keyBoradtype;
  final String hint;
  final bool obscureText;
  final bool enable, autoFocus;
  final Icon icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(


        controller:  mycontroller,
        focusNode:  focusNode,
        onFieldSubmitted: fieldSetter,
        obscureText: obscureText,
        validator: fieldValidator,
        keyboardType:  keyBoradtype,
        enabled: enable,


        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon,
contentPadding: EdgeInsets.all(1),
          hintText: hint,

          border: const OutlineInputBorder(
            borderSide:  BorderSide(color:  AppColors.textFieldDefaultFocus, ),
            borderRadius: BorderRadius.all(Radius.circular(8)),

          ),
            focusedBorder:  OutlineInputBorder(
        borderSide:  BorderSide(color:  AppColors.secondaryColor, ),
        borderRadius: BorderRadius.all(Radius.circular(8)),

      ),
          errorBorder:  OutlineInputBorder(
            borderSide:  BorderSide(color:  AppColors.alertColor, ),
            borderRadius: BorderRadius.all(Radius.circular(8)),

          ),
          enabledBorder:  OutlineInputBorder(
            borderSide:  BorderSide(color:  AppColors.textFieldDefaultBorderColor, ),
            borderRadius: BorderRadius.all(Radius.circular(8)),

          )
        ),

      ),
    );
  }
}
