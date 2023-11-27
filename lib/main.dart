
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_todo/pages/homepage.dart';
// import 'package:firebase_todo/pages/signin_page.dart';

import 'package:firebase_todo/pages/signup.dart';
import 'package:firebase_todo/service/auth_service.dart';
import 'package:flutter/material.dart';
// import 'dart:ui_web' as ui;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: FirebaseOptions(
    //   apiKey: "AIzaSyA_cPaS0RimbWa9zlVxouNrAtHASoh0Ofs",
    //    appId: "1:1043078318905:web:e2b05b0b71fb7b01e2b6e8", 
    //    messagingSenderId: "1043078318905",
    //     projectId: "todo-list-681c7",)
  );
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  // firebase_auth.FirebaseAuth firebaseAuth= firebase_auth.FirebaseAuth.instance;
  // void signup()async{
  //  try{
  // await firebaseAuth.createUserWithEmailAndPassword(email: 'aswadevsaga121@gmail.com', password: 'sagaraswa');
  //  }catch(e){
  //   print(e);
  //  }
  // }
  Widget currentPage=SignupPage();
  AuthClass authClass=AuthClass();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }
  void checkLogin()async{
   String token=await authClass.getToken();
   setState(() {
      // If the token exists and is not empty, show the HomePage.
      // Otherwise, show the SignupPage.
      currentPage = (token != null && token.isNotEmpty) ? HomePage() : SignupPage();
    });
   
   
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: currentPage,
    );
  }
}