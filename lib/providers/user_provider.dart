// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:twitter/Models/user.dart';

final userProvider = StateNotifierProvider<userNotifier, LocalUser>((ref) {
  return userNotifier();
});

class LocalUser {
  const LocalUser({required this.id, required this.user});
  final String id;
  final FirebaseUser user;

  LocalUser copyWith({
    String? id,
    FirebaseUser? user,
  }) {
    return LocalUser(
      id: id ?? this.id,
      user: user ?? this.user,
    );
  }
}

class userNotifier extends StateNotifier<LocalUser> {
  userNotifier()
      : super(LocalUser(
            id: 'error',
            user: FirebaseUser(
                email: 'error', name: 'No Name', proofilePic: 'error')));
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> login(String email) async {
    QuerySnapshot response = await _fireStore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (response.docs.isEmpty) {
      print('No firestore user associated to the authenticated email $email');
      return;
    }
    if (response.docs.length != 1) {
      print(
          'More than one firestore user is associated to the authenticated email $email');
      return;
    }   
    state = LocalUser(
        id: response.docs[0].id,
        user: FirebaseUser.fromMap(
            response.docs[0].data() as Map<String, dynamic>));
  }

  Future<void> signup(String email) async {
    DocumentReference response = await _fireStore.collection('users').add(
          FirebaseUser(
                  email: email,
                  name: 'No Name',
                  proofilePic:
                      'https://i.sstatic.net/34AD2.jpg')
              .toMap(),
        );
    DocumentSnapshot snapshot = await response.get();
    state = LocalUser(
        id: response.id,
        user: FirebaseUser.fromMap(snapshot.data() as Map<String, dynamic>));
  }

  Future<void> update(String name) async {
    await _fireStore.collection('users').doc(state.id).update({'name':name});
    state = state.copyWith(user: state.user.copyWith(name: name)); 
  }
  

  void logout() {
    state = LocalUser(
        id: 'error',
        user: FirebaseUser(
            email: 'error', name: 'error', proofilePic: 'error'));
  }
}
