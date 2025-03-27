import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/local_storage_service.dart';
import 'package:flutter_application_1/view/activity_views/activity_screen.dart';
import 'package:flutter_application_1/view/dashboards_screen.dart';
import 'package:flutter_application_1/view/indicator_screen.dart';
import 'package:flutter_application_1/view/login_screen.dart';
import 'package:flutter_application_1/view/reglement_screen.dart';
import 'package:flutter_application_1/view/sales_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        title: const Row(
          children: [
            Text(
              " Bonjour ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 5),
            Text(
              "Manel  👋",
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
        actions: [
         
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              radius: 18,
              child: Text(
                "Dev",
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          const Text(
            "Smart Pilot",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.count(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _buildMenuCard(
                        icon: Icons.show_chart,
                        label: "Activité",
                        ontap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder:(x){
                            return const ActivityScreen(); 
                          }));
                        }
                      
                      ),
                      _buildMenuCard(
                        icon: Icons.request_page_outlined,
                        label: "Règlements",
                        ontap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder:(x){
                            return const ReglementScreen(); 
                          }));
                        }
                      ),
                      _buildMenuCard(
                        icon: Icons.attach_money,
                        label: "Vente du jour",
                        ontap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder:(x){
                            return const SalesScreen(); 
                          }));
                        }
                      ),
                      _buildMenuCard(
                        icon: Icons.pie_chart_outline_sharp,
                        label: "Dashboards",
                        ontap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder:(x){
                            return const DashboardsScreen(); 
                          }));
                        }
                      ), 
                      _buildMenuCard(
                        icon: Icons.gas_meter_outlined,
                        label: "indicateur persos",
                        ontap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder:(x){
                            return const IndicatorScreen(); 
                          }));
                        }
                      ),
                      _buildMenuCard(
                        icon: Icons.logout_rounded,
                        label: "logout",
                        ontap: (){
                          LocalStorageService().deleteApiKey();
                          Navigator.of(context).push(MaterialPageRoute(builder:(x){
                            return const LoginScreen(); 
                        
                          }));
                        }

                      ),

                    ],
                  ),
                  
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard({required IconData icon, required String label,required GestureTapCallback? ontap }) {

  

    return InkWell(
      onTap: ontap,
      child: Card(
        color: Colors.blue.shade50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.black87),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
