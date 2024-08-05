import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CodeOtpWidget extends StatefulWidget {
  final void Function(String) onChanged;
  final int otpLength;

  const CodeOtpWidget({
    super.key,
    required this.onChanged,
    required this.otpLength,
  });

  @override
  CodeOtpWidgetState createState() => CodeOtpWidgetState();
}

class CodeOtpWidgetState extends State<CodeOtpWidget> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.requestFocus();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0,
              child: TextFormField(
                onChanged: widget.onChanged,
                controller: _controller,
                focusNode: _focusNode,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(widget.otpLength),
                ],
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.transparent,
                  focusColor: Colors.transparent,
                ),
                cursorColor: Colors.transparent,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.otpLength, (index) {
              return Container(
                width: 50,
                height: 55,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: index == _controller.selection.baseOffset
                        ? (_focusNode.hasFocus ? Colors.green : Colors.black)
                        : Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  index < _controller.text.length
                      ? _controller.text[index]
                      : '',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
          ),
          Positioned(
            top: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.otpLength, (index) {
                return Container(
                  width: 50,
                  height: 55,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    index < _controller.text.length ? '' : '0',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.grey,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
