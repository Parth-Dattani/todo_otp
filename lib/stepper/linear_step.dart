import 'dart:async';

import 'package:flutter/material.dart';
import 'package:linear_step_indicator/linear_step_indicator.dart';
import 'package:steps_indicator/steps_indicator.dart';

class LinearStep extends StatefulWidget {
  const LinearStep({Key? key}) : super(key: key);

  @override
  State<LinearStep> createState() => _LinearStepState();
}

class _LinearStepState extends State<LinearStep> {

  final PageController pageController = PageController();
  final step = 3;
  double value = 0;
  int initialPage = 0;
  int selectedStep = 0;
  int nbSteps = 5;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
        Timer.periodic(
          const Duration(milliseconds: 350),
              (_) {
            if (mounted) {
              initialPage += 1;
              if (initialPage == step - 1) {
              } else {
                pageController.jumpToPage(initialPage);
              }
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Linear Stepper", style: TextStyle(fontWeight: FontWeight.w500),),),
      body: Column(
        children:  [
          const LinearProgressIndicator(
            backgroundColor: Colors.redAccent,
            valueColor: AlwaysStoppedAnimation(Colors.green),
            minHeight: 25,
          ),
          const Text("Please follow the all steps ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
          const LinearProgressIndicator(
            backgroundColor: Colors.redAccent,
            valueColor: AlwaysStoppedAnimation(Colors.green),
            minHeight: 25,
          ),

          const Text("Determinate Indicator",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
          Container(
            margin: const EdgeInsets.all(10),
            child: LinearProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
              color: Colors.red,
              minHeight: 15,
              value: value,
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: ElevatedButton(
              child: Text("Start"),
              style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Colors.blueGrey
              ),
              onPressed: ()
              {
                value = 0;
                determinateIndicator();
                setState(() {
                });
              },
            ),
          ),

          FullLinearStepIndicator(
            verticalPadding: 111,
              steps: step,
              controller: pageController,
            activeLineColor: Colors.red,
            inActiveLineColor: Colors.grey,
            completedIcon: Icons.done_all,
            activeNodeColor: Colors.green,
            inActiveNodeColor: Colors.black,
            labels: List<String>.generate(step, (index) => 'Steps:  ${index+1}'),
            complete:  (){
              return Future.value(true);
            },
          ),

          SizedBox(height: 20,),

          //Steps Indicator
          StepsIndicator(
            selectedStep: selectedStep,
            nbSteps: nbSteps,
            doneLineColor: Colors.green,
            doneStepColor: Colors.green,
            undoneLineColor: Colors.red,
            lineLength: 10,
            lineLengthCustomStep: [
              StepsIndicatorCustomLine(nbStep: 4, length: 105)
            ],
            enableLineAnimation: true,
            enableStepAnimation: true,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                color: Colors.red,
                onPressed: () {
                  if(selectedStep > 0) {
                    setState(() {
                      selectedStep--;
                    });
                  }
                },
                child: const Text('Prev'),
              ),
              MaterialButton(
                color: Colors.green,
                onPressed: () {
                  if(selectedStep < nbSteps) {
                    setState(() {
                      selectedStep++;
                    });
                  }
                },
                child: const Text('Next'),
              )
            ],
          )

        ],
      ),
    );
  }
  void determinateIndicator(){
     Timer.periodic(
        const Duration(seconds: 6),
            (Timer timer){
          setState(() {
            if(value == 1) {
              timer.cancel();
            }
            else {
              value = value + 0.1;
            }
          });
        }
    );
  }
}
