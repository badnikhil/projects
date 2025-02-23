import 'package:flutter/material.dart';

class PassField extends StatelessWidget {
  
  PassField({super.key});

  final ValueNotifier<bool> toHide = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: toHide,
      builder: (context, isHidden, child) {
        return Container( 
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: TextField(
            obscureText: isHidden,
            decoration: InputDecoration(
             
              suffixIcon: IconButton(
                onPressed: () {
                  toHide.value = !toHide.value;
                },
                icon: Icon(isHidden ? Icons.visibility_off : Icons.visibility),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.green),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Color.fromARGB(255, 224, 223, 223), width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.green, width: 2.5),
              ),
            ),
          ),
        );
      },
    );
  }
}
