import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controller/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            SizedBox(
              height: 50,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xff3A3A6A).withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(90)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Consumer<HomeController>(builder: (BuildContext context, value, Widget? child) { 
                      return  InkWell ( onTap: value.getCurrentLoaction ,child: Icon(FontAwesomeIcons.locationDot,size: 29,))  ;
                     },
                  ),
                    Icon(FontAwesomeIcons.magnifyingGlassPlus , size: 29,),
                    Icon(FontAwesomeIcons.bars , size: 29,)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}