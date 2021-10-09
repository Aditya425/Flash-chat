
import 'package:flutter/material.dart';

InputDecoration kTextFieldDecorationPassword = InputDecoration(
    hintText: "Enter your password",
    prefixIcon: Icon(Icons.password),
    filled: false,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20)
    ),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.black,
            width: 2
        ),
        borderRadius: BorderRadius.circular(20)
    )
);

InputDecoration kTextFieldDecorationEmail = InputDecoration(
    hintText: "Enter your email",
    prefixIcon: Icon(Icons.email),
    filled: false,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20)
    ),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.black,
            width: 2
        ),
        borderRadius: BorderRadius.circular(20)
    )
);