import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> images = [];

  @override
  void initState() {
    super.initState();

    getImages();
  }

  getImages() async {
    var url = Uri.parse("https://jsonplaceholder.typicode.com/photos");
    var response = await http.get(url);

    setState(() {
      images = json.decode(response.body);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Gallery"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: GridView.builder(
          padding: const EdgeInsets.only(top: 5),
          itemCount: 30,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SecondPage(url: images[index]["url"]
                  , title: images[index]["title"]))
                );
              },
              child: Card(
                child: Image.network(images[index]["url"]),
              ),
            );
          },
      )
    );
  }
}

class SecondPage extends StatelessWidget {
  String url;
  String title;
  SecondPage({super.key, required this.url, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Info"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Card (
              child: Image.network(url),
            ),
            Text("Title: $title"),
          ],
        ),
      ),
    );
  }
}
