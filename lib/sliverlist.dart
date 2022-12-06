import 'package:flutter/material.dart';
import 'package:todo_otp/api_data.dart';
import 'package:todo_otp/home_screen.dart';

class Sliverlist extends StatefulWidget {
  const Sliverlist({Key? key}) : super(key: key);

  @override
  State<Sliverlist> createState() => _SliverlistState();
}

class _SliverlistState extends State<Sliverlist> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(

      slivers: [
         SliverAppBar(
           snap: false,
           pinned: true,
           floating: true,
           flexibleSpace: FlexibleSpaceBar(
               centerTitle: true,
               title: const Text("SliverList",
                   style: TextStyle(
                     color: Colors.white,
                     fontSize: 16.0,
                   ) //TextStyle
               ), //Text
               background: Image.network(
                 "https://cdn.pixabay.com/photo/2020/11/08/09/41/deer-5723225_960_720.jpg",
                 fit: BoxFit.cover,
               ) //Images.network
           ), //FlexibleSpaceBar
           expandedHeight: 230,
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.home,
                size: 30,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) =>  HomeScreen()));
              },
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(

                (BuildContext context, int index) {
              return Card(
                margin: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ApiData(),));
                  },
                  child: Container(
                    color: Colors.blue[100 * (index % 9 + 1)],
                    height: 80,
                    alignment: Alignment.center,
                    child: Text(
                      "Item $index",
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              );
            },
            childCount: 20, // 1000 list items
          ),
        ),
      ],
    );
  }
}
