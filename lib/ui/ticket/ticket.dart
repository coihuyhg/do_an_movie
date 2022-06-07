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
      body: Stack(
        children: [
          Image.asset('name'),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.blue,
            child: Column(
              children: [
                const Text('John Wick 3: Parabellum'),
                const Text('Threatre'),
                const Text('Paragon Cinema'),
                Row(
                  children: const [
                    Text('Date'),
                    Text('Time')
                  ],
                ),
                Row(
                  children: const [
                    Text('24 May, 2019'),
                    Text('8:30 - 10:00 AM'),
                  ],
                ),
                Row(
                  children: [
                    Text('Hall'.toUpperCase()),
                    Text('Row'.toUpperCase()),
                    Text('Seat'.toUpperCase())
                  ],
                ),
                Row(
                  children: const [
                    Text('C'),
                    Text('E'),
                    Text('E4, E5')
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
