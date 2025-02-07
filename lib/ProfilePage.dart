import 'package:cst2335_lab2/main.dart';
//import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => ProfilePageState();
  var title="Profile Page";
}

class ProfilePageState extends State<ProfilePage> {

  late TextEditingController _controllerFN;
  late TextEditingController _controllerLN;
  late TextEditingController _controllerPhone;
  late TextEditingController _controllerEmail;
  //final EncryptedSharedPreferences prefs = EncryptedSharedPreferences();

  var username; //,password;

  @override
  void initState(){
    super.initState();
    _controllerFN = TextEditingController();
    _controllerLN = TextEditingController();
    _controllerPhone = TextEditingController();
    _controllerEmail = TextEditingController();
    //DataRepository.loadData();
    welcomeMessage(context);
  }

  @override
  void dispose(){
    _controllerFN.dispose();
    _controllerLN.dispose();
    _controllerPhone.dispose();
    _controllerEmail.dispose();
    super.dispose();
  }

  Future<void> welcomeMessage(BuildContext context) async{
    //username = await prefs.getString('username') ?? '';
     username =  await DataRepository.loginName;
    setState(() {
      if (username != ""){
        //if the user name is the one saved, load username/password to textfield;
        var snackBar = SnackBar(
          content: Text('Welcome Back: '+ username),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.fromLTRB(20,0,20,0),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .inversePrimary,
      title: Text(widget.title),
    ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
              child:
              TextField(controller: _controllerFN,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: "First Name",
                  border: OutlineInputBorder(),
                  labelText: "First Name",
                ),
              ),
            ),
            //TextField for input;


            //TextField for password;
            TextField(controller: _controllerLN,
              obscureText: false,
              decoration: InputDecoration(
                hintText: "Last Name",
                border: OutlineInputBorder(),
                labelText: "Last name",
              ),
            ),

            Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(//TextField for Phone number;
                  child:
                  TextField(controller: _controllerPhone,
                    obscureText: false,
                    decoration: InputDecoration(hintText: "Phone Number",
                      border: OutlineInputBorder(),
                      labelText: "Phone Number",
                    ),
                  ),

                ),
                ElevatedButton.icon(
                  onPressed: () {  },
                  icon: Icon(Icons.phone),
                  label: Text(''),
                ),

                ElevatedButton.icon(
                  onPressed: () {  },
                  icon: Icon(Icons.message),
                  label: Text(''),
                ),
              ]),


            //TextField for email address;
            TextField(controller: _controllerEmail,
              obscureText: false,
              decoration: InputDecoration(
                hintText: "Email Address",
                border: OutlineInputBorder(),
                labelText: "Email Address",
              ),
            ),

          ],
        ),
      ),
    ); //Use a Scaffold to layout a page with an AppBar and main body region
  }
}