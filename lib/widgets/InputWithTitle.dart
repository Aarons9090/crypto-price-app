import 'package:flutter/material.dart';
import '../main.dart';

class InputWithTitle extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  const InputWithTitle(this.controller, this.title, {Key? key})
      : super(key: key);

  OutlineInputBorder get inputBorder => OutlineInputBorder(
      borderSide: BorderSide(color: AppColors().pink),
      borderRadius: const BorderRadius.all(Radius.circular(7)));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 30, 10),
      child: Wrap(
        children: [
          Text(title, style: const TextStyle(color: Colors.white)),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            height: 40,
            child: TextField(
              style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white70),
              textAlignVertical: const TextAlignVertical(y:-0.8),
              onTap: (){
                controller.text = "";
              },
              decoration: InputDecoration(
                focusedBorder: inputBorder,
                enabledBorder: inputBorder,
              ),
              controller: controller,
            ),
          )
        ],
      ),
    );
  }
}
