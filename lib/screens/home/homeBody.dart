import 'package:flutter/material.dart';
import 'package:partirecept/constants/colors.dart';
import 'package:partirecept/themes/TextThemeOswald.dart';
import 'package:partirecept/widgets/recipe/recipePageView.dart';
import 'package:partirecept/screens/bodies/filterBody.dart';
import 'package:partirecept/providers/providers.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeBody extends ConsumerWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(children: [
              Expanded(
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 150,
                  height: 150,
                ),
              )
            ]),
            Row(children: [
              Expanded(
                child: Text(
                  'This week',
                  textAlign: TextAlign.center,
                  style: TextThemeOswald(Colors.black).headline3,
                ),
              ),
            ]),
            Row(children: [
              Expanded(
                child: Text(
                  'In Woensel, Eindhoven',
                  textAlign: TextAlign.center,
                  style: TextThemeOswald(Colors.black).subtitle1,
                ),
              ),
            ]),
            Column(children: [
              Row(children: [
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          ref
                              .read(bottomNavigationIndexCounterStateProvider
                                  .state)
                              .state = 0;
                          ref
                              .read(bottomNavigationStateNotifier.notifier)
                              .changeBody(FilterBody());
                        },
                        child: Row(children: [
                          Icon(
                            Icons.filter_alt,
                            color: primaryOrange,
                            size: 40,
                          ),
                          Text("Filter recipes",
                              style: TextThemeOswald(primaryOrange).subtitle1),
                          Align(
                            alignment: Alignment.center,
                          )
                        ]))),
              ]),
              Row(children: [
                Expanded(
                  child: RecipePageView(),
                ),
              ])
            ]),
            Row(children: [
              SizedBox(
                height: 50,
              )
            ]),
          ],
        )));
  }
}
