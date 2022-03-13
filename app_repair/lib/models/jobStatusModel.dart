import 'dart:convert';

class jobStatusModel {
  final String id_job;
  final String date_start;
  final String date_end;
  final String 	status_work;
  final String 	orderStart_date;
  final String 	orderEnd_date;
  final String  order_job;



  jobStatusModel({
    required this.id_job,
    required this.date_start,
    required this.date_end,
    required this.status_work,
    required this.orderStart_date,
    required this.orderEnd_date,
    required this.order_job,
  });

  jobStatusModel copyWith({
    String? id_job,
    String? date_start,
    String? date_end,
    String? status_work,
    String? orderStart_date,
    String? orderEnd_date,
    String? order_job,
  }) {
    return jobStatusModel(
      id_job: id_job ?? this.id_job,
      date_start: date_start ?? this.date_start,
      date_end: date_end ?? this.date_end,
      status_work: status_work ?? this.status_work,
      orderStart_date: orderStart_date ?? this.orderStart_date,
      orderEnd_date: orderEnd_date ?? this.orderEnd_date,
      order_job: order_job ?? this.order_job,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_job': id_job,
      'date_start': date_start,
      'date_end': date_end,
      'status_work': status_work,
      'orderStart_date': orderStart_date,
      'orderEnd_date': orderEnd_date,
      'order_job': order_job,
    };
  }

  factory jobStatusModel.fromMap(Map<String, dynamic> map) {
    return jobStatusModel(
      id_job: map['id_job'] ?? '',
      date_start: map['date_start'] ?? '',
      date_end: map['date_end'] ?? '',
      status_work: map['status_work'] ?? '',
      orderStart_date: map['orderStart_date'] ?? '',
      orderEnd_date: map['orderEnd_date'] ?? '',
      order_job: map['order_job'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory jobStatusModel.fromJson(String source) => jobStatusModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'jobStatusModel(id_job: $id_job, date_start: $date_start, date_end: $date_end, status_work: $status_work, orderStart_date: $orderStart_date, orderEnd_date: $orderEnd_date, order_job: $order_job)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is jobStatusModel &&
        other.id_job == id_job &&
        other.date_start == date_start &&
        other.date_end == date_end &&
        other.status_work == status_work &&
        other.orderStart_date == orderStart_date &&
        other.orderEnd_date == orderEnd_date &&
        other.order_job == order_job;
  }

  @override
  int get hashCode {
    return id_job.hashCode ^
    date_start.hashCode ^
    date_end.hashCode ^
    status_work.hashCode  ^
    orderStart_date.hashCode ^
    orderEnd_date.hashCode ^
    order_job.hashCode;
  }
}
