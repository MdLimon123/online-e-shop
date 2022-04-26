
import 'package:fluttertoast/fluttertoast.dart';

class CarouselItems{
 String images;
 String text;

 CarouselItems({required this.images, required this.text});

}

List carousel = [
 CarouselItems(
     images:  'https://cdn.pixabay.com/photo/2016/06/25/12/48/go-pro-1478810_960_720.jpg',
     text: 'Accessories'
 ),
 CarouselItems(
     images:'https://cdn.pixabay.com/photo/2016/06/25/12/48/go-pro-1478810_960_720.jpg',
     text: 'AutoMobiles'
 ),
 CarouselItems(
     images:'https://cdn.pixabay.com/photo/2015/12/06/18/28/capsules-1079838_960_720.jpg',

     text: 'Beauty and Health',
 ),

 CarouselItems(
     images:'https://cdn.pixabay.com/photo/2016/06/25/12/48/go-pro-1478810_960_720.jpg',
     text: 'Accessories'
 ),
 CarouselItems(
  images:
  'https://cdn.pixabay.com/photo/2016/06/25/12/48/go-pro-1478810_960_720.jpg',
  text: 'AutoMobiles',
 ),
 CarouselItems(
  images:
  'https://cdn.pixabay.com/photo/2015/12/06/18/28/capsules-1079838_960_720.jpg',
  text: 'Beauty and Health',
 ),

];

displayMessage(String msg){
 Fluttertoast.showToast(msg: msg);
}



