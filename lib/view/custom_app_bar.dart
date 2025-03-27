import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/home_screen.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
       return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder:(x){
                            return const HomeScreen(); 
                          }));
              },
              child: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                radius: 18,
                child: const Text(
                  "Dev",
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                
              ),
            ),
          ),
        ],
      );  }
}