import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/activity_views/comparatif_view.dart';
import 'package:flutter_application_1/view/activity_views/hit_parade_view.dart';
import 'package:flutter_application_1/view/activity_views/ticket_screen.dart';
import 'package:flutter_application_1/view/custom_app_bar.dart';


class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: const CustomAppBar(),
       body: DefaultTabController(
        length: 3,

         child:  Column(children: [
        const TabBar(tabs: [
          Tab(text: "hit parade",),
          Tab(text: "comparatif",),
           Tab(text: "ticket",)
          ], ),
          Expanded(
            child: TabBarView(children: [
              const HitParadeView(),
              const ComparatifView(), 
              TicketScreen(),           
            ]),
          )
         ],
         
         
         ),
       ),
    );
  }
}