import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  //var _counter = 0;
  late TextEditingController _controllerLogin;
  late TextEditingController _controllerPass;
  var _currentImage = "images/question-mark.png";
  var username='';
  var password='';

  @override
  void initState(){
    super.initState();
    _controllerLogin = TextEditingController();
    _controllerPass = TextEditingController();
    loadPrefs();
  }

  @override
  void dispose(){
    _controllerLogin.dispose();
    _controllerPass.dispose();
    super.dispose();
  }

  //function to change the images;
  void changeImage() {
    setState(() {
      if (_controllerPass.value.text == "QWERTY123"){
        _currentImage = "images/idea.png";
      } else if (_controllerPass.value.text == ""){
        _currentImage = "images/question-mark.png";
      } else{
        _currentImage = "images/stop.png";
      }
    });
  }

  Future<void> loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    //load the username/password to the variables;
    username = prefs.getString('username') ?? '';
    password = prefs.getString('password') ?? '';
    if (username == 'abc'){
      //if the user name is the one saved, load username/password to textfield;
      _controllerLogin.text = username;
      _controllerPass.text = password;
      var snackBar = SnackBar(
        content: Text('Username Loaded: $username'),
        //duration: Duration(seconds: 3),
        action: SnackBarAction(label: 'Undo',
            onPressed: (){
              //clear text field if undo is pressed;
              _controllerLogin.text = '';
              _controllerPass.text = '';
            }
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);}
    }

  Future<void> savePrefs(BuildContext context) async {
    Navigator.of(context).pop();
    EncryptedSharedPreferences prefs1 = EncryptedSharedPreferences();
    SharedPreferences.getInstance().then( (prefs1) {
      prefs1.setString('username', _controllerLogin.value.text);
      prefs1.setString('password', _controllerPass.value.text);
      var snackBar = SnackBar(
        content: Text('username/password saved'),
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }


  void _processYES(BuildContext context){
    //Navigator.of(context).pop();
    //var snackBar = SnackBar(content: Text('YES Clicked'));
    //ScaffoldMessenger.of(context).showSnackBar(snackBar);
    savePrefs(context);
  }

  void _processNO(BuildContext context){
    Navigator.of(context).pop();
    var snackBar = SnackBar(content: Text('NO Clicked'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  AlertDialog displayDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Save the username/password?'),
      content: const Text('Press YES or NO to save or not ...'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            _processNO(context);
          },
          child: const Text('NO'),
        ),
        TextButton(
          onPressed: () {
            _processYES(context);
          },
          child: Container(
            color: Colors.blueAccent,
            //padding: const EdgeInsets.all(14),
            child: const Text("YES"),
          ),
        ),
      ],
    );
  }
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //TextField for input;
            TextField(controller: _controllerLogin,
              obscureText: false,
              decoration: InputDecoration(
                  hintText: "Login",
                  border: OutlineInputBorder(),
                  labelText: "Login",
              ),
            ),

            //TextField for password;
            TextField(controller: _controllerPass,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(),
                  labelText: "Password",
              ),
            ),

            //Login button;
            ElevatedButton(onPressed:  () =>
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => displayDialog(context)
                ),
                child: Text ('Login',
                style: TextStyle(fontSize: 30, color: Colors.blueAccent),
                ),
            ),

            //Images to show login features;
            Image.asset(_currentImage,width: 300,height: 300,),
          ],
        ),
      ),
    );
  }
}
