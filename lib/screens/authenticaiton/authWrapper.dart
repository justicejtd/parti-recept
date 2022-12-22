import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partirecept/providers/providers.dart';
import 'package:partirecept/screens/home/homePage.dart';
import 'package:partirecept/screens/landing/landingPage.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen for changes for auth changes
    // If user is authenticated go to home else go to landingPage
    final userStream = ref.watch(firebaseUserStreamProvider);
    return userStream.when(
      loading: () => Text('Loading'),
      error: (_, e) => Text('Error: $e'),
      data: (data) => data == null ? LandingPage() : HomePage(),
    );
  }
}
