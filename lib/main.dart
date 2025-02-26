import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CST2335 Samples',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Week 6 - ListView'),
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
  var wordsArray = <String>[ ];
  late TextEditingController _controllerItem;
  late TextEditingController _controllerQuantity;

  @override

  void initState(){
    super.initState();
    _controllerItem = TextEditingController();
    _controllerQuantity = TextEditingController();
  }

  @override
  void dispose(){
    _controllerItem.dispose();
    _controllerQuantity.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text(widget.title)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //TextField for input;
              TextField(controller: _controllerItem,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: "Type the item here",
                  border: OutlineInputBorder(),
                  labelText: "Items",
                ),
              ),

              //TextField for password;
              TextField(controller: _controllerQuantity,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Type the quantity here",
                  border: OutlineInputBorder(),
                  labelText: "Quantities",
                ),
              ),

              //Login button;
              ElevatedButton(onPressed: addItem,
                  child: Text('Click here')),

              ListPage(),
            ],
          ),
        ),
    );
  }

  void addItem() {
    setState(() {
      wordsArray.add("${wordsArray.length+1}: "+ _controllerItem.text +" quantity: "+_controllerQuantity.text);
    });
  }

  Widget ListPage(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child:
          ListView.builder(
              itemCount:wordsArray.length,
              itemBuilder: (context, rowNum) { return
                Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:[
                      Text("${1+rowNum}: ${wordsArray[rowNum]} "),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            wordsArray[rowNum] = wordsArray[rowNum].toUpperCase();
                          });
                        },
                        child: const Icon(Icons.arrow_upward),
                      ),
                      GestureDetector(
                        onDoubleTap: () {
                          setState(() {
                            wordsArray[rowNum] = wordsArray[rowNum].toLowerCase();
                          });
                        },
                        child: const Icon(Icons.arrow_downward),
                      ),
                      GestureDetector(
                        onLongPress: () {
                          setState(() {
                            wordsArray.removeAt(rowNum);
                          });
                        },
                        child: const Icon(Icons.delete),
                      ),
                    ]
                );
              }
          ),
          ),
        ],
      ),
    );
  }
}
