import 'package:firebase_todo/pages/homepage.dart';
import 'package:firebase_todo/pages/signin_page.dart';
import 'package:firebase_todo/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
 firebase_auth.FirebaseAuth firebaseAuth= firebase_auth.FirebaseAuth.instance;
 TextEditingController _emailController=TextEditingController();
 TextEditingController _pwdController=TextEditingController();
 bool circular=false;
 AuthClass authclass= AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'sign up',
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              buttonItem(
                  buttonname: 'Continue with Google',
                  imagepath: 'asset/google_svg.png',
                  sizeofbtn: 25,
                  onTap: ()async{
                   await authclass.googleSignIn(context);
                  } ,
                  ),
              SizedBox(
                height: 15,
              ),
              buttonItem(
                  buttonname: 'Continue with phone ',
                  imagepath: 'asset/Phone_svg.png',
                  sizeofbtn: 25,
                  onTap: (){}
                  ),
              SizedBox(
                height: 13,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  'Or',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              textItem(labelText: 'Email...',controller:_emailController,obscuretext: false ),
              SizedBox(
                height: 15,
              ),
              textItem(labelText: 'Password...',controller:_pwdController,obscuretext: true ),
              SizedBox(
                height: 30,
              ),
              colorButton(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('If you already have an account? ',style: TextStyle(color: Colors.white,fontSize: 16),),
                   GestureDetector(
                    onTap: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>SigninPage()), (route) => false);
                    },
                    child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,),))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonItem(
      {required imagepath,
      required String buttonname,
      required double sizeofbtn,
      required Function()? onTap
      }) {
    return GestureDetector(
      onTap:onTap ,

      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        child: Card(
          color: Colors.black,
          elevation: 8,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                width: 1,
                color: Colors.grey,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagepath,
                height: sizeofbtn,
                width: sizeofbtn,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                buttonname,
                style: TextStyle(color: Colors.white, fontSize: 17),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textItem({required String labelText,required TextEditingController controller,required obscuretext}) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obscuretext,
        style:TextStyle(color: Colors.white, fontSize: 17) ,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(width: 1, color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(width: 1, color: Colors.yellow)),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white, fontSize: 17)),
      ),
    );
  }

  Widget colorButton() {
    return InkWell(
      onTap: ()async{
      try{
        setState(() {
          circular=true;
        });
        firebase_auth.UserCredential userCredential= await firebaseAuth.createUserWithEmailAndPassword(email: _emailController.text, password: _pwdController.text);
      print(userCredential.user?.email);
      setState(() {
          circular=false;
        });
        Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:(builder)=>HomePage() ), (route) => false);
      }catch(e){
        final snackbar=SnackBar(content: Text(e.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        setState(() {
          circular=false;
        });
      }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: [
              Color(0xffffd746c),
              Color(0xffff9068),
              Color(0xffff746c),
            ])),
        child: Center(
            child:circular?CircularProgressIndicator() :Text(
          'Signup',
          style: TextStyle(color: Colors.white, fontSize: 20),
        )),
      ),
    );
  }
}
