import 'package:flutter/material.dart';
import 'package:partirecept/constants/colors.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container (
            padding: EdgeInsets.symmetric(horizontal: 40),
            color: secondaryYellow,
            child:SingleChildScrollView (
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Image.asset('assets/images/logo.png'),
                      Text(
                        '\n About App',
                        style: TextStyle(fontSize: 30, color: primaryOrange),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                          'This is an application for food that can be found in Kruisstraat and Woenselse Markt. Here you can:\n',
                          style: TextStyle(fontSize: 18,color: primaryBlack),
                          textAlign: TextAlign.justify,
                        ),

                      Text(
                          '- Discover a wide range of recipes\n'
                          '- Share a recipe by adding it in the app\n'
                          '- Find a recipe based on its characteristics\n'
                          '- Look at where to buy ingredients for a certian recipe\n',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                      Text(
                        '\n About Team',
                        style: TextStyle(fontSize: 30, color: primaryOrange),
                        textAlign: TextAlign.center,
                      ),
                        Text(
                          'This app was developed by students from Fontys University of Applied Sciences, '
                          'between September 2021 and January 2022 as a solution for Project End Phase. '
                          'The students involved in this project are the following: \n',
                          style: TextStyle(fontSize: 18,color: primaryBlack),
                          textAlign: TextAlign.justify,
                        ),
                      Text(
                        'Boyan Kaloyanov Dechev\n'
                        'Edgaras Spirodonovas\n'
                        'Jonathan Christopher Jayakusuma\n'
                        'Joseph Zahra\n'
                        'Justice Dreischor\n'
                        'Plamen Lakov\n',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),

                    ]))));
  }
}