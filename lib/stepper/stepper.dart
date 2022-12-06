import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';

import '../syncfusion_chart/bar_chart.dart';

class StepperDemo extends StatefulWidget {
  const StepperDemo({super.key});

  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {

  int currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  TextEditingController userController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();

  List<Step> stepList() => [
        Step(
          title:  Text('User'),
          content: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Enter Your Name'),
                controller: userController,
              ),
            ],
          ),
          isActive: currentStep >= 0,
          state: currentStep >= 0 ? StepState.complete : StepState.editing,
        ),
        Step(
          title: const Text('Address'),
          content: Column(
            children: <Widget>[
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Enter Address'),
              ),
              TextFormField(
                controller: stateController,
                decoration: InputDecoration(labelText: 'State'),
              ),
              TextFormField(
                controller: pinCodeController,
                decoration: InputDecoration(labelText: 'PinCode'),
              ),
            ],
          ),
          isActive: currentStep >= 1,
          state: currentStep >= 1 ? StepState.complete : StepState.editing,
        ),
        Step(
          title: Text('Mobile Number'),
          content: Column(
            children: <Widget>[
              TextFormField(
                controller: mobileController,
                decoration: InputDecoration(labelText: 'Mobile Number'),
              ),
            ],
          ),
          isActive: currentStep >= 2,
          state: currentStep >= 2 ? StepState.complete : StepState.editing,
        ),
        Step(
          title: const Text('Confirm'),
          content: Container(
            width: Get.width,
            decoration:
                const BoxDecoration(shape: BoxShape.rectangle, color: Colors.cyan),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(

                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const[
                      Text(
                        "😎",
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        "Your Details : ",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.red,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "😎",
                        style: TextStyle(fontSize: 25),
                      )
                    ],
                  ),
                  // Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly, children: [Text("User Name : "),Text(userController.text)],),
                  // Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children: [Text("Address : "),Text(addressController.text)],),
                  // Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children: [Text("State : "),Text(stateController.text)],),
                  // Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children: [Text("PinCode : "),Text(pinCodeController.text)],),
                  // Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children: [Text("Mobile : "),Text(mobileController.text)],),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    dataList("User Name : ", userController.text),
                    dataList("Address : ", addressController.text),
                    dataList("State : ", stateController.text),
                    dataList("PinCode : ",pinCodeController.text),
                    dataList("Mobile : ",mobileController.text),
                  ]),

                ],
              ),
            ),
          ),
          isActive: currentStep >= 3,
          state: StepState.complete,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Stepper Demo'),
      ),
      body:

      Column(
        children: [
         Expanded(
           child: Stepper(
                type: stepperType,
                physics: const ScrollPhysics(),
                currentStep: currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue: continued,
                onStepCancel: cancel,
                steps: stepList(),
                /*<Step>[
                  Step(
                    title: const Text('User'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration:  InputDecoration(labelText: 'Enter Your Name'),
                        ),
                      ],
                    ),
                    isActive: currentStep >= 0,
                    state: currentStep >= 0 ?
                    StepState.complete : StepState.disabled,
                  ),
                  Step(
                    title:  Text('Address'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Enter Address'),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'State'),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'PinCode'),
                        ),
                      ],
                    ),
                    isActive: currentStep >= 0,
                    state: currentStep >= 1 ?
                    StepState.complete : StepState.disabled,
                  ),
                  Step(
                    title: Text('Mobile Number'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Mobile Number'),
                        ),
                      ],
                    ),
                    isActive:currentStep >= 0,
                    state: currentStep >= 2 ?
                    StepState.complete : StepState.disabled,
                  ),
                ],*/
              ),
         ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: switchStepsType,
        child: const Icon(Icons.list),
      ),
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => currentStep = step);
  }

  continued() {
    currentStep < stepList().length - 1
        ? setState(() {
            currentStep += 1;
          })
        : currentStep == 3
            ? showDialog(
                context: context,
                builder: (context) {
                  Future.delayed(const Duration(seconds: 6), () {
                    Navigator.of(context).pop(true);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BarChart(),
                        ));
                  });
                  return Column(
                    children: [
                      AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        title: Center(
                            child: Column(
                          children: const [
                            CircularProgressIndicator(),
                            SizedBox(
                              height: 15,
                            ),
                            Text('Process Complete'),
                          ],
                        )),
                      ),
                      // Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      //   const BarChart(),
                      //
                      // ))
                    ],
                  );
                })
            : null;
  }

  cancel() {
    currentStep > 0 ? setState(() => currentStep -= 1) : null;
  }

  Widget dataList(title, data) {
    return Padding(
      padding: const EdgeInsets.only(left: 85.0, top: 10, bottom: 4),
      child: Row(
       // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(title,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 14,
                    color: Color(0XFF454545),
                    )),
          ),
          Expanded(
            child: Text(
              data,
              //textDirection: TextDirection.ltr,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontSize: 15,
                  color: Color(0XFF121212),
                 ),
            ),
          ),
        ],
      ),
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../syncfusion_chart/bar_chart.dart';

class StepperDemo extends StatefulWidget {
  const StepperDemo({super.key});

  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  int currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Stepper Demo'),

      ),
      body:  Column(
        children: [
          Expanded(
            child: Stepper(
              type: stepperType,
              physics: const ScrollPhysics(),
              currentStep: currentStep,
              onStepTapped: (step) => tapped(step),
              onStepContinue:  continued,

              onStepCancel:  cancel,
              steps: <Step>[
                Step(
                  title: const Text('User'),
                  content: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration:  InputDecoration(labelText: 'Enter Your Name'),
                      ),
                    ],
                  ),
                  isActive: currentStep >= 0,
                  state: currentStep >= 0 ?
                  StepState.complete : StepState.disabled,
                ),
                Step(
                  title:  Text('Address'),
                  content: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Enter Address'),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'State'),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'PinCode'),
                      ),
                    ],
                  ),
                  isActive: currentStep >= 0,
                  state: currentStep >= 1 ?
                  StepState.complete : StepState.disabled,
                ),
                Step(
                  title: Text('Mobile Number'),
                  content: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Mobile Number'),
                      ),
                    ],
                  ),
                  isActive:currentStep >= 0,
                  state: currentStep >= 2 ?
                  StepState.complete : StepState.disabled,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: switchStepsType,
        child: const Icon(Icons.list),
      ),

    );
  }
  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step){
    setState(() => currentStep = step);
  }

  continued(){
    currentStep < 2 ?
    setState(() { currentStep += 1;

    }): currentStep == 2 ?

    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 6), () {
            Navigator.of(context).pop(true);
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
              const BarChart(),

            ));
          });
          return Column(
            children: [
              AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                title: Center(child: Column(
                  children: const [
                    CircularProgressIndicator(),
                                   SizedBox(height: 15,),
                    Text('Process Complete'),

                  ],
                )),
              ),
              // Navigator.push(context, MaterialPageRoute(builder: (context) =>
              //   const BarChart(),
              //
              // ))
            ],
          );
        })

    // Navigator.push(context, MaterialPageRoute(builder: (context) =>
    //   const BarChart(),
    //
    // ))
        : null;

  }
  cancel(){
    currentStep > 0 ?
    setState(() => currentStep -= 1) : null;
  }
}
*/
