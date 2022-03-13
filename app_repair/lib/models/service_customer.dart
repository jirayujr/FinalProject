import 'dart:convert';

class ServiceCustomer {
  final String id;
  final String date1;
  final String time1;
  final String typeRepairer;
  final String identifySymptoms;
  final String image;
  final String address1;
  final String lat;
  final String lng;
  final String order_fix;
  final String id_job;
  final String dateMeet;
  final String timeMeet;
  ServiceCustomer({
    required this.id,
    required this.date1,
    required this.time1,
    required this.typeRepairer,
    required this.identifySymptoms,
    required this.image,
    required this.address1,
    required this.lat,
    required this.lng,
    required this.order_fix,
    required this.id_job,
    required this.dateMeet,
    required this.timeMeet,
  });

  ServiceCustomer copyWith({
    String? id,
    String? date1,
    String? time1,
    String? typeRepairer,
    String? identifySymptoms,
    String? image,
    String? address1,
    String? lat,
    String? lng,
    String? order_fix,
    String? id_job,
    String? dateMeet,
    String? timeMeet,
  }) {
    return ServiceCustomer(
      id: id ?? this.id,
      date1: date1 ?? this.date1,
      time1: time1 ?? this.time1,
      typeRepairer: typeRepairer ?? this.typeRepairer,
      identifySymptoms: identifySymptoms ?? this.identifySymptoms,
      image: image ?? this.image,
      address1: address1 ?? this.address1,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      order_fix: order_fix ?? this.order_fix,
      id_job: id_job ?? this.id_job,
      dateMeet: dateMeet ?? this.dateMeet,
      timeMeet: timeMeet ?? this.timeMeet,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date1': date1,
      'time1': time1,
      'typeRepairer': typeRepairer,
      'identifySymptoms': identifySymptoms,
      'image': image,
      'address1': address1,
      'lat': lat,
      'lng': lng,
      'order_fix': order_fix,
      'id_job':id_job,
      'dateMeet':dateMeet,
      'timeMeet':timeMeet,
    };
  }

  factory ServiceCustomer.fromMap(Map<String, dynamic> map) {
    return ServiceCustomer(
      id: map['id'] ?? '',
      date1: map['date1'] ?? '',
      time1: map['time1'] ?? '',
      typeRepairer: map['typeRepairer'] ?? '',
      identifySymptoms: map['identifySymptoms'] ?? '',
      image: map['image'] ?? '',
      address1: map['address1'] ?? '',
      lat: map['lat'] ?? '',
      lng: map['lng'] ?? '',
      order_fix: map['order_fix'] ?? '',
      id_job: map['id_job'] ?? '',
      dateMeet: map['dateMeet'] ?? '',
      timeMeet: map['timeMeet'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceCustomer.fromJson(String source) => ServiceCustomer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ServiceCustomer(id: $id, date1: $date1, time1: $time1, typeRepairer: $typeRepairer, identifySymptoms: $identifySymptoms, image: $image, address1: $address1, lat: $lat, lng: $lng, order_fix:$order_fix,id_job:$id_job,dateMeet:$dateMeet,timeMeet:$timeMeet)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ServiceCustomer &&
      other.id == id &&
      other.date1 == date1 &&
      other.time1 == time1 &&
      other.typeRepairer == typeRepairer &&
      other.identifySymptoms == identifySymptoms &&
      other.image == image &&
      other.address1 == address1 &&
      other.lat == lat &&
      other.lng == lng &&
      other.order_fix == order_fix &&
      other.id_job == id_job &&
      other.dateMeet == dateMeet &&
      other.timeMeet == timeMeet;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      date1.hashCode ^
      time1.hashCode ^
      typeRepairer.hashCode ^
      identifySymptoms.hashCode ^
      image.hashCode ^
      address1.hashCode ^
      lat.hashCode ^
      lng.hashCode ^
      order_fix.hashCode ^
      id_job.hashCode ^
      dateMeet.hashCode ^
      timeMeet.hashCode;
  }
}
