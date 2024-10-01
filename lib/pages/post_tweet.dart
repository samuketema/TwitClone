import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/providers/tweets_provider.dart';

class PostTweetPage extends ConsumerWidget {
  const PostTweetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController tweetController = TextEditingController();
    FirebaseFirestore _storage = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('Post a Tweet',style: TextStyle(color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(border: OutlineInputBorder()),
                controller: tweetController,
              ),
              TextButton(onPressed: (){
                ref.read(tweetProvider).postTweet(tweetController.text);
                Navigator.of(context).pop();
              }, child: Text("Post Tweet"))
            ],
          ),
        ),
      ),
    );
  }
}