

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


import '../pages/homepage.dart';

class AuthClass{
 GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);
FirebaseAuth auth=FirebaseAuth.instance;
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
final storage = FlutterSecureStorage();


Future<void> googleSignIn( BuildContext context) async {
try{
GoogleSignInAccount? googleSigninAccount= await _googleSignIn.signIn();
if(googleSigninAccount!=null){
  GoogleSignInAuthentication  googleSignInAuthentication=await googleSigninAccount.authentication;
  AuthCredential credential= GoogleAuthProvider.credential(
    idToken:googleSignInAuthentication.idToken,
    accessToken: googleSignInAuthentication.accessToken
   );
   try{
   UserCredential userCredential=await auth.signInWithCredential(credential);
   storeTokenAndData(userCredential);
   Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:(builder)=>HomePage() ), (route) => false);
   }catch(e){
     final snackbar=SnackBar(content: Text(e.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
   }

}else{
   final snackbar=SnackBar(content: Text('not able to sign up'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

}catch(e){
    final snackbar=SnackBar(content: Text(e.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

}
Future <void> storeTokenAndData(UserCredential userCredential)async{
await storage.write(key: 'token', value: userCredential.credential?.token.toString());
await storage.write(key: 'userCredential', value: userCredential.toString());

}

Future<String> getToken() async {
 
  String? token = await storage.read(key: 'token');
   if (token != null) {
    return token;
  }else{
   return '';
  }
 
}

Future<void> logout()async{
  try{
 await _googleSignIn.signOut();
   await auth.signOut();
   await storage.delete(key: 'token');
   
  }catch(e){
   
  }
}
}


