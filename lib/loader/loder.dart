import 'package:flutter/material.dart';
import 'package:todo_otp/loader/skeleton_effect2.dart';



class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late bool _isLoading;

  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "News App",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: _isLoading
            ? ListView.separated(
          itemCount: 5,
          itemBuilder: (context, index) => const NewsCardSkelton(),
          separatorBuilder: (context, index) =>
          const SizedBox(height: 22),
        )
            : ListView.separated(
          itemCount: 6,
          itemBuilder: (context, index) => Container(
            child:
            Text("dfdf")
          ),
          separatorBuilder: (context, index) =>
          const SizedBox(height: 22),
        ),
      ),
    );
  }
}

class NewsCardSkelton extends StatelessWidget {
  const NewsCardSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //const SkeletonEffect(height: 120, width: 120),
        const SizedBox(width: 22),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //const SkeletonEffect(width: 80),
              const SizedBox(height: 22 / 2),
             // const SkeletonEffect(),
              const SizedBox(height: 22 / 2),
              //const SkeletonEffect(),
              const SizedBox(height: 22 / 2),
              Row(
                children:  [
                  Expanded(
                    child: Text("df"),
                    //child: SkeletonEffect(),
                  ),
                  SizedBox(width: 22),
                  Expanded(
                    child: Text("fd"),
                  //  child: SkeletonEffect(),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}