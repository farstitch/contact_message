import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  //static ga berubah2, sekali di inisialisasi maka tinggal panggil dan tidak di inisialiaasi lagi
  // static late SharedPreferences pref;
  static SharedPreferences? pref;

  // static init() async => pref = await SharedPreferences.getInstance();
  static init() async => pref = await SharedPreferences.getInstance();
}