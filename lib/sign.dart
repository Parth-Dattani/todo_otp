// ignore_for_file: avoid_print



import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class Sign extends StatefulWidget {
  const Sign({Key? key}) : super(key: key);

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  final SignatureController controller = SignatureController(
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
    controller.addListener(() => print('Value changed'));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: false,
          pinned: true,
          snap: false,
          centerTitle: false,

         // title: Text('Kindacode.com'),
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.shopping_cart),
          //     onPressed: () {},
          //   ),
          // ],
          bottom: AppBar(
            leading: const Icon(Icons.bluetooth_connected_sharp, color: Colors.blue,),
            title: Container(

              width: double.infinity,
              height: 40,
              color: Colors.white,
              child: const Center(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Search for something',
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.camera_alt)),
                ),
              ),
            ),
          ),
        ),
        // Other Sliver Widgets
        SliverList(
          delegate: SliverChildListDelegate([
            const SizedBox(
              height: 400,
              child: Center(
                child: Text(
                  'This is an awesome shopping platform',style: TextStyle(decoration: TextDecoration.none),
                ),
              ),
            ),
            Container(
              height: 1000,
              color: Colors.pink,
            ),
          ]),
        ),
      ],
    );

    /*SafeArea(
        child: Scaffold(

              body: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(child: Text("Citizen Signature")),
                      Flexible(
                          flex: 2,
                          child: Signature(
                            controller: SignatureController(
                              penStrokeWidth: 5,
                              penColor: Colors.black,
                              exportBackgroundColor: Colors.blue,
                            ),
                            height: 300,
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
                        //SHOW EXPORTED IMAGE IN NEW ROUTE
                        IconButton(
                          icon: const Icon(Icons.check),
                          color: Colors.blue,
                          onPressed: () async {
                            if (controller.isNotEmpty) {
                              final Uint8List? data =
                              await controller.toPngBytes();
                              if (data != null) {
                                await Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) {
                                      return Scaffold(
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
                        IconButton(
                          icon: const Icon(Icons.undo),
                          color: Colors.blue,
                          onPressed: () {
                            setState(() => controller.undo());
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.redo),
                          color: Colors.blue,
                          onPressed: () {
                            setState(() => controller.redo());
                          },
                        ),
                        //CLEAR CANVAS
                        IconButton(
                          icon: const Icon(Icons.clear),
                          color: Colors.blue,
                          onPressed: () {
                            setState(() => controller.clear());
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
        ),
      ),*/
  }
}
