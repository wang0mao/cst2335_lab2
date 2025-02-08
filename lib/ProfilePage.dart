import 'package:another_flushbar/flushbar.dart';
import 'package:cst2335_lab2/DataRepository.dart';
import 'package:cst2335_lab2/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
  FocusNode _focusNode = FocusNode();
  //final EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
  var index = 0;
  var username; //,password;

  @override
  void initState(){
    super.initState();
    _controllerFN = TextEditingController();
    _controllerLN = TextEditingController();
    _controllerPhone = TextEditingController();
    _controllerEmail = TextEditingController();

    //load data into the textfield;
    DataRepository.loadData();
    if(_controllerFN !=''){
      _controllerFN.text = DataRepository.firstName;
    }
    if(_controllerLN !=''){
      _controllerLN.text = DataRepository.lastName;
    }
    if(_controllerPhone !=''){
      _controllerPhone.text = DataRepository.phoneNumber;
    }
    if(_controllerEmail !=''){
      _controllerEmail.text = DataRepository.email;
    }
    welcomeMessage(context);
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange(){
    if(!_focusNode.hasFocus){
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => displayDialog(context)
      );
    }
  }

  void _processNO(context){
    Navigator.of(context).pop();
    _controllerFN.text = '';
    _controllerLN.text = '';
    _controllerPhone.text = '';
    _controllerEmail.text = '';
    DataRepository.removeData();
    var snackBar = SnackBar(content: Text('Context have been removed.'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _processUndo(context){
    Navigator.of(context).pop();

    _controllerFN.text = '';
    _controllerLN.text = '';
    _controllerPhone.text = '';
    _controllerEmail.text = '';
  }

  void _processYES(context){
      DataRepository.firstName = _controllerFN.text;
      DataRepository.lastName = _controllerLN.text;
      DataRepository.phoneNumber = _controllerPhone.text;
      DataRepository.email = _controllerEmail.text;
      DataRepository.saveData();

      Navigator.of(context).pop();

      var snackBar = SnackBar(
        content: Text('Context saved.'),
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }

  AlertDialog displayDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Save the context?'),
      content: const Text('Press YES or NO to save or remove ...'),
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
            _processYES(context);
          },
          child: Container(
            //color: Colors.blueAccent,
            padding: const EdgeInsets.all(14),
            child: const Text("YES"),
          ),
        ),
/*
        TextButton(
          onPressed: () {
            _processUndo(context);
          },
          child: Container(
            //color: Colors.blueAccent,
            padding: const EdgeInsets.all(14),
            child: const Text("Undo"),
          ),
        ),*/
      ],
    );
  }

  @override
  void dispose(){
    _controllerFN.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();

    _controllerLN.dispose();
    _controllerPhone.dispose();
    _controllerEmail.dispose();
    super.dispose();
  }

  void welcomeMessage(BuildContext context) async{
    //username = await prefs.getString('username') ?? '';
     username =  await DataRepository.loginName;
    setState(() {
      if (username != ""){
        //if the user name is the one saved, load username/password to textfield;
        /*
        var snackBar = SnackBar(
          content: Text('Welcome Back: '+ username),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.fromLTRB(20,0,20,0),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
        Flushbar(
          duration: Duration(seconds:2),
          flushbarPosition: FlushbarPosition.TOP,
          flushbarStyle: FlushbarStyle.FLOATING,
          message: 'Welcome Back: '+ username,
        ).show(context);
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
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),

          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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

                SizedBox(height: 20,),

                //TextField for password;
                TextField(controller: _controllerLN,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: "Last Name",
                    border: OutlineInputBorder(),
                    labelText: "Last name",
                  ),
                ),

                SizedBox(height: 20,),

                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible( //TextField for Phone number;
                        child:
                        TextField(controller: _controllerPhone,
                          obscureText: false,
                          decoration: InputDecoration(hintText: "Phone Number",
                            border: OutlineInputBorder(),
                            labelText: "Phone Number",
                          ),
                        ),

                      ),
                      ElevatedButton(
                        onPressed: () {
                          var url = "tel://"+_controllerPhone.text;
                           launch(url);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(25),
                            backgroundColor: Colors.grey[150],
                          ),
                        child: Icon(Icons.phone),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          var url = "sms://"+_controllerPhone.text;
                          launch(url);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(25),
                          backgroundColor: Colors.grey[150],
                        ),
                        child: Icon(Icons.message),
                      ),
                    ]),

                SizedBox(height: 20,),

                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //TextField for email address;
                      Flexible( //TextField for Phone number;
                        child:
                        TextField(controller: _controllerEmail,
                          obscureText: false,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            hintText: "Email Address",
                            border: OutlineInputBorder(),
                            labelText: "Email Address",
                          ),
                        ),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          var url = "mailto://"+_controllerEmail.text;
                          launch(url);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(25),
                          backgroundColor: Colors.grey[150],
                        ),
                        child: Icon(Icons.email),
                      ),
                    ]),
              ])
        ),
        )
    );

  }
  }