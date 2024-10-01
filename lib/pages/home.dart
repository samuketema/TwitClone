import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/Models/tweet.dart';
import 'package:twitter/pages/post_tweet.dart';
import 'package:twitter/pages/settings.dart';
import 'package:twitter/providers/tweets_provider.dart';
import 'package:twitter/providers/user_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LocalUser currentUser = ref.watch(userProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => PostTweetPage()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        bottom: PreferredSize(preferredSize: Size.fromHeight(4.0) , child: Container(
          color: Colors.black,
          height: 1,
        )),
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
        title: Icon(FontAwesomeIcons.twitter ,color: Colors.blue,size: 30,),
      ),
      body: ref.watch(feedProvider).when(
          data: (List<Tweet> tweets) {
            return ListView.separated(
              separatorBuilder: (context , index) => Divider(
                color: Colors.black,
              ),
                itemCount: tweets.length, 
                itemBuilder: (context, count) {
                  return ListTile(
                    leading: CircleAvatar(foregroundImage: NetworkImage(tweets[count].profilePic),),
                    title: Text(tweets[count].name,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(tweets[count].tweet),
                  );
                });
          },
          error: (error, stackTrace) => Center(
                child: Text('Error'),
              ),
          loading: () {
            return CircularProgressIndicator();
          }),
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
