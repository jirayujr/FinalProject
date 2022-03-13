import 'dart:convert';

class tableFindRepaierer {
  final String type_repairer;
  final String lat;
  final String lng;
  final String status_repairer;
  final String price;
  final String id_repairer;

  tableFindRepaierer({
    required this.type_repairer,
    required this.lat,
    required this.lng,
    required this.status_repairer,
    required this.price,
    required this.id_repairer,
  });

  tableFindRepaierer copyWith({
    String? type_repairer,
    String? lat,
    String? lng,
    String? status_repairer,
    String? price,
    String? id_repairer,
  }) {
    return tableFindRepaierer(
      type_repairer: type_repairer ?? this.type_repairer,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      status_repairer: status_repairer ?? this.status_repairer,
      price: lat ?? this.price,
      id_repairer: lng ?? this.id_repairer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type_repairer': type_repairer,
      'lat': lat,
      'lng': lng,
      'status_repairer': status_repairer,
      'price': price,
      'id_repairer': id_repairer,
    };
  }

  factory tableFindRepaierer.fromMap(Map<String, dynamic> map) {
    return tableFindRepaierer(
      type_repairer: map['type_repairer'] ?? '',
      lat: map['lat'] ?? '',
      lng: map['lng'] ?? '',
      status_repairer: map['status_repairer'] ?? '',
      price: map['price'] ?? '',
      id_repairer: map['id_repairer'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory tableFindRepaierer.fromJson(String source) => tableFindRepaierer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'tableFindRepaierer(type_repairer: $type_repairer, lat: $lat, lng: $lng, status_repairer: $status_repairer,price: $price,id_repairer: $id_repairer)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is tableFindRepaierer &&
        other.type_repairer == type_repairer &&
        other.lat == lat &&
        other.lng == lng &&
        other.status_repairer == status_repairer &&
        other.price == price &&
        other.id_repairer == id_repairer;
  }

  @override
  int get hashCode {
    return type_repairer.hashCode ^
    lat.hashCode ^
    lng.hashCode ^
    status_repairer.hashCode ^
    price.hashCode ^
    id_repairer.hashCode ;
  }
}
