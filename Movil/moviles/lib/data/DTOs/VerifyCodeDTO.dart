class VerifyCodeDTO {
  final String correo;
  final String codigo;

  VerifyCodeDTO({required this.correo, required this.codigo});

  Map<String, dynamic> toJson() => {
    'correo': correo,
    'codigo': codigo,
  };
}
