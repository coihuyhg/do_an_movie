import 'package:do_an_movie/ui/user/change_password.dart';
import 'package:do_an_movie/ui/user/widgets/button.dart';
import 'package:do_an_movie/ui/user/widgets/text.dart';
import 'package:do_an_movie/ui/user/widgets/text_field.dart';
import 'package:flutter/material.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({Key? key}) : super(key: key);

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        title: const Text(
          'Account Information',
          style: TextStyle(fontSize: 20, color: Color(0xFF0F1B2B)),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFFFFF),
        foregroundColor: const Color(0xFF0F1B2B),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 134.0, right: 134.0, bottom: 16.0),
                child: Container(
                  width: 104,
                  height: 104,
                  color: Colors.red,
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.only(left: 130.0, right: 130.0, bottom: 32.0),
                child: Text(
                  'Change Photo',
                  style: TextStyle(fontSize: 16, color: Color(0xFF47CFFF)),
                ),
              ),
              UserText(text: 'User name'.toUpperCase()),
              const SizedBox(height: 8),
              UserTexField(image: 'assets/icons/ic_single.png'),
              const SizedBox(height: 24),
              UserText(text: 'Email'.toUpperCase()),
              const SizedBox(height: 8),
              UserTexField(image: 'assets/icons/ic_mail.png'),
              const SizedBox(height: 24),
              UserText(text: 'Phone'.toUpperCase()),
              const SizedBox(height: 8),
              UserTexField(image: 'assets/icons/ic_mobile-phone.png'),
              const SizedBox(height: 24),
              UserText(text: 'Birthday'.toUpperCase()),
              const SizedBox(height: 8),
              UserTexField(image: 'assets/icons/ic_calendar-line.png'),
              const SizedBox(
                height: 50,
              ),
              UserElevatedBTWhite(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangePassword(),
                      ));
                },
                text: 'Change Password',
              ),
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
