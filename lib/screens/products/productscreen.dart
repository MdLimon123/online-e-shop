import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop_online/screens/products/product_detail.dart';
import 'package:e_shop_online/utils/custom_color.dart';
import 'package:e_shop_online/utils/decoration.dart';
import 'package:e_shop_online/utils/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductScreen extends StatefulWidget {

  static const id = '/productpage';

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>{

  bool isFavorite = false;
  List favorites = [];

  @override
  Widget build(BuildContext context) {

    final data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
     var category = data['category'];
     FirebaseFirestore db = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title:  Text(category),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            bottomLeft:Radius.circular(10)
          )
        ),
      ),
      body: StreamBuilder(
        stream: db.collection('products').where('category', isEqualTo: category).
        snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError){
            Fluttertoast.showToast(msg: 'error');
          }
          if(snapshot.connectionState == ConnectionState.waiting){
           return const CircularProgressIndicator();
          }
          if(!snapshot.hasData){
            return const CircularProgressIndicator();
          }
          final values = snapshot.data!.docs;

          return values.length>0?
            GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2
          ),
            itemCount: values.length,
              itemBuilder: (BuildContext context, int index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){

                    Navigator.of(context).pushNamed(ProductDetailPage.id,
                        arguments: {
                          'productname': values[index]['productName'],
                          'description':values[index]['detail'],
                          'brand' : values[index]['brandName'],
                          'images': values[index]['imagesUrl'],
                          'isOnSale' : values[index]['isOnSale'],
                          'isPopular': values[index]['isPopular'],
                          'price' : values[index]['price'],
                          'quantity' : values[index]['quantity'],
                          'serialCode' : values[index]['serialCode'],
                          'weight' : values[index]['weight'],
                        }
                    );

                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: decoration(),
                   child: Stack(
                     children: [
                       ClipRRect(
                         borderRadius: BorderRadius.circular(10),
                           child: Image(
                             image: CachedNetworkImageProvider(
                                 values[index]['imagesUrl'][0]
                             ),
                           )

                         // child: Image.network(values[index]['imagesUrl'][0],
                         // fit: BoxFit.cover,
                         //   height: 200,
                         //   width: 200,
                         // ),
                       ),
                       Positioned(
                         bottom: 0,
                         left: 0,
                         right: 0,
                         child: Container(
                           height: 40,
                           decoration: const BoxDecoration(
                             color: Colors.black87,
                           ),
                           child: Center(
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [
                                 Expanded(
                                     child: Text(values[index]['productName'],
                                   textAlign: TextAlign.center,
                                   style: const TextStyle(color: Colors.white,
                                   fontSize: 15),
                                 )
                                 ),
                                 Expanded(child: IconButton(
                                       onPressed: (){},
                                       icon: Icon(FontAwesomeIcons.cartPlus,),
                                   color: white,
                                   iconSize: 20,
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ),
                       )
                     ],
                   ),
                  ),
                ),
              );
              }
          ):
              Center(
                child: Text('no product found',style: heading2,),
              );
        },
      ),
    );
  }
}
