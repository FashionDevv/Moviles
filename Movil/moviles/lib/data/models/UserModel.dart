class UserModel {
  final int idUsuario;
  final String correo;
  final bool estado;
  final int idRol;

  UserModel({
    required this.idUsuario,
    required this.correo,
    required this.estado,
    required this.idRol,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idUsuario: json['id_usuario'] ?? 0,
      correo: json['correo'] ?? '',
      estado: json['estado'] ?? false,
      idRol: json['id_rol'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_usuario': idUsuario,
      'correo': correo,
      'estado': estado,
      'id_rol': idRol,
    };
  }
}
