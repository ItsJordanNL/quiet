import 'package:flutter/material.dart';
import 'package:quiet_app/constants/constants.dart';

// Variables ticket
class Ticket {
  final String memberPicture;
  final String memberName;
  final String date;
  final Color status;
  final String textStatus;
  final String titleVoucher;
  final String nameVolunteer;

  Ticket({
    required this.memberPicture,
    required this.memberName,
    required this.date,
    required this.status,
    required this.textStatus,
    required this.titleVoucher,
    required this.nameVolunteer,
  });
}
// Sorting for priority of ticketstatus
bool ascendingOrder = true;

class DashboardQuestionlist extends StatefulWidget {
  final String nameVolunteer;

  const DashboardQuestionlist({super.key, required this.nameVolunteer});

  @override
  State<DashboardQuestionlist> createState() => _DashboardQuestionlistState();
}
// List of tickets
class _DashboardQuestionlistState extends State<DashboardQuestionlist> {
  List<Ticket> tickets = [
    Ticket(
      memberPicture: 'assets/images/member_truus.png',
      memberName: "Truus Bekker",
      date: "3-6-3024",
      status: primary,
      textStatus: 'Afgehandeld',
      titleVoucher: "Voetbalwedstrijd Ajax-PSV #1",
      nameVolunteer: "Sarah",
    ),
    Ticket(
      memberPicture: 'assets/images/member_joost.png',
      memberName: "Joost Vries",
      date: "6-6-2024",
      status: inprogress,
      textStatus: 'In behandeling',
      titleVoucher: "Aanvullend dineren bij t'Zusje #2",
      nameVolunteer: "Klaas",
    ),
    Ticket(
      memberPicture: 'assets/images/member_bea.png',
      memberName: "Bea Stipt",
      date: "12-6-2024",
      status: unanswered,
      textStatus: 'Openstaand',
      titleVoucher: "Ouwehands Dierenpark #3",
      nameVolunteer: "",
    ),
    Ticket(
      memberPicture: 'assets/images/member_fleur.png',
      memberName: "Fleur de \n Vries",
      date: "12-6-2024",
      status: inprogress,
      textStatus: 'In behandeling',
      titleVoucher: "Zwembad voucher #4",
      nameVolunteer: "Jordan",
    ),
    Ticket(
      memberPicture: 'assets/images/member_sasha.png',
      memberName: "Sasha \n Bouwels",
      date: "12-6-2024",
      status: inprogress,
      textStatus: 'In behandeling',
      titleVoucher: "Kapper voucher #5",
      nameVolunteer: "Jordan",
    ),
    Ticket(
      memberPicture: 'assets/images/member_lotte.png',
      memberName: "Lotte van der \n Meer",
      date: "12-6-2024",
      status: unanswered,
      textStatus: 'Openstaand',
      titleVoucher: "Museum Mauritshuis #6",
      nameVolunteer: "",
    ),
  ];
// Dropdown menu
  final List<String> _dropdownItems = ['Vragen van Leden', 'Vragen voor Jou'];
  String _selectedItem = 'Vragen van Leden';

  List<Ticket> get filteredTickets {
    if (_selectedItem == 'Vragen van Leden') {
      return tickets;
    } else if (_selectedItem == 'Vragen voor Jou') {
      return tickets
      // selects the volunteer who is logged in
          .where((ticket) => ticket.nameVolunteer == widget.nameVolunteer)
          .toList();
    }
    return tickets; 
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 130, left: 20, right: 20),
      child: Column(children: [
        // Dropdown menu and filter button
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                value: _selectedItem,
                icon: const Icon(Icons.arrow_drop_down_rounded),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: secondaryText,
                ),
                underline: Container(
                  height: 2,
                  color: primary,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedItem = newValue!;
                  });
                },
                items: _dropdownItems
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(color: secondaryText),
                    ),
                  );
                }).toList(),
              ),
              // Status filter button
              SizedBox(
                width: 40,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    // Define the order of statuses
                    List<String> statusOrder = [
                      'Afgehandeld',
                      'In behandeling',
                      'Openstaand'
                    ];

                    // Toggle sorting order
                    ascendingOrder = !ascendingOrder;

                    // Sort filteredTickets based on the selected order
                    filteredTickets.sort((a, b) {
                      int indexA = statusOrder.indexOf(a.textStatus);
                      int indexB = statusOrder.indexOf(b.textStatus);

                      // Determine sorting direction based on ascendingOrder flag
                      if (ascendingOrder) {
                        return indexA.compareTo(indexB); // Ascending order
                      } else {
                        return indexB.compareTo(indexA); // Descending order
                      }
                    });

                    // Update the UI
                    setState(() {
                      // No need to set _selectedItem again if not changed
                      // _selectedItem = _selectedItem;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(10),
                    backgroundColor: primary,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 20,
                    color: backgroundColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Date
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          width: 96,
          height: 23,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: secondary,
          ),
          child: const Text(
            'juni',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        // List of tickets
        Expanded(
          child: ListView.builder(
            itemCount: filteredTickets.length,
            itemBuilder: (context, index) {
              Ticket ticket = filteredTickets[index];
              // ticket
              return Card(
                margin: const EdgeInsets.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // picture and name member
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ClipOval(
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(30),
                              child: Image.asset(ticket.memberPicture,
                                  fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            ticket.memberName,
                            style: const TextStyle(fontSize: 11),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 15),
                      width: 243,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Date
                                Opacity(
                                  opacity: 0.85,
                                  child: Text(
                                    ticket.date,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                // Status
                                Container(
                                  decoration: BoxDecoration(
                                    color: ticket.status,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    ticket.textStatus,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: primaryText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Title voucher
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                Text(
                                  ticket.titleVoucher,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          // Name volunteer
                          Row(
                            children: [
                              const Opacity(
                                opacity: 0.5,
                                child: Icon(Icons.person_outline_rounded),
                              ),
                              const SizedBox(width: 5),
                              Opacity(
                                opacity: 0.5,
                                child: Text(
                                  ticket.nameVolunteer,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}