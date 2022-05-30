import 'package:flutter/material.dart';

class UserTexField extends StatelessWidget {
  String? image;

  UserTexField({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        prefixIcon: Image.asset(image!),
      ),
    );
  }
}
