import 'package:do_an_movie/ui/user/account_information.dart';
import 'package:do_an_movie/ui/user/history.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        automaticallyImplyLeading: true,
        title: textSizeBig('Profile'),
        backgroundColor: const Color(0xFFFFFFFF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              width: 104,
              height: 104,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textSizeBig('Quang Huy'),
                const SizedBox(width: 8),
                Container(
                  width: 69,
                  height: 24,
                  color: const Color(0x2219E58F),
                  child: Center(
                    child: Text('member'.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xFF19E58F))),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'huynqh1209@gmail.com',
              style: TextStyle(fontSize: 16, color: Color(0x800F1B2B)),
            ),
            const SizedBox(height: 40),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      textSizeVeryBig('123'),
                      const Text(
                        'Total points',
                        style:
                            TextStyle(fontSize: 14, color: Color(0x800F1B2B)),
                      ),
                    ],
                  ),
                  const VerticalDivider(
                    color: Color(0x4D0F1B2B),
                    thickness: 1,
                  ),
                  Column(
                    children: [
                      textSizeVeryBig('06'),
                      const Text(
                        'Movies watched',
                        style:
                            TextStyle(fontSize: 14, color: Color(0x800F1B2B)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 52),
            chosseProfile(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountInformation(),
                ),
              );
            }, 'assets/icons/ic_single-03.png', 'Account Information'),
            const SizedBox(height: 16),
            chosseProfile(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const History(),
                ),
              );
            }, 'assets/icons/ic_round-dollar.png',
                'Transactions History'),
            const SizedBox(height: 16),
            chosseProfile(() {}, 'assets/icons/ic_fav-list.png', 'Rating App'),
            const SizedBox(height: 16),
            chosseProfile(
                () {}, 'assets/icons/ic_folder-15.png', 'Privacy Policy'),
          ],
        ),
      ),
    );
  }

  Widget chosseProfile(VoidCallback onTap, String image, String title) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(width: 1)),
        child: Row(
          children: [
            Image.asset(image),
            const SizedBox(
              width: 13,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }

  Widget textSizeVeryBig(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 32, color: Color(0xFF0F1B2B)),
    );
  }

  Widget textSizeBig(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 26, color: Color(0xFF0F1B2B)),
    );
  }
}
