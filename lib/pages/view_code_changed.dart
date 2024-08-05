import 'package:flutter/material.dart';
import 'package:otp_input/pages/home_page.dart';

class ViewCodeChanged extends StatelessWidget {
  final String code;
  const ViewCodeChanged({
    super.key,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              )),
        ),
      ),
      body: Center(
        child: Text(
          code,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
