import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final box = GetStorage();

  final List<Map<String, dynamic>> items = [
    {
      'title': '수원낚시',
    },
    {
      'title': '화성낚시',
    },
  ];

  Map<String, bool> bookmarks = {};

  @override
  void initState() {
    super.initState();
    bookmarks = Map<String, bool>.from(box.read('bookmarks') ?? {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetStorage Sample'),
      ),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (_, index) {
            String title = items[index]['title'];
            return ListTile(
              title: Text(title),
              trailing: bookmarks[title] ?? false
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border),
              onTap: () {
                setState(() {
                  bool currentFavorite = bookmarks[title] ?? false;
                  bookmarks[title] = !currentFavorite;

                  box.write('bookmarks', bookmarks);
                });
              },
            );
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose');
  }

}
