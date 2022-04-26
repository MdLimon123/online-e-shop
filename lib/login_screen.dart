import 'package:e_shop_online/models/authprovider.dart';
import 'package:e_shop_online/utils/custom_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {

  static const id = '/LoginScreen';

  GlobalKey formKey = GlobalKey<FormState>();
  TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 200,),
              const SizedBox(height: 70,),
              const Text('ONLINE SHOP', style:  TextStyle(fontSize: 30, fontFamily: 'roboto-bold'),),
              const SizedBox(height: 20,),
              Form(
                key: formKey,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: inputController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'enter phone number'
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30,),
                      MaterialButton(
                        minWidth: double.infinity,
                        color: primaryColor,
                          onPressed: (){
                          if(inputController.text != null){
                            final phone = '+880' + inputController.text;
                            AuthProvider().loginWithPhone(context, phone);
                          }
                          },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text('LOGIN', style: TextStyle(color: white, fontSize: 30),),
                        ),
                      )
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
