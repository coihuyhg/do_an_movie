import 'package:flutter/material.dart';

class UserElevatedButton extends StatelessWidget {
  String? text;
  VoidCallback? onPressed;

  UserElevatedButton({
    Key? key,
    this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.06,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text!,
          style: const TextStyle(fontSize: 18, color: Color(0xFFFFFFFF)),
        ),
        style: ElevatedButton.styleFrom(
          primary: const Color(0xFFE51937),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        ),
      ),
    );
  }
}


class UserElevatedBTWhite extends StatelessWidget {
  String? text;
  VoidCallback? onPressed;

  UserElevatedBTWhite({Key? key, this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.06,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text!,
          style: const TextStyle(fontSize: 18, color: Color(0xFFE51937)),
        ),
        style: ElevatedButton.styleFrom(
          primary: const Color(0xFFFFFFFF),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        ),
      ),
    );
  }
}
