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
      memberName: "Lotte van \n der Meer",
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

// Select the volunteer who is logged in to sort the tickets
  List<Ticket> get filteredTickets {
    if (_selectedItem == 'Vragen van Leden') {
      return tickets;
    } else if (_selectedItem == 'Vragen voor Jou') {
      return tickets
          .where((ticket) => ticket.nameVolunteer == widget.nameVolunteer)
          .toList();
    }
    return tickets;
  }

  double responsiveFontsize(double screenWidth, double baseFontSize) {
    return screenWidth * baseFontSize / 400; 
  }

  @override
  Widget build(BuildContext context) {
    // create responsiveness 
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;

    return Container(
      margin: EdgeInsets.only(
          top: height * 0.2, left: width * 0.05, right: width * 0.05),
      child: Column(children: [
        // Dropdown menu and filter button
        Container(
          margin: EdgeInsets.only(top: height * 0.02, bottom: height * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                value: _selectedItem,
                icon: const Icon(Icons.arrow_drop_down_rounded),
                style: TextStyle(
                  fontSize: responsiveFontsize(width, 16),
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
                      style: TextStyle(
                        color: secondaryText,
                        fontSize: responsiveFontsize(width, 16),
                      ),
                    ),
                  );
                }).toList(),
              ),
              // Status filter button
              SizedBox(
                width: width * 0.1,
                height: width * 0.1,
                child: ElevatedButton(
                  onPressed: () {
                    // Status
                    List<String> statusOrder = [
                      'Afgehandeld',
                      'In behandeling',
                      'Openstaand'
                    ];

                    // Toggle sorting order
                    ascendingOrder = !ascendingOrder;

                    filteredTickets.sort((a, b) {
                      int indexA = statusOrder.indexOf(a.textStatus);
                      int indexB = statusOrder.indexOf(b.textStatus);

                      if (ascendingOrder) {
                        return indexA.compareTo(indexB); // Ascending order
                      } else {
                        return indexB.compareTo(indexA); // Descending order
                      }
                    });

                    setState(() {});
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
          margin: EdgeInsets.only(bottom: height * 0.02),
          width: width * 0.25,
          height: height * 0.03,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: secondary,
          ),
          child: Center(
            child: Text(
              'juni',
              style: TextStyle(fontSize: responsiveFontsize(width, 16)),
              textAlign: TextAlign.center,
            ),
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
                margin: EdgeInsets.only(bottom: height * 0.02),
                child: Row(
                  // picture and name member
                  children: [
                    Container(
                      margin: EdgeInsets.all(width * 0.04),
                      child: Column(
                        children: [
                          ClipOval(
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(width * 0.08),
                              child: Image.asset(ticket.memberPicture,
                                  fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            ticket.memberName,
                            style: TextStyle(
                              fontSize: responsiveFontsize(width, 11),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: width * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: height * 0.01),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Date
                                  Opacity(
                                    opacity: 0.85,
                                    child: Text(
                                      ticket.date,
                                      style: TextStyle(
                                        fontSize: responsiveFontsize(width, 15),
                                      ),
                                    ),
                                  ),
                                  // Status
                                  Container(
                                    decoration: BoxDecoration(
                                      color: ticket.status,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.all(width * 0.01),
                                    child: Text(
                                      ticket.textStatus,
                                      style: TextStyle(
                                        fontSize: responsiveFontsize(width, 12),
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
                              padding: EdgeInsets.only(bottom: height * 0.01),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      ticket.titleVoucher,
                                      style: TextStyle(
                                        fontSize: responsiveFontsize(width, 14),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Name volunteer
                            Row(
                              children: [
                                Opacity(
                                  opacity: 0.5,
                                  child: Icon(
                                    Icons.person_outline_rounded,
                                    size: responsiveFontsize(width, 20),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Opacity(
                                  opacity: 0.5,
                                  child: Text(
                                    ticket.nameVolunteer,
                                    style: TextStyle(
                                      fontSize: responsiveFontsize(width, 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
