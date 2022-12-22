import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partirecept/constants/colors.dart';
import 'package:partirecept/providers/providers.dart';
import 'package:partirecept/screens/bodies/help.dart';
import 'package:partirecept/screens/home/homeBody.dart';
import 'package:partirecept/screens/bodies/qrBody.dart';
import 'package:partirecept/screens/myRecipe/myRecipe.dart';
import 'package:partirecept/widgets/map/map.dart';

class BottomNavigation extends ConsumerWidget {
  const BottomNavigation({Key? key}) : super(key: key);
  // List of bodies/pages for the bottom navigation
  static List<Widget> _pageBodies = <Widget>[
    HomeBody(),
    MapBody(),
    MyRecipe(),
    Qrbody(),
    HelpPage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(bottomNavigationIndexCounterStateProvider);

    return BottomNavigationBar(
      selectedItemColor: Colors.yellow, // Secondary yellow is too dark
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: primaryOrange,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Maps',
          backgroundColor: primaryOrange,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.create,
          ),
          label: 'My recipes',
          backgroundColor: primaryOrange,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code_2),
          label: 'QR',
          backgroundColor: primaryOrange,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.quiz),
          label: 'Help',
          backgroundColor: primaryOrange,
        )
      ],
      currentIndex: index,
      onTap: (index) => _onItemTapped(index, ref),
    );
  }

  void _onItemTapped(int index, WidgetRef ref) {
    ref.read(bottomNavigationIndexCounterStateProvider.state).state = index;
    ref
        .read(bottomNavigationStateNotifier.notifier)
        .changeBody(_pageBodies[index]);
  }
}
