
import 'package:e_shop_online/models/usermodel.dart';
import 'package:e_shop_online/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthProvider{

  Future<void>loginWithPhone(BuildContext context, String phone) async{
    FirebaseAuth _auth = FirebaseAuth.instance;
    TextEditingController otpC = TextEditingController();
    _auth.verifyPhoneNumber(phoneNumber: phone,

        verificationCompleted: (AuthCredential credential) async{
       UserCredential result =  await _auth.signInWithCredential(credential);
         Navigator.pop(context);
         User? user = result.user;
         if(user != null){
           AppUser.set(phone);
           Navigator.pushReplacementNamed(context, MainPage.id);

         }else{
           Fluttertoast.showToast(msg: 'user is not signed in ');
         }


        },
        verificationFailed: (FirebaseException e){
         Fluttertoast.showToast(msg: e.toString());

        },
        codeSent: (String? verificationCode, int? token){
           showDialog(context: context, builder: (_){
             return AlertDialog(
               title: const Text('enter OTP'),
               content: Column(
                 children: [
                   TextField(
                     controller: otpC,
                   )
                 ],
               ),
               actions: [
                 ElevatedButton(
                     onPressed: () async{
                       final code = otpC.text;
                       AuthCredential credential =
                           PhoneAuthProvider.credential(verificationId: verificationCode!, smsCode: code);
                       UserCredential result = await _auth.signInWithCredential(credential);
                       
                       User? user = result.user;
                       
                       if(user != null){
                         AppUser.set(phone);
                         Navigator.pushReplacementNamed(context, MainPage.id);

                         print('success');
                       }else{
                         Fluttertoast.showToast(msg: 'error');
                       }
                     },
                     child: const Text('verify')
                 )
               ],
             );
           });
        },
        codeAutoRetrievalTimeout:(id)=> {}
    );

  }
}