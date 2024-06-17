import 'package:flutter/material.dart';
import 'package:quiet_app/constants/constants.dart';
// Variables ticket
class Ticket {
  final String memberPicture;
  final String memberName;
  final String date;
  final Color status;
  final String titleVoucher;
  final String nameVolunteer;

  Ticket({
    required this.memberPicture,
    required this.memberName,
    required this.date,
    required this.status,
    required this.titleVoucher,
    required this.nameVolunteer,
  });
}

class DashboardQuestionlist extends StatefulWidget {
  const DashboardQuestionlist({super.key});

  @override
  State<DashboardQuestionlist> createState() => _DashboardQuestionlistState();
}
// Information about ticket
class _DashboardQuestionlistState extends State<DashboardQuestionlist> {
  final List<Ticket> tickets = [
    Ticket(
      memberPicture: 'assets/images/member_truus.png',
      memberName: "Truus Bekker",
      date: "3-6-2024",
      status: primary,
      titleVoucher: "Voetbalwedstrijd PSV-Ajax #1",
      nameVolunteer: "Sarah",
    ),
    Ticket(
      memberPicture: 'assets/images/member_joost.png',
      memberName: "Joost Vries",
      date: "6-6-2024",
      status:  inprogress,
      titleVoucher: "Aanvullend dineren bij t'Zusje #2",
      nameVolunteer: "Klaas",
    ),
    Ticket(
      memberPicture: 'assets/images/member_bea.png',
      memberName: "Bea Stipt",
      date: "12-6-2024",
      status: unanswered,
      titleVoucher: "Ouwehands Dierenpark # 3",
      nameVolunteer: "",
    ),
       
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 245, left: 20, right: 20, bottom: 10),
      child: ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          // UI of ticket
          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),

                  child: Column(
                    children: [
                      ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(30),
                          child: Image.asset(tickets[index].memberPicture,
                              fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        tickets[index].memberName,
                        style: const TextStyle(fontSize: 11),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
               Container(
                   margin: const EdgeInsets.only(right: 15),
                  width: 244,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Opacity(
                              opacity: 0.85,
                              child: Text(tickets[index].date),
                            ),
                            Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                  color: tickets[index].status, shape: BoxShape.circle),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Text(
                              tickets[index].titleVoucher,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Row(children: [
                        const Opacity(
                          opacity: 0.5,
                          child: Icon(Icons.person_outline_rounded),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Opacity(
                          opacity: 0.5,
                          child: Text(
                            tickets[index].nameVolunteer,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

