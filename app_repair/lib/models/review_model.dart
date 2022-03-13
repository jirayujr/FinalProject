import 'dart:convert';

class ReviewModel {
  final String id_repairer;
  final String id_customer;
  final String score_star;
  final String text_recommend;
  final String order_person;
  final String id_job;
  final String status_review;

  ReviewModel({
    required this.id_repairer,
    required this.id_customer,
    required this.score_star,
    required this.text_recommend,
    required this.order_person,
    required this.id_job,
    required this.status_review,
  });

  ReviewModel copyWith({
    String? id_repairer,
    String? id_customer,
    String? score_star,
    String? text_recommend,
    String? order_person,
    String? id_job,
    String? status_review,
  }) {
    return ReviewModel(
      id_repairer: id_repairer ?? this.id_repairer,
      id_customer: id_customer ?? this.id_customer,
      score_star: score_star ?? this.score_star,
      text_recommend: text_recommend ?? this.text_recommend,
      order_person: order_person ?? this.order_person,
      id_job: id_job ?? this.id_job,
      status_review: status_review ?? this.status_review,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_repairer': id_repairer,
      'id_customer': id_customer,
      'score_star': score_star,
      'text_recommend': text_recommend,
      'order_person': order_person,

      'id_job': id_job,
      'status_review': status_review,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      id_repairer: map['id_repairer'] ?? '',
      id_customer: map['id_customer'] ?? '',
      score_star: map['score_star'] ?? '',
      text_recommend: map['text_recommend'] ?? '',
      order_person: map['order_person'] ?? '',
      id_job: map['id_job'] ?? '',
      status_review: map['status_review'] ?? '',

    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) => ReviewModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id_repairer: $id_repairer, id_customer: $id_customer, score_star: $score_star, text_recommend: $text_recommend, order_person: $order_person, id_job: $id_job, status_review: $status_review)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReviewModel &&
        other.id_repairer == id_repairer &&
        other.id_customer == id_customer &&
        other.score_star == score_star &&
        other.text_recommend == text_recommend &&
        other.order_person == order_person &&
        other.id_job == id_job &&
        other.status_review == status_review ;
  }

  @override
  int get hashCode {
    return id_repairer.hashCode ^
    id_customer.hashCode ^
    score_star.hashCode ^
    text_recommend.hashCode ^
    order_person.hashCode ^
    id_job.hashCode ^
    status_review.hashCode ;

  }
}
