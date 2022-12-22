import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partirecept/constants/colors.dart';
import 'package:partirecept/providers/providers.dart';
import 'package:partirecept/services/authService.dart';
import 'package:partirecept/widgets/common/bottomNavigation.dart';
import 'package:partirecept/widgets/common/customAppBar.dart';

class HomePage extends StatelessWidget {
  final AuthService _auth = AuthService();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: secondaryYellow,
        appBar: CustomAppBar(authService: _auth),
        bottomNavigationBar: BottomNavigation(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        body: Consumer(
          builder: (context, ref, child) {
            return ref.watch(bottomNavigationStateNotifier);
          },
        ));
  }
}
