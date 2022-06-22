import 'package:do_an_movie/ui/user/profile.dart';
import 'package:do_an_movie/ui/user/sign_up.dart';
import 'package:do_an_movie/ui/user/widgets/button.dart';
import 'package:do_an_movie/ui/user/widgets/text.dart';
import 'package:do_an_movie/ui/user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Profile',
              style: TextStyle(fontSize: 26, color: Color(0xFF0F1B2B)),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUp()));
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18, color: Color(0xFFE51937)),
                ))
          ],
        ),
        backgroundColor: const Color(0xFFFFFFFF),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, top: 100, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserText(text: 'User name'.toUpperCase()),
              const SizedBox(
                height: 8,
              ),
              UserTexField(image: 'assets/icons/ic_single.png'),
              const SizedBox(
                height: 16,
              ),
              UserText(text: 'Password'.toUpperCase()),
              const SizedBox(
                height: 8,
              ),
              UserTexField(image: 'assets/icons/ic_lock.png'),
              const SizedBox(
                height: 81,
              ),
              UserElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Profile()));
                },
                text: 'Login',
              ),
              const SizedBox(
                height: 131,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.0),
                      color: const Color(0xFF1AA9E1),
                    ),
                    child: Image.asset('assets/logos/logo-twitter.png'),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.0),
                      color: const Color(0xFF3B5A9A),
                    ),
                    child: Image.asset('assets/logos/logo-fb-simple.png'),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.0),
                      color: const Color(0xFFCB3E2D),
                    ),
                    child: Image.asset('assets/logos/logo-google-plus.png'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
