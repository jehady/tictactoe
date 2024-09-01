import 'package:flutter/material.dart';
import 'package:get/get.dart';

class cusTextButton extends StatelessWidget {
  cusTextButton(
      {super.key,
      required this.txt,
      required this.wgt,
      required this.wdth,
      required this.hit,
      required this.mode});
  late String txt;
  late Widget wgt;
  late double wdth;
  late double hit;
  late int mode;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Get.to(wgt);
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(273),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.green,
                Colors.black,
                Colors.red,
              ],
            ),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * hit,
            width: MediaQuery.of(context).size.width * wdth,
            child: Center(
                child: Text(
              '$txt',
              style: TextStyle(color: Colors.white),
            )),
          ),
        ));
  }
}
