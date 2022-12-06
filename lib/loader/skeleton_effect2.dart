import 'package:flutter/material.dart';


class SkeletonEffect2 extends StatefulWidget {
  const SkeletonEffect2({Key? key}) : super(key: key);

  @override
  State<SkeletonEffect2> createState() => _SkeletonEffect2State();
}

class _SkeletonEffect2State extends State<SkeletonEffect2> {
  final List numbers = [
    'one',
    'two',
    'three',
    'hello',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine',
    'ten',
  ];
  bool isLoading = false;
  var tabIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    // tabController = TabController(length: 3, vsync: this);
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  // Future loadData() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   await Future.delayed(Duration(seconds: 2));
  //   var saa= List.of(s);
  //   s.first.toString();
  //   print(s.last.toString());
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Skeleton Loader")),
      body: DefaultTabController(
        length: 2,
        initialIndex: tabIndex,
        child: Column(
          children: [
             const TabBar(
              indicatorColor: Colors.deepPurple,
              labelColor: Colors.blue,
              indicatorWeight: 5,
              unselectedLabelColor: Colors.black, splashBorderRadius: BorderRadius.all(Radius.circular(122)),

              tabs: <Widget>[
                Tab(
                  text: "List",
                ),
                Tab(text: "Grid"),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      listData(),
                      gridData()
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget listData() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ListView.builder(
        itemBuilder: (context, index) => Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Container(
              child: Row(
                children: [
                  CircleAvatar(
                    child: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Text(
                    numbers[index],
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: numbers.length,
      ),
    );
  }

  Widget gridData() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: GridView.builder(
          itemBuilder: (context, index) => Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22)),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 20),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          maxRadius: 30,
                          child: CircleAvatar(
                            child: Icon(Icons.person,size: 30, ),
                          ),
                        ),
                        Text(
                          numbers[index],
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: numbers.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 5,
          )),
    );
  }
}
