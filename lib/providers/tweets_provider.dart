
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/Models/tweet.dart';
import 'package:twitter/providers/user_provider.dart';

final feedProvider = StreamProvider.autoDispose<List<Tweet>>((ref) {
  return FirebaseFirestore.instance.collection('tweets').orderBy('timestamp', descending: true).snapshots().map((event){
    List<Tweet> tweets = [];
    for (var i = 0; i < event.docs.length; i++) {
      tweets.add(Tweet.fromMap(event.docs[i].data()));
    }
    return tweets;
  });
});
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