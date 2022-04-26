
import 'package:e_shop_online/login_screen.dart';
import 'package:e_shop_online/models/categories.dart';
import 'package:e_shop_online/models/usermodel.dart';
import 'package:e_shop_online/profileinitepage.dart';
import 'package:e_shop_online/screens/products/productscreen.dart';
import 'package:e_shop_online/utils/decoration.dart';
import 'package:e_shop_online/widgets/app_drawar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/slider.dart';

class MainPage extends StatefulWidget {
  static const id = '/mainpage';



  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController searchC = TextEditingController();
  List<Category> newList = List.from(categories);

  @override
  void dispose() {
    searchC.clear();
    super.dispose();
  }

  @override
  void initState(){

    //go();

    super.initState();
  }

  AppUser appUser = AppUser();

 @override
  void didChangeDependencies() async{

   if(await appUser.getInfoFormDb){
     if(!AppUser.isLoggedIn){
       Navigator.pushReplacementNamed(context, LoginScreen.id);
     }else{
       Navigator.pushReplacementNamed(context, ProfileInitPage.id);
     }

    super.didChangeDependencies();
  }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('home page'),
      centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            Container(
              decoration:decoration(),
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child:  TextField(
                  controller: searchC,
                  onChanged: (value){
                    setState(() {
                      searchC.text = value;
                      newList=categories.where((e) => e.name.toLowerCase().contains(value.toLowerCase())).toList();
                      print(searchC.text);
                    });
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'search category...',
                    suffixIcon: Icon(FontAwesomeIcons.search)
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            CSlider(),
            const SizedBox(height: 20,),
            const Text('CATEGORIES',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Column(
              children: newList.map((e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    
                    Navigator.of(context).pushNamed(ProductScreen.id,
                      arguments: {
                       'category': e.name,
                        'icon' : e.icon
                      }
                    );
                  },
                  child: Container(
                    decoration:   BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.purple,
                            Colors.blue
                          ]
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(e.name, style: const TextStyle(color: Colors
                            .white,
                            fontSize: 20),),
                          ),
                          Icon(e.icon, size: 30,color: Colors.white,)
                        ],
                      ),
                    ),
                  ),
                ),
              )).toList(),
            )
          ],
        ),
      ),
    );
  }
}


