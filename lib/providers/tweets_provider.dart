
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/Models/tweet.dart';
import 'package:twitter/providers/user_provider.dart';


final tweetProvider = Provider<TweetApi>((ref) {
  return TweetApi(ref);
});

class TweetApi{
  Ref ref;
  TweetApi(this.ref);
FirebaseFirestore _storage = FirebaseFirestore.instance;
  Future<void> postTweet(String tweet)async{
    LocalUser currentUser = ref.read(userProvider);
    await _storage.collection('tweets').add(Tweet(uid: currentUser.id, profilePic: currentUser.user.proofilePic, name: currentUser.user.name, tweet: tweet, timestamp: Timestamp.now()).toMap());
  }
}