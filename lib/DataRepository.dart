import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class DataRepository{
  static String loginName='';
  //static String password='';
  static String firstName='';
  static String lastName='';
  static String phoneNumber = '';
  static String email = '';
  static void loadData() async{
    EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    loginName = await prefs.getString('username');
    firstName = await prefs.getString('firstName');
    lastName = await prefs.getString('lastName');
    phoneNumber = await prefs.getString('phoneNumber');
    email  = await prefs.getString('email');
  }
  static void saveData() async{
    EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    prefs.setString('firstName', firstName);
    prefs.setString('lastName', lastName);
    prefs.setString('phoneNumber', phoneNumber);
    prefs.setString('email', email);
  }

  static void removeData() async{
    EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    prefs.remove('firstName');
    prefs.remove('lastName');
    prefs.remove('phoneNumber');
    prefs.remove('email');
  }
}