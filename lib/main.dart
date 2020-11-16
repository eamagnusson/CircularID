import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appTitle = 'CircularID';
    return CupertinoApp(
      theme: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          navLargeTitleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35.0,
            color: Colors.teal[300], // Can use more specific hex colors
          ),
        ),
      ),
      title: appTitle,
      home: MyHomePage(),
    );


    // Original Material theme code

    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     // This is the theme of your application.
    //     //
    //     // Try running your application with "flutter run". You'll see the
    //     // application has a blue toolbar. Then, without quitting the app, try
    //     // changing the primarySwatch below to Colors.green and then invoke
    //     // "hot reload" (press "r" in the console where you ran "flutter run",
    //     // or simply save your changes to "hot reload" in a Flutter IDE).
    //     // Notice that the counter didn't reset back to zero; the application
    //     // is not restarted.
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: MyHomePage(title: 'Flutter Demo Home Page'),
    // );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

  void _checkIn() {
    setState(() {
      http.Client().get('http://34.194.177.132/circular-id/inout.php?data=1');
    });
  }

  // Future getData() async {
  //   var url = 'http://34.194.177.132/circular-id/display_json.php';
  //   http.Response response = await http.get(url);
  //   // var data = response.body;
  //   var data = jsonDecode(response.body);
  //   print(data.toString());
  // }

  // @override
  // void initState() {
  //   print(fetchItems(http.Client()));
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.white,
        middle: Text('CircularID',
          style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
        ),
        trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() {
              });
            },
            color: Colors.teal[300],
            child: const Icon(
              CupertinoIcons.refresh,
            ),
          ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // Rendering from the DB
            FutureBuilder<List<Item>>(
              future: fetchItems(http.Client()),
              builder: (context, snapshot) {
                if(snapshot.hasError) print(snapshot.error);

                return snapshot.hasData
                  ? ItemsList(items: snapshot.data)
                  : Center(child: CircularProgressIndicator());
              },
            //   title: Text('CircularID',
            //     style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle),
            // ),
            ),

            CupertinoButton(
              onPressed: () {
                _checkIn();
              },
              color: Colors.teal[300],
              child: () {
                return Text("Check-In");
              }()
            ),

          ],
        ),
      ),
    );
    // Original Scaffold code

    // return Scaffold(
    //   appBar: AppBar(
    //     // Here we take the value from the MyHomePage object that was created by
    //     // the App.build method, and use it to set our appbar title.
    //     title: Text(widget.title),
    //   ),
    //   body: Center(
    //     // Center is a layout widget. It takes a single child and positions it
    //     // in the middle of the parent.
    //     child: Column(
    //       // Column is also a layout widget. It takes a list of children and
    //       // arranges them vertically. By default, it sizes itself to fit its
    //       // children horizontally, and tries to be as tall as its parent.
    //       //
    //       // Invoke "debug painting" (press "p" in the console, choose the
    //       // "Toggle Debug Paint" action from the Flutter Inspector in Android
    //       // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
    //       // to see the wireframe for each widget.
    //       //
    //       // Column has various properties to control how it sizes itself and
    //       // how it positions its children. Here we use mainAxisAlignment to
    //       // center the children vertically; the main axis here is the vertical
    //       // axis because Columns are vertical (the cross axis would be
    //       // horizontal).
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Text(
    //           'You have pushed the button this many times:',
    //         ),
    //         Text(
    //           '$_counter',
    //           style: Theme.of(context).textTheme.display1,
    //         ),
    //       ],
    //     ),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: _incrementCounter,
    //     tooltip: 'Increment',
    //     child: Icon(Icons.add),
    //   ), // This trailing comma makes auto-formatting nicer for build methods.
    // );
  }
}

class Item {
  // Originals
  final String tag;
  final String store;
  final String inOut;
  final String transaction;
  final String time;

  // New (for final)
  final String sku;
  final String resold;
  final String warranty;
  final String brand;
  final String primUse;
  final String iiUser;
  final String type;
  final String name;
  final String descript;
  final String photoURL;
  final String msrp;
  final String origCurr;
  final String origCountry;
  final String ciSale;
  final String color;
  final String size;
  final String material;
  final String weight;
  final String szn;
  final String cManu;

  Item({this.tag, this.store, this.inOut, this.transaction, this.time, this.sku, 
        this.resold, this.warranty, this.brand, this.primUse, this.iiUser, 
        this.type, this.name, this.descript, this.photoURL, this.msrp, 
        this.origCurr, this.origCountry, this.ciSale, this.color, 
        this.size, this.material, this.weight, this.szn, this.cManu});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      tag: json['TAG_ID'] as String,
      store: json['STORE_ID'] as String,
      inOut: json['IN\/OUT'] as String,
      transaction: json['TRANSACTION_ID'] as String,
      time: json['TIME'] as String,
      sku: json['SKU'] as String,
      resold: json['Resold'] as String,
      warranty: json['Warranty'] as String,
      brand: json['Parent Brand'] as String,
      primUse: json['Primary Use'] as String,
      iiUser: json['Intended Item User'] as String,
      type: json['Product Type'] as String,
      name: json['Product Name'] as String,
      descript: json['Ecommerce Description'] as String,
      photoURL: json['Ecommerce Photograph URL'] as String,
      msrp: json['Original Price (MSRP)'] as String,
      origCurr: json['Original Price (Currency'] as String,
      origCountry: json['Original Price (Country)'] as String,
      ciSale: json['Country of Intended Sale'] as String,
      color: json['Color'] as String,
      size: json['Size'] as String,
      material: json['Material Composition'] as String,
      weight: json['Net Weight'] as String,
      szn: json['Season\/Year of Intended Sale'] as String,
      cManu: json['Country of Manufacture'] as String,
    );
  }
}

class ItemsList extends StatelessWidget {
  final List<Item> items;

  ItemsList({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Main UI
    return Container(
      decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // Name of Item
            Text(
              items[0].name,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Colors.tealAccent,
              ),
            ),

            Text(
                "   ",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),

            // Image of Item
            Image.network(items[0].photoURL, height: 225),

            Text(
                "   ",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),

            // Brand and Size
            Row (
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
              // Brand
              Text(
                items[0].brand,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              // Size
              Text(
                items[0].size + " - " + items[0].iiUser + "'s",
                style: TextStyle(
                  color: Colors.tealAccent,
                ),
              ),
            ],
            ),
            // Each data and label
            Text(
                "   ",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),


            Row(children: <Widget>[
              Text(
                "   Resold: ",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              () {

                if (items[0].resold == "1") {
                  return Text(
                    "Yes",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Colors.tealAccent,
                    ),
                  );
                }
                else {
                  return Text(
                    "No",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Colors.tealAccent,
                    ),
                  );
                }
              }(), 
            ],),

            Text(
                "   ",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 5,
                  color: Colors.black,
                ),
              ),

            Row(children: <Widget>[
              Text(
                "   MSRP: ",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Text(
                items[0].msrp,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Colors.tealAccent,
                ),
              )
            ],),

            Text(
                "   ",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 5,
                  color: Colors.black,
                ),
              ),

            Row(children: <Widget>[
              Text(
                "   Color: ",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Text(
                items[0].color,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Colors.tealAccent,
                ),
              )
            ],),

            Text(
                "   ",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 5,
                  color: Colors.black,
                ),
              ),


            Row(children: <Widget>[
              Text(
                "   Year: ",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Text(
                items[0].szn,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Colors.tealAccent,
                ),
              )
            ],),


            Text(
                "   ",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 5,
                  color: Colors.black,
                ),
              ),




            Row(children: <Widget>[
              Text(
                "   Status: ",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              () {

                if (items[0].inOut == "1") {
                  return Text(
                    "In",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Colors.tealAccent,
                    ),
                  );
                }
                else {
                  return Text(
                    "Out",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Colors.tealAccent,
                    ),
                  );
                }
              }(), 
            ],),






          ],
        ),
    ); 

    // return ListView.builder(
    //   scrollDirection: Axis.vertical,
    //   shrinkWrap: true,
    //   itemBuilder: (context, index) {
    //     if (items[index].tag == "") {
    //       return Text("                               " + items[index].time);
    //     }
    //     if (items[index].inOut == "1" || items[index].inOut == "0") {
    //       return Text(items[index].tag + "        " + items[index].time + 
    //       "       " + items[index].inOut);
    //     }
    //     else {
    //       return Text(items[index].tag + "        " + items[index].time);
    //     }
    //   },
    //   itemCount: items.length,
    // );
  }
}

// Convert the response body into a List<Items>
List<Item> parseItems(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Item>((json) => Item.fromJson(json)).toList();
}

Future<List<Item>> fetchItems(http.Client client) async {
  final response =
      await client.get('http://34.194.177.132/circular-id/display_json2.php');

  return compute(parseItems, response.body);
}


