import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/providers/user_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [TextButton(onPressed: () {
          FirebaseAuth.instance.signOut();
          ref.read(userProvider.notifier).logout();
        }, child: Text('Sign out'))],
      ),
      body: Center(child: Text(ref.watch(userProvider).user.email),),
    );
  }
}
