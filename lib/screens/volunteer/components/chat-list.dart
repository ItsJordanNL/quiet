// chat_data.dart

class Chat {
  final String name;
  final String lastMessage;
  final DateTime timestamp;
  String status;

  Chat({
    required this.name,
    required this.lastMessage,
    required this.timestamp,
    required this.status,
  });
}

final List<Chat> chats = [
  Chat(
      name: 'Arnold Hooghuizen',
      lastMessage: 'Zou u mij kunnen helpen?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      status: 'heefthulpnodig'),
  Chat(
      name: 'Sasha Bouwels',
      lastMessage: 'Heeft u al iets gehoord van Pathe Eindhoven?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 16)),
      status: 'inproces'),
  Chat(
      name: 'Youri van Rees',
      lastMessage: 'Hoe kan een vriend van mij lid worden van QUIET?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      status: 'geholpen'),
  Chat(
      name: 'Lotte van der Meer',
      lastMessage: 'Bied QUIET ook cursussen aan?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 40)),
      status: 'heefthulpnodig'),
  Chat(
      name: 'Restaurant Diverso',
      lastMessage: 'U mag namens ons een voucher aanbieden.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 55)),
      status: 'heefthulpnodig'),
  Chat(
      name: 'Fleur de Vries',
      lastMessage: 'Zijn er nog wat zwembad vouchers vrij?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 70)),
      status: 'heefthulpnodig'),
  Chat(
      name: 'Stijn van den Berg',
      lastMessage: 'Hoe kan ik mijn voorkeuren aanpassen?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 85)),
      status: 'geholpen'),
  Chat(
      name: 'Hans Verhoeven',
      lastMessage: 'Hoe kan ik een vrijwilliger worden van QUIET?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 55)),
      status: 'heefthulpnodig'),
  Chat(
      name: 'Restaurant Mio Mio',
      lastMessage: 'Hoe kan ik een sponsor worden?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 41)),
      status: 'inproces'),
  Chat(
      name: 'Finn Handels',
      lastMessage: 'Zijn er ook groepsactiviteiten?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 150)),
      status: 'heefthulpnodig'),
  Chat(
      name: 'Robbie Schroen',
      lastMessage: 'Bedankt voor het helpen?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 33)),
      status: 'geholpen'),
  // Add more chats as needed
];
