import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/pages/settings.dart';
import 'package:twitter/providers/user_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LocalUser currentUser = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: Builder(builder: (context) {
          return GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(currentUser.user.proofilePic),
              ),
            ),
          );
        }),
        title: Text('Home Page'),
      ),
      body: Column(children: [
        Text(currentUser.user.name),
        Text(currentUser.user.email),
      ]),
      drawer: Drawer(
        child: Column(
          children: [
            Image.network(currentUser.user.proofilePic),
            ListTile(
              title: Text(
                "Welcome ${currentUser.user.name}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            ListTile(
                title: Text('settings'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Setting()));
                }),
            ListTile(
              title: Text('Sign out'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                ref.read(userProvider.notifier).logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
