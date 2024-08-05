import 'package:flutter/material.dart';

import 'package:otp_input/pages/view_code_changed.dart';

import 'pages.dart';

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
        child: Container(
          constraints: const BoxConstraints(maxWidth: 354),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CodeOtpWidget(
                showCursor: true,
                otpLength: 6,
                onChanged: (value) {
                  setState(
                    () {
                      codeValue = value;
                    },
                  );
                },
              ),
              const SizedBox(height: 50),
              TextButton(
                onPressed: () {
                  codeValue.isEmpty
                      ? null
                      : Navigator.push(
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
      ),
    );
  }
}
