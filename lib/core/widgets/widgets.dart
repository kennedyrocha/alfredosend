import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sendify/core/utils/custom_colors.dart';

TextStyle titleTextStyle(double size) =>
    TextStyle(fontWeight: FontWeight.bold, color: CustomColors.FONT, fontSize: size);

TextStyle contentTextStyle(double size) =>
    TextStyle(fontWeight: FontWeight.normal, color: CustomColors.FONT, fontSize: size);

buildTopBar(title, factor) {
  return Container(
    height: factor * 0.7,
    decoration: BoxDecoration(
      color: CustomColors.PRIMARY_COLOR,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.05),
          offset: Offset(0, 0),
          blurRadius: 20,
          spreadRadius: 3,
        )
      ],
    ),
    child: Row(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: titleTextStyle(factor * 0.2),
            ),
          ),
        ),
      ],
    ),
  );
}

defaultTextField(fontSize, title,   {
  onChange,
  multiLine,
  minLine,
  hint,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleTextStyle(fontSize).copyWith(
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xffffffff),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1, color: Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide:
              BorderSide(width: 1, color: Colors.black.withOpacity(0.2)),
            ),
            hintText: hint,
            hintStyle: TextStyle(fontSize: fontSize, color: Colors.black),
          ),
          keyboardType: TextInputType.multiline,
          maxLines: multiLine == null ? null : 1,
          style: TextStyle(fontSize: fontSize, color: Colors.black),
          obscureText: false,
          minLines: minLine,
          onChanged: (value) {
            onChange(value);
          },
        ),
      ],
    );
