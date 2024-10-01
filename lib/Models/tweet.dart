// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
class Tweet {
  String uid;
  String profilePic;
  String name;
  String tweet;
  Timestamp timestamp;

  Tweet({
    required this.uid,
    required this.profilePic,
    required this.name,
    required this.tweet,
    required this.timestamp,
  });

  Tweet copyWith({
    String? uid,
    String? profilePic,
    String? name,
    String? tweet,
    Timestamp? timestamp,
  }) {
    return Tweet(
      uid: uid ?? this.uid,
      profilePic: profilePic ?? this.profilePic,
      name: name ?? this.name,
      tweet: tweet ?? this.tweet,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'profilePic': profilePic,
      'name': name,
      'tweet': tweet,
      'timestamp': timestamp,
    };
  }

  factory Tweet.fromMap(Map<String, dynamic> map) {
    return Tweet(
      uid: map['uid'] as String,
      profilePic: map['profilePic'] as String,
      name: map['name'] as String,
      tweet: map['tweet'] as String,
      timestamp: map['timestamp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Tweet.fromJson(String source) =>
      Tweet.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Tweeter(uid: $uid, profilePic: $profilePic, name: $name, tweet: $tweet, timestamp: $timestamp)';
  }

  @override
  bool operator ==(covariant Tweet other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.profilePic == profilePic &&
        other.name == name &&
        other.tweet == tweet &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        profilePic.hashCode ^
        name.hashCode ^
        tweet.hashCode ^
        timestamp.hashCode;
  }
}
