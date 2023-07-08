import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:todo_list/pages/AddToDo.dart';
import 'package:todo_list/pages/homepage.dart';
import 'package:todo_list/pages/signinPage.dart';
import 'package:todo_list/pages/signupPage.dart';
import 'service/Auth_Services.dart';
//import 'package:todo_list/service/Auth_Services.dart/';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 Widget currentPage = const signupPage();
 AuthClass authClass = AuthClass();

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }
  void checkLogin()async{
   String? token = await authClass.getToken();
   if(token!=null)
     {
       setState(() {
         currentPage = signupPage();
       });
     }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: signupPage(),
    );
  }
}

