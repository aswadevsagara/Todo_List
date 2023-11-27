import 'package:firebase_todo/pages/signup.dart';
import 'package:firebase_todo/service/auth_service.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  AuthClass authClass=AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()async{
            await authClass.logout();
            Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:(builder)=>SignupPage() ), (route) => false);
            
          }, icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}