import 'package:shared_preferences/shared_preferences.dart';

class GetRepository {
  static int? UID;
  Future<int?> check() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UID = prefs.getInt("LogedBefore");
    print("$UID --)))_)))__");
  }
}
