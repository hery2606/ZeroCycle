// import 'package:flutter/material.dart';

// class CustomTextField extends StatelessWidget {
//   final String hintText;
//   final IconData icon;
//   final TextInputType keyboardType;
//   final TextEditingController? controller;
//   final bool isPassword;

//   const CustomTextField({
//     Key? key,
//     required this.hintText,
//     required this.icon,
//     this.keyboardType = TextInputType.text,
//     this.controller,
//     this.isPassword = false, // <- tambahkan ini
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       obscureText: isPassword, // <- gunakan di sini
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon),
//         hintText: hintText,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscureText : false,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}
