import 'package:flutter/material.dart';

class PageLoader extends StatelessWidget{
  const PageLoader({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset("assets/images/jobLoader.gif"),),
    );
  }
}