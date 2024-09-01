import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:x_o/Computer.dart';
import 'package:x_o/Logic/AI.dart';
import 'package:x_o/Logic/Medium.dart';
import 'package:x_o/Logic/hard.dart';
import 'package:x_o/compnant/TextButton.dart';
import 'package:x_o/compnant/textbutton2.dart';
import 'package:x_o/friend.dart';

class gameLobby extends StatelessWidget {
  const gameLobby({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            // Image
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Container(
                child: Center(child: Image.asset('assets/images/Logo.png')),
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width * 0.7,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Row(
                children: [
                  cusTextButtonm(
                    txt: 'With a Friend :',
                    wgt: gameLobby(),
                    wdth: 0.4,
                    hit: 0.07,
                    mode: 0,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Column(
                    children: [
                      cusTextButton(
                        txt: "Noraml X&O",
                        wgt: wfriend(
                          mode: 6,
                        ),
                        wdth: 0.25,
                        hit: 0.07,
                        mode: 6,
                      ),
                      cusTextButton(
                        txt: "3 X&O",
                        wgt: wfriend(
                          mode: 4,
                        ),
                        wdth: 0.25,
                        hit: 0.07,
                        mode: 4,
                      ),
                      cusTextButton(
                        txt: "4 X&O",
                        wgt: wfriend(
                          mode: 5,
                        ),
                        wdth: 0.25,
                        hit: 0.07,
                        mode: 5,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              cusTextButtonm(
                txt: 'With  Computer :',
                wgt: gameLobby(),
                wdth: 0.4,
                hit: 0.07,
                mode: 0,
              ),
              Row(
                children: [
                  cusTextButton(
                    txt: "Easy",
                    wgt: wComputer(),
                    wdth: 0.25,
                    hit: 0.07,
                    mode: 4,
                  ),
                  cusTextButton(
                    txt: "Medium",
                    wgt: wComputerm(),
                    wdth: 0.25,
                    hit: 0.07,
                    mode: 4,
                  ),
                  cusTextButton(
                    txt: "HARD",
                    wgt: wComputerh(),
                    wdth: 0.25,
                    hit: 0.07,
                    mode: 4,
                  ),
                ],
              ),
              cusTextButtonm(
                txt: 'With  AI :',
                wgt: Ai(),
                wdth: 0.4,
                hit: 0.07,
                mode: 0,
              ),
            ],
            //TwoButton

            //Ratign
            //
          ),
        ),
      ),
    );
  }
}
