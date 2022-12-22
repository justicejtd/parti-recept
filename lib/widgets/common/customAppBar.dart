import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:partirecept/services/authService.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget{
  late final AuthService? _authService;

  CustomAppBar({Key? key, AuthService? authService}) : super(key: key) {
    _authService = authService;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image(
            image: AssetImage('assets/images/logo.png'),
            width: 50,
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Column(children: [
                Text(
                  "Partirecept",
                  textAlign: TextAlign.left,
                ),
                Text('Woensel welcomes you!',
                    textAlign: TextAlign.right,
                    style:
                        GoogleFonts.kalam(fontSize: 10, color: Colors.white)),
              ]))
        ],
      ),
      actions: _authService != null
          ? <Widget>[
              IconButton(
                  onPressed: () async => (await _authService?.signOut()),
                  icon: Icon(Icons.logout))
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
