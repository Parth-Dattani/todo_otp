import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:todo_otp/home_screen.dart';
import 'package:todo_otp/sliverlist.dart';

import 'chip.dart';

class ImgCarousel extends StatefulWidget {
  const ImgCarousel({Key? key}) : super(key: key);

  @override
  State<ImgCarousel> createState() => _ImgCarouselState();
}

class _ImgCarouselState extends State<ImgCarousel> {
  // @override
  // void initState() {
  //   super.initState();
  //   // throw a custom error
  //   throw ("Hi there. I am an error");
  // }

  final List data = <Map<String, dynamic>>[
    {
      "title": "Image 1",
      "url":
          "https://cdn.pixabay.com/photo/2020/11/08/09/41/deer-5723225_960_720.jpg"
    },
    {
      "title": "Image 2",
      "url":
          "https://cdn.pixabay.com/photo/2020/11/01/19/41/autumn-5704791_960_720.jpg"
    },
    {
      "title": "Image 3",
      "url":
          "https://cdn.pixabay.com/photo/2020/04/11/14/55/houses-5030731_960_720.jpg"
    },
    {
      "title": "Image 4",
      "url":
          "https://cdn.pixabay.com/photo/2020/11/16/16/05/hoverfly-5749361_960_720.jpg"
    },
    {
      "title": "Image 5",
      "url":
          "https://cdn.pixabay.com/photo/2020/04/19/12/26/thread-5063401_960_720.jpg"
    },
    {
      "title": "Image 6",
      "url":
          "https://cdn.pixabay.com/photo/2020/11/16/22/58/mountains-5750804_960_720.jpg"
    },
  ];

  double? _ratingValue;
  String pasteValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Image Carousel'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ));
              },
              icon: const Icon(Icons.map))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: false,
                autoPlayInterval: const Duration(seconds: 2),
                autoPlayAnimationDuration: const Duration(milliseconds: 500),
                height: 300,
              ),
              items: data.map((item) {
                return GridTile(
                  footer: Container(
                      padding: const EdgeInsets.all(15),
                      color: Colors.black54,
                      child: Text(
                        item["title"],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      )),
                  child: Image.network(item["url"], fit: BoxFit.cover),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            const Text(
              'Image Rate?',
              style: TextStyle(
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 25),
            RatingBar(
                initialRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ratingWidget: RatingWidget(
                    full: const Icon(Icons.star, color: Colors.orange),
                    half: const Icon(
                      Icons.star_half,
                      color: Colors.orange,
                    ),
                    empty: const Icon(
                      Icons.star_outline,
                      color: Colors.orange,
                    )),
                onRatingUpdate: (value) {
                  setState(() {
                    _ratingValue = value;
                  });
                }),
            const SizedBox(height: 25),
            // Display the rate in number
            Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  FlutterClipboard.copy(_ratingValue.toString()).then((value) {
                    print('copy');
                  });
                },
                onDoubleTap: () {
                  FlutterClipboard.paste().then((value) {
                    setState(() {
                      //_ratingValue.toString() = value;
                      pasteValue = value;
                      print("paste: $pasteValue");
                    });
                  });
                },
                child: Text(
                  _ratingValue != null ? _ratingValue.toString() : 'Rate it!',
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AutoSizeText(
              pasteValue,
              style: const TextStyle(fontSize: 30),
              maxLines: 2,
            ),
            const SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Sliverlist(),
                          ));
                    },
                    child: const Text("Go to SliverList")),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CastFilter(),
                          ));
                    },
                    child: const Text("Go to Chip")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
