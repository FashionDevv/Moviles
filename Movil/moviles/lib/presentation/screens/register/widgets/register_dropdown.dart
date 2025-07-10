import 'package:flutter/material.dart';

class RegisterDropdown extends StatelessWidget {
  final String label;
  final String? selectedValue;
  final Function(String?) onChanged;

  const RegisterDropdown({
    super.key,
    required this.label,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF18181B),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFC59B2D),
            offset: Offset(0, 2),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color.fromARGB(199, 255, 255, 255),
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 26,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFC59B2D),
                  offset: Offset(0, 2),
                  blurRadius: 3,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedValue,
                onChanged: onChanged,
                isExpanded: true,
                iconEnabledColor: Colors.white,
                dropdownColor: const Color(0xFF2A2A2A),
                style: const TextStyle(color: Colors.white, fontSize: 13),
                hint: const Text(
                  "Seleccione el tipo",
                  style: TextStyle(color: Color(0xFFC59B2D), fontSize: 12.5),
                ),
                items: const [
                  DropdownMenuItem(
                    value: "cc",
                    child: Text("Cédula", style: TextStyle(color: Colors.white, fontSize: 13)),
                  ),
                  DropdownMenuItem(
                    value: "ti",
                    child: Text("Tarjeta de Identidad", style: TextStyle(color: Colors.white, fontSize: 13)),
                  ),
                  DropdownMenuItem(
                    value: "ce",
                    child: Text("Cédula extranjera", style: TextStyle(color: Colors.white, fontSize: 13)),
                  ),
                  DropdownMenuItem(
                    value: "rc",
                    child: Text("Registro Civil", style: TextStyle(color: Colors.white, fontSize: 13)),
                  ),
                  DropdownMenuItem(
                    value: "pp",
                    child: Text("Pasaporte", style: TextStyle(color: Colors.white, fontSize: 13)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
