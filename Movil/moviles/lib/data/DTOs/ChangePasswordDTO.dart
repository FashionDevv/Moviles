class ChangePasswordDTO {
  final String token;
  final String nuevaClave;

  ChangePasswordDTO({required this.token, required this.nuevaClave});

  Map<String, dynamic> toJson() => {
    'token': token,
    'nueva_clave': nuevaClave,
  };
}
