import 'package:do_an_movie/ui/user/login.dart';
import 'package:do_an_movie/ui/user/widgets/button.dart';
import 'package:do_an_movie/ui/user/widgets/text.dart';
import 'package:do_an_movie/ui/user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
          style: TextStyle(fontSize: 20, color: Color(0xFF0F1B2B)),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFFFFF),
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserText(text: 'User name'.toUpperCase()),
              const SizedBox(
                height: 5,
              ),
              UserTexField(image: 'assets/icons/ic_single.png'),
              const SizedBox(
                height: 17,
              ),
              UserText(text: 'Email'.toUpperCase()),
              const SizedBox(
                height: 5,
              ),
              UserTexField(image: 'assets/icons/ic_mail.png'),
              const SizedBox(
                height: 17,
              ),
              UserText(text: 'Phone'.toUpperCase()),
              const SizedBox(
                height: 5,
              ),
              UserTexField(image: 'assets/icons/ic_mobile-phone.png'),
              const SizedBox(
                height: 17,
              ),
              UserText(text: 'Birthday'.toUpperCase()),
              const SizedBox(
                height: 5,
              ),
              UserTexField(image: 'assets/icons/ic_calendar-line.png'),
              const SizedBox(
                height: 17,
              ),
              UserText(text: 'Password'.toUpperCase()),
              const SizedBox(
                height: 5,
              ),
              UserTexField(image: 'assets/icons/ic_lock.png'),
              const SizedBox(
                height: 17,
              ),
              UserText(text: 'Re-type password'.toUpperCase()),
              const SizedBox(
                height: 5,
              ),
              UserTexField(image: 'assets/icons/ic_lock.png'),
              const SizedBox(
                height: 20,
              ),
              UserElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const User()));
                },
                text: 'Create Account',
              )
            ],
          ),
        ),
      ),
    );
  }
}
