class CarsEntity {
  int id;
  String? nome;
  String? tipo;
  String? descricao;
  String? urlFoto;
  String? urlVideo;
  String? latitude;
  String? longitude;

  CarsEntity({
    required this.id,
    this.nome,
    this.tipo,
    this.descricao,
    this.urlFoto,
    this.urlVideo,
    this.latitude,
    this.longitude,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CarsEntity &&
        other.id == id &&
        other.nome == nome &&
        other.tipo == tipo &&
        other.descricao == descricao &&
        other.urlFoto == urlFoto &&
        other.urlVideo == urlVideo &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        tipo.hashCode ^
        descricao.hashCode ^
        urlFoto.hashCode ^
        urlVideo.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}
