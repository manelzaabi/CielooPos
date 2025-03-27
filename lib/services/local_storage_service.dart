import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
      final dolibarr_api_key = 'dolibarr_api_key';
      final user_id_key = 'dolibarr_api_key';

  
  Future<void> saveApiKey(String apiKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(dolibarr_api_key, apiKey);  
  }

  Future<void> deleteApiKey () async {
    final prefs = await SharedPreferences.getInstance();
   final didLogout = await  prefs.remove(dolibarr_api_key);
   print(didLogout);  
  }

  
  Future<String?> getApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(dolibarr_api_key);  
  }

  Future<void> saveUserId(String apiKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(user_id_key, apiKey);  
  }

}
