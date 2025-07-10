class LoginDTO {
  final String correo;
  final String clave;

  LoginDTO({required this.correo, required this.clave});

  Map<String, dynamic> toJson() => {
    'correo': correo,
    'clave': clave,
  };
}
