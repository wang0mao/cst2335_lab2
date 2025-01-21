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

  @override

  void initState(){
    super.initState();
    _controllerLogin = TextEditingController();
    _controllerPass = TextEditingController();
  }

  void dispose(){
    _controllerLogin.dispose();
    _controllerPass.dispose();
    super.dispose();
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
            ElevatedButton(onPressed: changeImage,
                child: Text('Login')),

            //Images to show login features;
            Image.asset(_currentImage,width: 300,height: 300,),
          ],
        ),
      ),
    );
  }
}
