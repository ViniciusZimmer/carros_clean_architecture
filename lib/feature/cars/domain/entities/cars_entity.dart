class CarsEntity {
  final int id;
  final String? name;
  final String? type;
  final String? description;
  final String? photoUrl;

  CarsEntity(
      {required this.id,
      required this.name,
      required this.description,
      required this.type,
      required this.photoUrl});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CarsEntity &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.type == type &&
        other.photoUrl == photoUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        type.hashCode ^
        photoUrl.hashCode;
  }
}
