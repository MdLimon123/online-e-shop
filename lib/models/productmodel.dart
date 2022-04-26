import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel{
  String category;
  String productName;
  String detail;
  String serialCode;
  int price;
  String weight;
  String brandName;
  int quantity;
  List<String> imagesUrl;
  bool isOnSale;
  bool isPopular;

  ProductModel({
   required this.category,
    required this.productName,
    required this.detail,
   required this.serialCode,
   required this.price,
   required this.weight,
   required this.brandName,
   required this.quantity,
   required this.imagesUrl,
   required this.isOnSale,
   required this.isPopular
  });

  CollectionReference db = FirebaseFirestore.instance.collection('products');

  Future<void> addProduct(ProductModel productModel) async{
    Map<String, dynamic> data = {

      'category': productModel.category,
      'productName': productModel.productName,
      'detail': productModel.detail,
      'serialCode': productModel.serialCode,
      'price': productModel.price,
      'weight': productModel.weight,
      'brandName': productModel.brandName,
      'quantity': productModel.quantity,
      'imagesUrl': productModel.imagesUrl,
      'isOnSale': productModel.isOnSale,
      'isPopular': productModel.isPopular,
    };
    await db.add(data);

  }


  Future<void> updateProduct(String id, ProductModel updateProduct) async{
    Map<String, dynamic> data = {

      'category': updateProduct.category,
      'productName': updateProduct.productName,
      'detail': updateProduct.detail,
      'serialCode': updateProduct.serialCode,
      'price': updateProduct.price,
      'weight': updateProduct.weight,
      'brandName': updateProduct.brandName,
      'quantity': updateProduct.quantity,
      'imagesUrl': updateProduct.imagesUrl,
      'isOnSale': updateProduct.isOnSale,
      'isPopular': updateProduct.isPopular,
    };
    await db.doc(id).update(data);

  }

  Future<void> delete(String id) async{
    await db.doc(id).delete();
  }
}