import 'dart:convert';

class give_fix2_Model {
  final String id;
  final String 	date1;
  final String time1;
  final String 	typeRepairer;
  final String 	identifySymptoms;
  final String 	address1;
  final String  image;

  final String 	lat;
  final String 	lng;
  final String 	order_fix;
  final String 	id_job;
  final String 	dateMeet;
  final String  timeMeet;



  give_fix2_Model({
    required this.id,
    required this.date1,
    required this.time1,
    required this.typeRepairer,
    required this.identifySymptoms,
    required this.address1,
    required this.image,

    required this.lat,
    required this.lng,
    required this.order_fix,
    required this.id_job,
    required this.dateMeet,
    required this.timeMeet,
  });

  give_fix2_Model copyWith({
    String? id,
    String? date1,
    String? time1,
    String? typeRepairer,
    String? identifySymptoms,
    String? address1,
    String? image,

    String? lat,
    String? lng,
    String? order_fix,
    String? id_job,
    String? dateMeet,
    String? timeMeet,

  }) {
    return give_fix2_Model(
      id: id ?? this.id,
      date1: date1 ?? this.date1,
      time1: time1 ?? this.time1,
      typeRepairer: typeRepairer ?? this.typeRepairer,
      identifySymptoms: identifySymptoms ?? this.identifySymptoms,
      address1: address1 ?? this.address1,
      image: image ?? this.image,

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
      'address1': address1,
      'image': image,

      'lat': lat,
      'lng': lng,
      'order_fix': order_fix,
      'id_job': id_job,
      'dateMeet': dateMeet,
      'timeMeet': timeMeet,
    };
  }

  factory give_fix2_Model.fromMap(Map<String, dynamic> map) {
    return give_fix2_Model(
      id: map['id'] ?? '',
      date1: map['date1'] ?? '',
      time1: map['time1'] ?? '',
      typeRepairer: map['typeRepairer'] ?? '',
      identifySymptoms: map['identifySymptoms'] ?? '',
      address1: map['address1'] ?? '',
      image: map['image'] ?? '',

      lat: map['lat'] ?? '',
      lng: map['lng'] ?? '',
      order_fix: map['order_fix'] ?? '',
      id_job: map['id_job'] ?? '',
      dateMeet: map['dateMeet'] ?? '',
      timeMeet: map['timeMeet'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory give_fix2_Model.fromJson(String source) => give_fix2_Model.fromMap(json.decode(source));

  @override
  String toString() {
    return 'give_fix2_Model(id: $id, date1: $date1, time1: $time1'
        ', typeRepairer: $typeRepairer, identifySymptoms: $identifySymptoms, address1: $address1,'
        ' image: $image,lat: $lat, lng: $lng, order_fix: $order_fix,'
        'id_job: $id_job,dateMeet: $dateMeet, timeMeet: $timeMeet)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is give_fix2_Model &&
        other.id == id &&
        other.date1 == date1 &&
        other.time1 == time1 &&
        other.typeRepairer == typeRepairer &&
        other.identifySymptoms == identifySymptoms &&
        other.address1 == address1 &&
        other.image == image &&

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
    typeRepairer.hashCode  ^
    identifySymptoms.hashCode ^
    address1.hashCode ^
    image.hashCode^

    lat.hashCode ^
    lng.hashCode ^
    order_fix.hashCode  ^
    id_job.hashCode ^
    dateMeet.hashCode ^
    timeMeet.hashCode;
  }
}
