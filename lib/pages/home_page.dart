import 'package:flutter/material.dart';
import 'package:otp_input/pages/pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CodeOtpWidget(),
            TextButton(
              onPressed: () {},
              child: const Text('Reenviar codigo'),
            )
          ],
        ),
      ),
    );
  }
}
