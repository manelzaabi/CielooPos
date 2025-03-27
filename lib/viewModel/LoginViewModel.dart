import '../services/api_service.dart';

class LoginViewModel {
  final ApiService _apiService = ApiService();
  String errorMessage = "";

  Future<bool> login(String username, String password) async {
    try {
      final response = await _apiService.login(username, password);

      if (response.success != null && response.success!.code.toString() == "200") {
        return true;  
      } else {
        errorMessage = response.success?.message ?? "Unknown error";
        return false;  
      }
    } catch (error) {
      errorMessage = "An error occurred: $error";
      return false;  
    }
  }

   Future<void> getCurrentUSer() async {
    try {
       await _apiService.getCurrentUser();
    } catch (error) {
      errorMessage = "An error occurred: $error";
    }
  }



}
