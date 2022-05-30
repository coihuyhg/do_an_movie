import 'package:do_an_movie/ui/user/widgets/button.dart';
import 'package:do_an_movie/ui/user/widgets/text.dart';
import 'package:do_an_movie/ui/user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Change Password',
          style: TextStyle(fontSize: 20, color: Color(0xFF0F1B2B)),
        ),
        centerTitle: true,
        foregroundColor: const Color(0xFF0F1B2B),
        backgroundColor: const Color(0xFFFFFFFF),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserText(text: 'Old Password'.toUpperCase()),
              const SizedBox(height: 8),
              UserTexField(image: 'assets/icons/ic_lock.png'),
              const SizedBox(height: 24),
              UserText(text: 'New Password'.toUpperCase()),
              const SizedBox(height: 8),
              UserTexField(image: 'assets/icons/ic_lock.png'),
              const SizedBox(height: 24),
              UserText(text: 'Re-type Password'.toUpperCase()),
              const SizedBox(height: 8),
              UserTexField(image: 'assets/icons/ic_lock.png'),
              const SizedBox(height: 50),
              UserElevatedButton(
                onPressed: () {},
                text: 'Save Change',
              )
            ],
          ),
        ),
      ),
    );
  }
}
