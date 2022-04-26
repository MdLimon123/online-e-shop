import 'package:e_shop_online/models/categories.dart';
import 'package:e_shop_online/models/productmodel.dart';
import 'package:e_shop_online/utils/custom_color.dart';
import 'package:e_shop_online/utils/decoration.dart';
import 'package:e_shop_online/widgets/app_drawar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:multi_image_picker/multi_image_picker.dart';

import '../utils/textstyle.dart';

class AddProductPage extends StatefulWidget {
  static const id = 'addproduct';

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController categoryC = TextEditingController();
  TextEditingController productName = TextEditingController();
  TextEditingController serialCode = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController weightC = TextEditingController();
  TextEditingController brandC = TextEditingController();
  TextEditingController detailC = TextEditingController();

  TextEditingController quantityC = TextEditingController();
  TextEditingController onSaleC = TextEditingController();
  TextEditingController popularC = TextEditingController();
  TextEditingController discountC = TextEditingController();
  bool isSale = false;
  bool isPopular = false;
  final _formKey = GlobalKey<FormState>();

  List<Asset> images = <Asset>[];
  List<String> imagesUrls = <String>[];

  save() async{
    bool isValidate = _formKey.currentState!.validate();
    if(isValidate){
      await uploadImage();

      ProductModel(
          category: categoryC.text,
        productName: productName.text,
        detail: detailC.text,
        serialCode: serialCode.text,
        price: int.parse(priceC.text),
        weight: weightC.text,
        brandName: brandC.text,
        quantity: int.parse(quantityC.text),
        imagesUrl: imagesUrls,
        isOnSale: isSale,
        isPopular: isPopular
      ).addProduct(ProductModel(
        category: categoryC.text,
          productName: productName.text,
          detail: detailC.text,
          serialCode: serialCode.text,
          price: int.parse(priceC.text),
          weight:weightC.text,
          brandName: brandC.text,
          quantity: int.parse(quantityC.text),
          imagesUrl: imagesUrls,
          isOnSale: isSale,
          isPopular: isPopular
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('add product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                decoration: decoration(),
                child: DropdownButtonFormField(
                  validator: (String? v){
                    if(v!.isEmpty){
                      return 'should not be empty';
                    }
                    return null;
                  },
                  hint: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('selected category'),
                  ),
                  decoration: const InputDecoration(border: InputBorder.none),
                 // value: categories[0].name,
                  items: categories
                      .map((e) => DropdownMenuItem(
                          value: e.name,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(e.name),
                          )))
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      categoryC.text = value!;
                      print(value);
                    });
                  },
                ),
              ),
              EditField(
                lines: 1,
                validator: (String? v){
                  if(v!.isEmpty){
                    return 'should not be empty';
                  }
                  return null;
                },
                controller: productName,
                hint: 'enter product name',
                onsubmit: (value) {
                  productName.text = value;
                },
              ),

              EditField(
                lines: 5,
                validator: (String? v){
                  if(v!.isEmpty){
                    return 'should not be empty';
                  }
                  return null;
                },
                controller: detailC,
                hint: 'enter detail',
                onsubmit: (value) {
                  detailC.text = value;
                },
              ),

              EditField(
                lines: 1,
                validator: (String? v){
                  if(v!.isEmpty){
                    return 'should not be empty';
                  }
                  return null;
                },
                controller: serialCode,
                hint: 'enter serial code',
                onsubmit: (value) {
                  serialCode.text = value;
                },
              ),
              EditField(
                lines: 1,
                validator: (String? v){
                  if(v!.isEmpty){
                    return 'should not be empty';
                  }
                  return null;
                },
                controller: priceC,
                hint: 'enter price ',
                onsubmit: (value) {
                  priceC.text = value;
                },
              ),
              EditField(
                lines: 1,
                validator: (String? v){
                  if(v!.isEmpty){
                    return 'should not be empty';
                  }
                  return null;
                },
                controller: weightC,
                hint: 'enter weight ',
                onsubmit: (value) {
                  weightC.text = value;
                },
              ),

              EditField(
                lines: 1,
                validator: (String? v){
                  if(v!.isEmpty){
                    return 'should not be empty';
                  }
                  return null;
                },
                controller: brandC,
                hint: 'enter brand name',
                onsubmit: (value) {
                  brandC.text = value;
                },
              ),

              EditField(
                lines: 1,
                validator: (String? v){
                  if(v!.isEmpty){
                    return 'should not be empty';
                  }
                  return null;
                },
                controller: quantityC,
                hint: 'enter quantity ',
                onsubmit: (value) {
                  quantityC.text = value;
                },
              ),
             Container(
               height: 250,
               child: Column(
                 children: [
                   ElevatedButton(
                       onPressed: (){
                         loadAssets();
                       },
                       child: const Text('pick image')
                   ),
                   Expanded(
                       child: buildGrdiView(),
                   )
                 ],
               ),
             ),

             SwitchListTile(
               title: const Text('is this product popular'),
                 value: isPopular,
                 onChanged: (v){
                   setState(() {
                     isPopular = v;
                   });
                 }
             ),

              SwitchListTile(
                  title: const Text('is this on Sale'),
                  value: isSale,
                  onChanged: (v){
                    setState(() {
                      isSale = v;
                    });
                  }
              ),

              MaterialButton(
                shape: StadiumBorder(),
                onPressed: () {
                save();
                
              },
                child:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('upload product', style: heading1,),
                ),
                color: primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
  loadAssets() async {
    List<Asset> resultImages = <Asset>[];
    String error = 'something  went wrong';

    try {
      resultImages = await MultiImagePicker.pickImages(
          maxImages: 10,
          enableCamera: true,
          selectedAssets: images
      );

      setState(() {
        images = resultImages;
      });
    } catch (e) {
      error = e.toString();
      print(error);
    }
  }

 Future postImages(Asset imagefile)async{
    String filename = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseStorage db = FirebaseStorage.instance;
    await db.
    ref().
    child('images').
    child(filename).
    putData((await imagefile.getByteData()).buffer.asUint8List());

    return db.ref().child('images').child(filename).getDownloadURL();
  }

  uploadImage() async{
    for(var image in images){
      await postImages(image).then((downloadUrl){
        imagesUrls.add(downloadUrl.toString());
      }).catchError((e){

        print(e.toString());

      });
    }
  }



  Widget buildGrdiView(){
    return Container(
      width: double.infinity,
      decoration: decoration(),
      child:images.length== 0? IconButton(

        onPressed: (){

          loadAssets();

        },
        icon: const Icon(Icons.add),
      ):
          GridView.count(crossAxisCount: 3,
            children: List.generate(images.length, (index){
              Asset asset = images[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    child: AssetThumb(
                        asset: asset,
                        width: 150,
                        height: 150
                    )
                ),
              );
            }),
          ),
    );
  }
}

class EditField extends StatelessWidget {
  String hint;
  void Function(String)? onsubmit;

  final FormFieldValidator<String>? validator;

  TextEditingController controller;
  int lines;
  EditField(
      {required this.hint, required this.onsubmit, required this.controller, required this.validator, required this.lines});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
          decoration: decoration(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormField(
              maxLines:lines ,
              validator: validator,
              controller: controller,
              onFieldSubmitted: onsubmit,
              decoration:
                  InputDecoration(hintText: hint, border: InputBorder.none),
            ),
          )),
    );
  }
}
