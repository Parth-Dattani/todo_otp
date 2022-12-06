

// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:todo_otp/home_screen.dart';
import 'package:todo_otp/sign.dart';


  // Date_picker(BuildContext context) async {
  //   final DateTime? selected = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime.now().subtract(Duration(days: 0)),
  //     lastDate: DateTime(2050),
  //
  //     //selectableDayPredicate: (DateTime val) => val.day == DateTime.now().day-1  ? false : true,
  //
  //   );
  //   if (selected != null && selected != selectedDate)
  //     setState(() {
  //       selectedDate = selected;
  //     });
  // }


class AddNote extends StatefulWidget {

  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();


  CollectionReference ref = FirebaseFirestore.instance.collection('myNote');

  DateTime selectedDate = DateTime.now();
  int id = 0;

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
    exportPenColor: Colors.black,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print('Value changed'));
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) =>  const HomeScreen()));
            }),
        actions: [
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Sign(),));
          }, child: const Text("Save", style: TextStyle(color: Colors.white),))
        ],
        title: const Text('Add Note'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                TextField(
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  controller: title,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  style:  const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  controller: content,
                  // expands: true,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),



                const Text("Add your Signature", style: TextStyle(fontSize: 20),),

                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: Signature(
                          controller: SignatureController(
                            penStrokeWidth: 5,
                            penColor: Colors.blue,
                            exportBackgroundColor: Colors.blue,
                          ),
                          height: 100,
                          backgroundColor: Colors.grey[300]!,
                        ))
                  ],
                ),
                Container(
                  decoration: const BoxDecoration(color: Colors.black),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.check),
                        color: Colors.blue,
                        onPressed: () async {
                          if (_controller.isNotEmpty) {
                            final Uint8List? data =
                            await _controller.toPngBytes();
                            if (data != null) {
                              await Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) {
                                    return
                                      Scaffold(
                                      appBar: AppBar(),
                                      body: Center(
                                        child: Container(
                                          color: Colors.grey[300],
                                          child: Image.memory(data),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          }
                        },
                      ),
                      /*IconButton(
                        icon: const Icon(Icons.undo),
                        color: Colors.blue,
                        onPressed: () {
                          setState(() => _controller.undo());
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.redo),
                        color: Colors.blue,
                        onPressed: () {
                          setState(() => _controller.redo());
                        },
                      ),*/
                      //CLEAR CANVAS
                      IconButton(
                        icon: const Icon(Icons.clear),
                        color: Colors.blue,
                        onPressed: () {
                          setState(() => _controller.clear());
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 50,
                ),
                MaterialButton(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  elevation: 5.0,
                  // height: 50,
                  height: MediaQuery.of(context).size.height * 0.08,
                  minWidth: double.infinity,
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                        context: context, builder: (_){
                      return Dialog(
                        // The background color
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              CircularProgressIndicator(),
                              SizedBox(
                                height: 15,
                              ),
                              Text('Saving...')
                            ],
                          ),
                        ),
                      );
                    });
                     // userRef = db.collection('documents').doc('document_id');
                     // increment = firebase.firestore.FieldValue.increment(1);
                    ref.add({
                      'id': id+1,
                      'title': title.text,
                      'content': content.text,
                      'date' : selectedDate.toString(),
                    }).whenComplete(() {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()));
                    });
                  },
                  color: Colors.blue,
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

