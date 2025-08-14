import 'package:flutter/cupertino.dart';


import '../service/sharedPreferance.dart';

class LocaleController extends ChangeNotifier
{


  void changeLang (String value)async{
    await PreferenceManager().setString('lang', value);
  }


  String? currentLang ='ar';
  void refrechScreen (){
    currentLang = PreferenceManager().getString("lang");
    notifyListeners();
  }
  String? get locale => currentLang;

}