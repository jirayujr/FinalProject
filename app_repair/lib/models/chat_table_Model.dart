import 'dart:convert';

class chat_table_Model {
  final String id_customer;
  final String id_repairer;
  final String firstname_customer;
  final String firstname_repairer;
  final String time;
  final String date;
  final String text_detail;
  final String orderChat;
  final String whoSend;


  chat_table_Model({
    required this.id_customer,
    required this.id_repairer,
    required this.firstname_customer,
    required this.firstname_repairer,
    required this.time,
    required this.date,
    required this.text_detail,
    required this.orderChat,
    required this.whoSend,
  });

  chat_table_Model copyWith({
    String? id_customer,
    String? id_repairer,
    String? firstname_customer,
    String? firstname_repairer,
    String? time,
    String? date,
    String? text_detail,
    String? orderChat,
    String? whoSend,

  }) {
    return chat_table_Model(
      id_customer: id_customer ?? this.id_customer,
      id_repairer: id_repairer ?? this.id_repairer,
      firstname_customer: firstname_customer ?? this.firstname_customer,
      firstname_repairer: firstname_repairer ?? this.firstname_repairer,
      time: time ?? this.time,
      date: date ?? this.date,
      text_detail: text_detail ?? this.text_detail,
      orderChat: orderChat ?? this.orderChat,
      whoSend: whoSend ?? this.whoSend,

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_customer': id_customer,
      'id_repairer': id_repairer,
      'firstname_customer': firstname_customer,
      'firstname_repairer': firstname_repairer,
      'time': time,
      'date': date,
      'text_detail': text_detail,
      'orderChat': orderChat,
      'whoSend': whoSend,
    };
  }

  factory chat_table_Model.fromMap(Map<String, dynamic> map) {
    return chat_table_Model(
      id_customer: map['id_customer'] ?? '',
      id_repairer: map['id_repairer'] ?? '',
      firstname_customer: map['firstname_customer'] ?? '',
      firstname_repairer: map['firstname_repairer'] ?? '',
      time: map['time'] ?? '',
      date: map['date'] ?? '',
      text_detail: map['text_detail'] ?? '',
      orderChat: map['orderChat'] ?? '',
      whoSend: map['whoSend'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory chat_table_Model.fromJson(String source) => chat_table_Model.fromMap(json.decode(source));

  @override
  String toString() {
    return 'chat_table_Model(id_customer: $id_customer, id_repairer: $id_repairer, firstname_customer: $firstname_customer'
        ', firstname_repairer: $firstname_repairer, time: $time,date: $date, text_detail: $text_detail,'
        ' orderChat: $orderChat,whoSend:$whoSend)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is chat_table_Model &&
        other.id_customer == id_customer &&
        other.id_repairer == id_repairer &&
        other.firstname_customer == firstname_customer &&
        other.firstname_repairer == firstname_repairer &&
        other.time == time &&
        other.date == date &&
        other.text_detail == text_detail &&
        other.orderChat == orderChat &&
        other.whoSend == whoSend;
  }

  @override
  int get hashCode {
    return id_customer.hashCode ^
    id_repairer.hashCode ^
    firstname_customer.hashCode ^
    firstname_repairer.hashCode  ^
    time.hashCode ^
    date.hashCode ^
    text_detail.hashCode ^
    orderChat.hashCode ^
    whoSend.hashCode;
  }
}
