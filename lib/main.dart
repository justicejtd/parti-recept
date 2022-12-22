import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:partirecept/constants/colors.dart';
import 'package:partirecept/screens/authenticaiton/authWrapper.dart';
import 'package:partirecept/screens/authenticaiton/loginPage.dart';
import 'package:partirecept/screens/authenticaiton/registrationPage.dart';
import 'package:partirecept/screens/home/homePage.dart';
import 'package:partirecept/screens/landing/landingPage.dart';
import 'package:partirecept/themes/TextThemeOswald.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PartiRecept',
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: primaryOrange),
        primaryColor: primaryOrange,
        splashColor: secondaryYellow,
        iconTheme: IconThemeData(color: Colors.black),
        buttonTheme: ButtonThemeData(buttonColor: secondaryYellow),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: GoogleFonts.poppins().fontFamily,
        textTheme: TextThemeOswald(Colors.white),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: secondaryYellow),
      ),
      initialRoute: '/authWrapper',
      routes: {
        '/authWrapper': (context) => AuthWrapper(),
        '/landing': (context) => LandingPage(),
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegistrationPage(),
      },
    );
  }
}
