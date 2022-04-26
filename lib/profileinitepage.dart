
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop_online/login_screen.dart';
import 'package:e_shop_online/models/usermodel.dart';
import 'package:e_shop_online/screens/main_screen.dart';
import 'package:e_shop_online/utils/contanst.dart';
import 'package:e_shop_online/utils/decoration.dart';
import 'package:e_shop_online/utils/textstyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


class ProfileInitPage extends StatefulWidget {
  static const id = '/profileinit';

  @override
  State<ProfileInitPage> createState() => _ProfileInitPageState();
}

class _ProfileInitPageState extends State<ProfileInitPage> {
  Future signOut(BuildContext context) async{
   await FirebaseAuth.instance.signOut().whenComplete(() => Navigator.pushReplacementNamed(context, LoginScreen.id));
  }

  TextEditingController nameC = TextEditingController();

  TextEditingController houseC = TextEditingController();

  TextEditingController cityC = TextEditingController();

  TextEditingController streetC = TextEditingController();

  TextEditingController zipcodeC = TextEditingController();

  TextEditingController dobC = TextEditingController();

  late DateTime selectedDate;

  final formkey = GlobalKey<FormState>();

  bool isLoading = false;

  FirebaseFirestore db = FirebaseFirestore.instance;

  submit(BuildContext context) async{
    if(formkey.currentState!.validate()){

      FirebaseMessaging fbm = FirebaseMessaging.instance;
      String? fcm = await fbm.getToken();
      AppUser.update(
        name: nameC.text,
        house: houseC.text,
        street: streetC.text,
        city: cityC.text,
        zipcode: zipcodeC.text,
        dob: dobC.text,
        fcmToken: fcm,
        isLoggedIn:true,
        userType: 0
      );

      db.collection('User').doc(AppUser.phone).set(AppUser().getMap).then((value){
        Navigator.of(context).pushReplacementNamed(MainPage.id);
      }).catchError((e){
        displayMessage(e.toString());
      });
      setState(() {
        isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
            child: Stack(
              children: [

                Align(
                  alignment: Alignment.topCenter,
                  child: Text('PROFILE',
                  style: heading2,
                  ),
                ),
                isLoading? const Center(
                  child: CircularProgressIndicator(),
                ):
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Form(
                      key: formkey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                autovalidateMode: AutovalidateMode.always,
                                onFieldSubmitted: (v){
                                  nameC.text = v;
                                },
                                controller: nameC,
                                validator: (v){
                                  if(v!.length < 4){
                                    return 'should be greater than 5';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  icon: person,
                                  hintText: 'enter name',
                                  labelText: 'what people call you?',
                                  border: const OutlineInputBorder()
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                autovalidateMode: AutovalidateMode.always,
                                onFieldSubmitted: (v){
                                  houseC.text = v;
                                },
                                controller: houseC,
                                validator: (v){
                                  if(v!.length < 4){
                                    return 'should be greater than 5';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  icon: address,
                                  hintText: 'enter house no.',
                                  labelText: 'enter house no.',
                                  border: const OutlineInputBorder()
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                autovalidateMode: AutovalidateMode.always,
                                onFieldSubmitted: (v){
                                  streetC.text = v;
                                },
                                controller: streetC,
                                validator: (v){
                                  if(v!.length < 4){
                                    return 'should be greater than 5';
                                  }
                                  return null;
                                },
                                decoration:InputDecoration(
                                  icon: address,
                                  hintText: 'enter street',
                                  labelText: 'enter street',
                                  border: const OutlineInputBorder()
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                autovalidateMode: AutovalidateMode.always,
                                onFieldSubmitted: (v){
                                  cityC.text = v;
                                },
                                controller: cityC,
                                validator: (v){
                                  if(v!.length < 4){
                                    return 'should be greater than 5';
                                  }
                                  return null;
                                },
                                decoration:InputDecoration(
                                  icon: address,
                                  hintText: 'enter city',
                                  labelText: 'what city',
                                  border: const OutlineInputBorder()
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                autovalidateMode: AutovalidateMode.always,
                                onFieldSubmitted: (v){
                                  zipcodeC.text = v;
                                },
                                controller: zipcodeC,
                                validator: (v){
                                  if(v!.length < 4){
                                    return 'should be greater than 5';
                                  }
                                  return null;
                                },
                                decoration:InputDecoration(
                                  icon: address,
                                  labelText: 'enter zip code',
                                  border: const OutlineInputBorder()
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.always,
                                onFieldSubmitted: (v){
                                  dobC.text = v;
                                },
                                onTap: (){
                                 showDatePicker(
                                     context: context,
                                     initialDate: DateTime.now(),
                                     firstDate: DateTime(1790),
                                     lastDate: DateTime.now()).
                                 then((value){
                                       if(value == null)
                                         return;
                                       else{
                                         selectedDate = value;
                                         dobC.text = selectedDate.toString().substring(0,10);
                                       }
                                 });

                                },
                                controller: dobC,
                                validator: (v){
                                  if(v!.length < 4){
                                    return 'should be greater than 5';
                                  }
                                  return null;
                                },
                                decoration:InputDecoration(
                                  icon: dob,
                                  labelText: 'enter date of birth',
                                  border: const OutlineInputBorder()
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
      ),
      floatingActionButton: isLoading
          ?null
          : FloatingActionButton(
        onPressed: (){
          submit(context);
        },
      child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
