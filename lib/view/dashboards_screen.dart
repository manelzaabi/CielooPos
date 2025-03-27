import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_response.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_application_1/view/custom_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DashboardsScreen extends StatefulWidget {
  const DashboardsScreen({super.key});

  @override
  State<DashboardsScreen> createState() => _DashboardsScreenState();
}

class _DashboardsScreenState extends State<DashboardsScreen> {

  late final  ApiService _apiService ; 
  late Future<UserResponse> _userResponse ; 
  late final WebViewController _webViewController ; 


  @override
  void initState() {
    _apiService = ApiService(); 
    _userResponse= _apiService.getCurrentUser(); 
    _webViewController = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onHttpError: (HttpResponseError error) {},
      onWebResourceError: (WebResourceError error) {},
    
    ),
  ); 
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: FutureBuilder(future: _userResponse, builder:(cntx,snapshot){
        if(snapshot.hasData){
        _webViewController.loadRequest(Uri.parse(snapshot.data!.arrayOptions!.optionsMeta!)); 
        return  WebViewWidget(controller: _webViewController,); 
        }
        else if(snapshot.hasError){
          return Center(child: Text('No Dashboard found')); 
        }
        else{
          return Center(child: CircularProgressIndicator(color: Colors.blue,)); 
        }
        
      } ),
    );
  }
}