class RequestResetDTO {
  final String correo;

  RequestResetDTO({required this.correo});

  Map<String, dynamic> toJson() => {
    'correo': correo,
  };
}
