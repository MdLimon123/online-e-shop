import 'dart:async';
import 'package:e_shop_online/models/usermodel.dart';
import 'package:e_shop_online/login_screen.dart';
import 'package:e_shop_online/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class SplashInitScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return SplashScreen();
          }
          if(!snapshot.hasData || snapshot.data == null) {
            return LoginScreen();
          }else if(snapshot.data!.phoneNumber != null){
            AppUser.set(snapshot.data!.phoneNumber.toString());
          }
          return SplashScreen();
        },
      ),
    );
  }
}


class SplashScreen extends StatefulWidget {

  static const id = '/SplashScreen';


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late Timer _timer;

  @override
  void initState(){
    super.initState();
   _timer = Timer(Duration(seconds: 3), (){
      Navigator.pushReplacementNamed(context, MainPage.id);
    });

  }
  @override
  void dispose() {
  _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(

        child: Scaffold(

          backgroundColor: Colors.white,
          body: Column(

            children: [
              Expanded(child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Image.asset('assets/images/logo.png'),
              )),
             const Text('Online Shop', style:  TextStyle(fontSize: 30, fontFamily: 'roboto-bold'),),
             const Expanded(child: Center(child: CircularProgressIndicator()))
            ],
          ),
        ),
    );
  }
}
