import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partirecept/constants/colors.dart';
import 'package:partirecept/providers/authProviders.dart';
import 'package:partirecept/themes/TextThemeOswald.dart';
import 'package:partirecept/widgets/Container/backgroundImageContainer.dart';
import 'package:partirecept/widgets/Form/customTextField.dart';

import 'authViewModel.dart';

class LoginPage extends ConsumerWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final double _padding = 8.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authViewModel = ref.watch(authVMProvider);
    final authErrorMsg = ref.watch(authErrorMsgStateProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: BackgroundImageContainer(
        assetImage: "assets/images/lemons.jpg",
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 56, 0, 0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              'Login',
                              textAlign: TextAlign.center,
                              style: TextThemeOswald(Colors.white).headline2,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(_padding),
                            child: CustomTextField(
                              key: Key("customTFEmail"),
                              label: 'Email',
                              inputTextStyle:
                                  TextThemeOswald(Colors.black).bodyText1,
                              labelTextStyle:
                                  TextThemeOswald(Colors.black).bodyText1,
                              backgroundColor: Colors.white,
                              validator: authViewModel.emailValidator,
                              onChanged: (input) =>
                                  authViewModel.onEmailChange(input),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(_padding),
                            child: CustomTextField(
                              key: Key("customTFPassword"),
                              label: 'Password',
                              inputTextStyle:
                                  TextThemeOswald(Colors.black).bodyText1,
                              labelTextStyle:
                                  TextThemeOswald(Colors.black).bodyText1,
                              backgroundColor: Colors.white,
                              obscure: true,
                              validator: authViewModel.passwordLoginValidator,
                              onChanged: (input) =>
                                  authViewModel.onPasswordChange(input),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: secondaryYellow),
                        onPressed: () =>
                            _validateLogin(context, authViewModel, ref),
                        child: const Text('Login')),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      authErrorMsg,
                      style: TextThemeOswald(Colors.red).bodyText1,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text('No account? Signup here'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _validateLogin(
      BuildContext context, AuthViewModel authViewModel, WidgetRef ref) async {
    final msgController = ref.read(authErrorMsgStateProvider.state);
    final FormState? form = _formKey.currentState;

    if (form!.validate()) {
      User? user = await authViewModel.login();

      if (user == null) {
        msgController.state = 'Incorrect email or password';
      } else {
        // Pop login screen
        Navigator.pop(context);
      }
    }
  }
}
