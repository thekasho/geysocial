import 'package:get_storage/get_storage.dart';

final locale = GetStorage();

class LocaleApi {

  static Future<bool> saveLoginData(Map loginData) async {
    try {
      await locale.remove("login_data");
      await locale.write("login_data", loginData);
      print("Success Save Login Data");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<Map?> getLoginData() async {
    try {
      final users = await locale.read("login_data");

      if (users != null) {
        return users;
      }
      print('login_data null');
      return null;
    } catch (e) {
      print('login_data null $e');
      return null;
    }
  }

  static Future<bool> removeLoginData() async {
    try {
      await locale.remove("login_data");
      print("Success Removed Login Data");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> saveTempVerify(Map loginData) async {
    try {
      await locale.remove("temp_verify_email");
      await locale.write("temp_verify_email", loginData);
      print("Success Save temp_verify_email Data");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<Map?> getTempVerify() async {
    try {
      final users = await locale.read("temp_verify_email");

      if (users != null) {
        return users;
      }
      print('temp_verify_email null');
      return null;
    } catch (e) {
      print('temp_verify_email null $e');
      return null;
    }
  }

  static Future<bool> removeTempVerify() async {
    try {
      await locale.remove("temp_verify_email");
      print("Success Removed temp_verify_email Data");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }


}