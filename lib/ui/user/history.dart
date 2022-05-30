import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transactions History',
          style: TextStyle(fontSize: 20, color: Color(0xFF0F1B2B)),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFFFFF),
        foregroundColor: const Color(0xFF0F1B2B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 192,
              color: Colors.green,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: listHistory.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: const Color(0xFFFFFFFF)),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          color: const Color(0x1A47CFFF),
                          child:
                              Image.asset('${listHistory[index]['img']}'),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${listHistory[index]['title']}',
                                style: const TextStyle(
                                    fontSize: 16, color: Color(0xFF0F1B2B)),
                              ),
                              Text(
                                '${listHistory[index]['name']}',
                                style: const TextStyle(
                                    fontSize: 14, color: Color(0x800F1B2B)),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${listHistory[index]['money']}',
                                style: const TextStyle(
                                    fontSize: 16, color: Color(0xFFE51937)),
                              ),
                              Text(
                                '${listHistory[index]['date']}',
                                style: const TextStyle(
                                    fontSize: 14, color: Color(0x800F1B2B)),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<Map<String, Object>> listHistory = [
  {
    'img' : 'assets/icons/ic_bank-card-line.png',
    'title' : 'Booked Ticket',
    'name' : 'John Wick 3: Parabellum',
    'money' : '- \$54.00',
    'date' : '24 MAY, 2019'
  },
  {
    'img' : 'assets/icons/ic_bank-card-line.png',
    'title' : 'King of the Monsters',
    'name' : 'John Wick 3: Parabellum',
    'money' : '- \$38.00',
    'date' : '24 MAY, 2019'
  },
  {
    'img' : 'assets/icons/ic_exchange-dollar-fill.png',
    'title' : 'Transfer Money',
    'name' : 'Bank Account',
    'money' : '+ \$60.00',
    'date' : '24 MAY, 2019'
  },
  {
    'img' : 'assets/icons/ic_bank-card-line.png',
    'title' : 'Booked Ticket',
    'name' : 'The Secret Life of Pets ',
    'money' : '- \$54.00',
    'date' : '24 MAY, 2019'
  },
];
