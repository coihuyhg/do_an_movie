import 'package:flutter/material.dart';

class Ticket extends StatefulWidget {
  const Ticket({Key? key}) : super(key: key);

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tickets',
          style: (TextStyle(fontSize: 26, color: Color(0xFF0F1B2B))),
        ),
        backgroundColor: const Color(0xFFFFFFFF),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/image/img_MaskGroup.png',
              fit: BoxFit.cover,
            ),
            Container(
              padding: const EdgeInsets.all(24.0),
              margin: const EdgeInsets.only(left: 26, right: 26),
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              color: const Color(0xFFFFFFFF),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'John Wick 3: Parabellum',
                    style: TextStyle(fontSize: 20, color: Color(0xFF0F1B2B)),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Threatre',
                    style: TextStyle(fontSize: 14, color: Color(0x800F1B2B)),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Paragon Cinema',
                    style: TextStyle(fontSize: 16, color: Color(0xFF0F1B2B)),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: const [
                      Expanded(
                        child: Text(
                          'Date',
                          style:
                              TextStyle(fontSize: 14, color: Color(0x800F1B2B)),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Time',
                          style:
                              TextStyle(fontSize: 14, color: Color(0x800F1B2B)),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: const [
                      Expanded(
                        child: Text(
                          '24 May, 2019',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF0F1B2B)),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '8:30 - 10:00 AM',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF0F1B2B)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Hall'.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 14, color: Color(0x800F1B2B)),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Row'.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 14, color: Color(0x800F1B2B)),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Seat'.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 14, color: Color(0x800F1B2B)),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: const [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'C',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF0F1B2B)),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'E',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF0F1B2B)),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'E4, E5',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF0F1B2B)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
