import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class ApiData extends StatefulWidget {
  const ApiData({Key? key}) : super(key: key);

  @override
  State<ApiData> createState() => _ApiDataState();
}

class _ApiDataState extends State<ApiData> {

  List _loadedPhotos = [];

  // The function that fetches data from the API
  Future<void> _fetchData() async {
    const API_URL = 'https://jsonplaceholder.typicode.com/photos';

    HttpClient client =  HttpClient();
    client.autoUncompress = true;

    final HttpClientRequest request = await client.getUrl(Uri.parse(API_URL));
    request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    final HttpClientResponse response = await request.close();

    final String content = await response.transform(utf8.decoder).join();
    final List data = json.decode(content);

    setState(() {
      _loadedPhotos = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('API DATA'),
        ),
        body: SafeArea(
            child: _loadedPhotos.isEmpty
                ? Center(
              child: ElevatedButton(
                onPressed: _fetchData,
                child: const Text('Load Photos'),
              ),
            )
            // The ListView that displays photos
                : ListView.builder(
              itemCount: _loadedPhotos.length,
              itemBuilder: (BuildContext ctx, index) {
                return ListTile(
                  leading: _loadedPhotos[index]['id']%2 == 0? Icon(Icons.account_box_sharp, size: 42,color: Colors.red,)
                      : Icon(Icons.account_box_sharp, size: 42,color: Colors.indigo,),
                  // leading: Image.network(
                  //   _loadedPhotos[index]["thumbnailUrl"],
                  //   width: 150,
                  //   fit: BoxFit.cover,
                  // ),
                  title: Text(_loadedPhotos[index]['title']),
                  subtitle:
                      Text('Photo ID: ${_loadedPhotos[index]["id"]}')

                );
              },
            )));
  }
}
