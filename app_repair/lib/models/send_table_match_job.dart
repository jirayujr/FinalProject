import 'dart:convert';

class tableMatchJob {
  final String id_customer;
  final String id_repairer;
  final String id_job;
  final String orderMatch;

  tableMatchJob({
    required this.id_customer,
    required this.id_repairer,
    required this.id_job,
    required this.orderMatch,
  });

  tableMatchJob copyWith({
    String? id_customer,
    String? id_repairer,
    String? id_job,
    String? orderMatch,
  }) {
    return tableMatchJob(
      id_customer: id_customer ?? this.id_customer,
      id_repairer: id_repairer ?? this.id_repairer,
      id_job: id_job ?? this.id_job,
      orderMatch: orderMatch ?? this.orderMatch,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_customer': id_customer,
      'id_repairer': id_repairer,
      'id_job': id_job,
      'orderMatch': orderMatch,
    };
  }

  factory tableMatchJob.fromMap(Map<String, dynamic> map) {
    return tableMatchJob(
      id_customer: map['id_customer'] ?? '',
      id_repairer: map['id_repairer'] ?? '',
      id_job: map['id_job'] ?? '',
      orderMatch: map['orderMatch'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory tableMatchJob.fromJson(String source) => tableMatchJob.fromMap(json.decode(source));

  @override
  String toString() {
    return 'tableMatchJob(id_customer: $id_customer, id_repairer: $id_repairer, id_job: $id_job, orderMatch: $orderMatch)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is tableMatchJob &&
        other.id_customer == id_customer &&
        other.id_repairer == id_repairer &&
        other.id_job == id_job &&
        other.orderMatch == orderMatch;
  }

  @override
  int get hashCode {
    return id_customer.hashCode ^
    id_repairer.hashCode ^
    id_job.hashCode ^
    orderMatch.hashCode;
  }
}
