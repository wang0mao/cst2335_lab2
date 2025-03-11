import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'ShoppingListDAO.dart';
import 'ShoppingList.dart';
import 'database.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CST2335 Labs',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Week 7 - Sqlite'),
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
  List<ShoppingList> shoppingList = <ShoppingList>[];
  late ShoppingListDAO taskDAO;

  //var wordsArray = <String>[ ];
  late TextEditingController _controllerItem;
  late TextEditingController _controllerQuantity;

  @override

  void initState(){
    super.initState();
    _controllerItem = TextEditingController();
    _controllerQuantity = TextEditingController();

    $FloorShoppingListDatabase
        .databaseBuilder('todo_database.db')
        .build()
        .then((database) async { //Note the use of async here
      taskDAO = database.shoppingListDAO;
      //get Items from database:
      var it = await taskDAO.getAllItems();
      setState(() {
        shoppingList = it;
      });
    });

  }

  @override
  void dispose(){
    _controllerItem.dispose();
    _controllerQuantity.dispose();
    super.dispose();
  }

  void _processNO(BuildContext context){
    Navigator.of(context).pop();
  }

  void _processYES(BuildContext context,int rowNum) async{
    Navigator.of(context).pop();

      taskDAO.deleteList(shoppingList[rowNum]);
      var it = await taskDAO.getAllItems();
      setState(() {
        shoppingList = it;
        if (shoppingList.isEmpty) {
          showEmptySnackBar();
        }
      });
  }


  void showEmptySnackBar() {
    setState(() {
      Flushbar(
        //animationDuration: Duration(seconds: 4),
        //forwardAnimationCurve: Curves.easeIn,
        //reverseAnimationCurve: Curves.easeOut,
        duration: Duration(seconds: 2),
        flushbarPosition: FlushbarPosition.TOP,
        flushbarStyle: FlushbarStyle.FLOATING,
        message: "There are no items in the list",
        //margin: EdgeInsets.symmetric(vertical: 40),

      ).show(context);
    }
    );
  }
  void showInvalidSnackBar() {
    setState(() {
      Flushbar(
        //animationDuration: Duration(seconds: 4),
        //forwardAnimationCurve: Curves.easeIn,
        //reverseAnimationCurve: Curves.easeOut,
        duration: Duration(seconds: 2),
        flushbarPosition: FlushbarPosition.TOP,
        flushbarStyle: FlushbarStyle.FLOATING,
        message: "Invalid Inputs",
        //margin: EdgeInsets.symmetric(vertical: 40),

      ).show(context);
    }
    );
  }

  void displayDialog(BuildContext context,int rowNum) {
    //String rows = rowNum.toString();
    showDialog(context: context, builder: (BuildContext context)
    {
      return AlertDialog(
        title: const Text('Delete or Not?'),
        content: const Text('Press YES or NO to delete.'),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                _processNO(context);
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                child: const Text('NO'),
              )
          ),
          TextButton(
            onPressed: () {
              _processYES(context, rowNum);
            },
            child: Container(
              //color: Colors.blueAccent,
              padding: const EdgeInsets.all(14),
              child:  Text("YES "),
            ),
          ),
        ],
      );
    },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //  title: Text(widget.title),
      //),
      body: Center(
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),

          child: Column(
            //mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20,),
                //row for the inputs;
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //TextField for input;
                    Flexible(
                      //fit: FlexFit.loose,
                      child:
                      TextField(controller: _controllerItem,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: "Items",
                          border: OutlineInputBorder(),
                          labelText: "Type the item here",
                        ),
                      ),
                    ),

                    //TextField for password;
                    Flexible(
                      //fit: FlexFit.loose,
                      child:
                      TextField(controller: _controllerQuantity,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: "Quantities",
                          border: OutlineInputBorder(),
                          labelText: "Type the quantity here",
                        ),
                      ),),
                    //Click here button;
                    ElevatedButton(onPressed: addItem,
                        child: Text('Add to List')),
                  ],
                ),
                SizedBox(height: 20,),
                //rows for the added items to the list;
                Flexible(
                    fit: FlexFit.loose,
                    child: listPage(context)),
              ]
          ),
        ),
      ),
    );
  }

  bool isOnlyNumbers(String text) {
    return RegExp(r'^\d+$').hasMatch(text);
  }

  void addItem() async {
      if(_controllerItem.text =='' || _controllerQuantity.text == '' || ( !isOnlyNumbers(_controllerQuantity.text)))
      {
        showInvalidSnackBar();
        _controllerItem.text ='';
        _controllerQuantity.text = '';
      }
      else{
        String newList = _controllerItem.text +" quantity: "+_controllerQuantity.text;
        var newItem = ShoppingList( null, newList) ;
        await taskDAO.insertList(newItem);
        var it = await taskDAO.getAllItems();
        setState(() {
          shoppingList = it;
        });
        _controllerItem.clear();
        _controllerQuantity.clear();
      }
  }

  Widget listPage(BuildContext context){
    return Center(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child:
            ListView.builder(
                itemCount: shoppingList.length,
                itemBuilder: (context, rowNum) { return
                  Row( mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        GestureDetector(
                          onLongPress: () {
                            setState(() {
                              displayDialog(context,rowNum);
                            });},
                          child: Text((rowNum+1).toString()+" : ${shoppingList[rowNum].shoppingListItem} "),
                        ),
                      ]
                  );
                }),
          ),
        ],
      ),
    );
  }
}
