

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:todo_otp/add_note.dart';
import 'package:todo_otp/edit_note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var mTask = [];
  var mSearchTask = [];
  TextEditingController searchController = TextEditingController();

  /*@override
  void initState() {
    super.initState();

    FirebaseFirestore sd = FirebaseFirestore.instance.collection('myNote');
    handler.initDB().whenComplete(() async {
      setState(() {
        task = getAllTask();
        _onRefresh();

        ///create list
        getAllTask().then((value) {
          mTask = value;
          mSearchTask.sort((a, b) => a.title.compareTo(b.title));
          mSearchTask.sort((a, b) => a.date.compareTo(b.date));
        });
      });
    });
  }*/


  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('myNote').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const AddNote()));
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: const Text('Todo App'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => const AddNote()));
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError || snapshot.data == null) {
            return const Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasData){
          return
            SingleChildScrollView(
              child: Column(
            children: [
              /*Container(
                    width: double.infinity,
                    height: 40,
                    color: Colors.white,
                    child:const Center(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Search for something',
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: Icon(Icons.camera_alt)),
                      ),
                    ),
                  ),*/
              Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: <Widget>[
                    Container(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: 70.0,
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                      const Icon(Icons.search),
                                      SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width -
                                            100.0,
                                    child: TextField(
                                      controller: searchController,
                                      decoration: const InputDecoration(
                                        hintText: 'Search',
                                      ),
                                      autofocus: true,

                                      onChanged: (data){
                                        mSearchTask.clear();
                                        var searchString = searchController.text;
                                        mTask.forEach((element) {
                                          if(element.title.contains(
                                            searchString)){
                                           mSearchTask.add(element);
                                          }
                                          if(element.data.contains(searchString)){
                                            mSearchTask.add(element);
                                          }
                                        });
                                        mSearchTask.sort((a, b) => a.title.compareTo(b.title));
                                        mSearchTask.sort((a, b) =>a.date.compareTo(b.date));

                                        setState((){});
                                      },

                                      /*onChanged: (data) {
                                                    mSearchTask.clear();
                                                    var searchString =
                                                        searchController.text;
                                                    mTask.forEach((element) {
                                                      if (element.title
                                                          .contains(
                                                          searchString)) {
                                                        mSearchTask
                                                            .add(element);

                                                        //someObjects.sort((a, b) => a.someProperty.compareTo(b.someProperty));
                                                        // mSearchTask.sort((a, b) => a[task.ti].compareTo(b["title"]));
                                                        // print('Low to hight in price: $myProducts');
                                                        // mSearchTask.sort((a, b) => a.toString().compareTo(b.toString()));
                                                        //mSearchTask.sort();
                                                        print(
                                                            'Ascending order (A to Z): ');
                                                        print(
                                                            'Descending order (Z to A): $mSearchTask.reversed}');
                                                        //var ml = mSearchTask..sort((a, b) => ,);
                                                      }
                                                      if (element.date
                                                          .contains(
                                                          searchString)) {
                                                        mSearchTask
                                                            .add(element);
                                                      }
                                                    });
                                                    mSearchTask.sort((a, b) => a.title.compareTo(b.title));
                                                    mSearchTask.sort((a, b) =>a.date.compareTo(b.date));
                                                    print("Search Data Size");
                                                    print(mSearchTask.length);

                                                    setState(() {});
                                                  },*/
                                    ),
                                      )
                                    ])))))
                  ])),
              if (searchController.text.isEmpty)
                GridView.builder(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 8,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.4),
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      columnCount: 10,
                      child: SlideAnimation(
                        horizontalOffset: 430,
                        verticalOffset: 400,
                        duration: const Duration(milliseconds: 2000),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: (index % 2) == 0
                                  ? Colors.blueGrey
                                  : Colors.tealAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 2,
                                ),
                                Container(

                                    // margin: EdgeInsets.all(20),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.teal,
                                        border: Border.all(width: 2)),
                                    child: Text(
                                      snapshot.data!.docChanges[index].doc['id']
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  snapshot.data!.docChanges[index].doc['title']
                                      .toString(),
                                  // mSearchTask.sort((b, a) => a.title.compareTo(b.title)),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  snapshot
                                      .data!.docChanges[index].doc['content'],
                                  // mSearchTask.sort((b, a) => a.title.compareTo(b.title)),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  snapshot.data!.docChanges[index].doc['date'],
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 35.0),
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => EditNote(
                                                    docid: snapshot
                                                        .data!.docs[index]),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.edit_sharp,
                                            color: Colors.indigo,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            //   print(snapshot.data![index].id);
                                            snapshot.data!.docs[index].reference
                                                .delete()
                                                .whenComplete(() {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          const HomeScreen()));
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.delete_forever,
                                            color: Colors.red,
                                          )),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                /*  Text(
                                snapshot.data![index].date
                                    .toString(),
                                // mSearchTask.sort((b, a) => a.title.compareTo(b.title)),
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight:
                                    FontWeight.w400),
                              ),*/

                                /* const SizedBox(
                                height: 10,
                              ),*/
                                /*  Text(
                                snapshot.data![index].status,
                                // mSearchTask.sort((b, a) => a.title.compareTo(b.title)),
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight:
                                    FontWeight.w400),
                              ),*/
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              else
                GridView.builder(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: mSearchTask.length,
                  itemBuilder: (context, index) {
                    // var varData = searchFunction(query, mSearchTask[index].title);
                    // var data = varData[index];

                    return Padding(
                      padding: (index % 2) == 0
                          ? const EdgeInsets.only(bottom: 15)
                          : const EdgeInsets.only(top: 15),
                      child: AnimationConfiguration.staggeredGrid(
                        position: index,
                        columnCount: 10,
                        child: SlideAnimation(
                          horizontalOffset: 430,
                          verticalOffset: 400,
                          duration:
                          const Duration(milliseconds: 2000),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: (index % 2) == 0
                                    ? Colors.lightBlueAccent
                                    : Colors.tealAccent,
                                borderRadius:
                                BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(

                                    // margin: EdgeInsets.all(20),
                                      padding:
                                      const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(
                                              100),
                                          color: Colors.teal,
                                          border:
                                          Border.all(width: 2)),
                                      child: Text(
                                        mSearchTask[index]
                                            .id!
                                            .toString(),
                                        //    data[index],
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight:
                                            FontWeight.w700),
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //query = mSearchTask.sort((a, b) => a.title.compareTo(b.title),)

                                  Text(
                                    mSearchTask[index].title,
                                    //mSearchTask.sort((a, b) => a.title.compareTo(b.title),),
                                    //query,

                                    //data[index].toString(),

                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    mSearchTask[index].description,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 35.0),
                                    child: Row(
                                      children: [
                                        IconButton(
                                            onPressed: () async {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => EditNote(
                                                      docid: snapshot
                                                          .data!.docs[index]),
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.edit_sharp,
                                              color: Colors.indigo,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              //   print(snapshot.data![index].id);
                                              snapshot.data!.docs[index].reference
                                                  .delete()
                                                  .whenComplete(() {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                        const HomeScreen()));
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.delete_forever,
                                              color: Colors.red,
                                            )),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    mSearchTask[index].date,
                                    // mSearchTask.sort((b, a) => a.title.compareTo(b.title)),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
            ],
          )
          );}
          else{
            return const Center(child: CircularProgressIndicator());
          }
          /*Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              //reverse: true,
              itemBuilder: (_, index) {

                return GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            EditNote(docid: snapshot.data!.docs[index]),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: ListTile(
                          tileColor: Colors.primaries[
                          Random().nextInt(Colors.primaries.length)],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                            side: const BorderSide(color: Colors.transparent),
                          ),
                          title: Text(
                            snapshot.data!.docChanges[index].doc['title'],
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            snapshot.data!.docChanges[index].doc['content'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );*/
        },

      ),
    );
  }
}

