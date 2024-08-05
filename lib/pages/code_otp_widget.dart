import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CodeOtpWidget extends StatefulWidget {
  final void Function(String) onChanged;

  final int otpLength;
  final bool showCursor;
  final String? hintText;
  final String? Function(String?)? validator;
  const CodeOtpWidget({
    super.key,
    required this.onChanged,
    required this.otpLength,
    this.showCursor = true,
    this.hintText,
    this.validator,
  });

  @override
  CodeOtpWidgetState createState() => CodeOtpWidgetState();
}

class CodeOtpWidgetState extends State<CodeOtpWidget>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late final AnimationController _cursorController;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
    _controller.addListener(() {
      setState(() {});
    });

    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _cursorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const height = 48.0;
    const width = 44.0;
    const radius = 5.0;
    const fontSize = 17.0;

    return GestureDetector(
        onTap: _focusNode.requestFocus,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: Opacity(
                    opacity: 0,
                    child: TextFormField(
                      onChanged: widget.onChanged,
                      style: const TextStyle(fontSize: fontSize),
                      controller: _controller,
                      focusNode: _focusNode,
                      validator: widget.validator,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(widget.otpLength),
                      ],
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        border: InputBorder.none,
                        fillColor: Colors.transparent,
                        focusColor: Colors.transparent,
                      ),
                      cursorColor: Colors.transparent,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(widget.otpLength, (index) {
                    return Container(
                      width: width,
                      height: height,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: index == _controller.selection.baseOffset
                              ? (_focusNode.hasFocus
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.black)
                              : Colors.black,
                          width: index == _controller.selection.baseOffset &&
                                  _focusNode.hasFocus
                              ? 2
                              : 1,
                        ),
                        borderRadius: BorderRadius.circular(radius),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            index < _controller.text.length
                                ? _controller.text[index]
                                : '',
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          if (widget.showCursor &&
                              _focusNode.hasFocus &&
                              index == _controller.selection.baseOffset)
                            AnimatedBuilder(
                              animation: _cursorController,
                              builder: (context, child) {
                                return Opacity(
                                  opacity: _cursorController.value,
                                  child: Container(
                                    width: 2,
                                    height: 20,
                                    color: Colors.black,
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    );
                  }),
                ),
                if (widget.hintText != null)
                  Positioned(
                    top: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        widget.otpLength,
                        (index) {
                          return Container(
                            width: width,
                            height: height,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              index < _controller.text.length
                                  ? ''
                                  : widget.hintText!,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ));
  }
}
