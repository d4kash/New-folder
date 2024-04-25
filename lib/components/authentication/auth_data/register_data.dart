import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterData extends GetxController{
  RxString error = 'saddam'.obs;

  void updateState(){
    error = 'ok'.obs;
    debugPrint('Hallo 11111');
    update();
  }

  void normalState(){
    error = ''.obs;
    update();
  }

}


class RegisterDataProvider with ChangeNotifier{
  String error = '';



}