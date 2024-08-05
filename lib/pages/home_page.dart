import 'package:flutter/material.dart';

import 'package:otp_input/pages/pages.dart';
import 'package:otp_input/pages/view_code_changed.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String codeValue = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CodeOtpWidget(
              onChanged: (value) {
                setState(() {
                  codeValue = value;
                });
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewCodeChanged(
                      code: codeValue,
                    ),
                  ),
                );
              },
              child: const Text('Visualizar código'),
            )
          ],
        ),
      ),
    );
  }
}
