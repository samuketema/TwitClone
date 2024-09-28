import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/providers/user_provider.dart';

class Setting extends ConsumerStatefulWidget {
  const Setting({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingState();
}

class _SettingState extends ConsumerState<Setting> {
  TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    LocalUser currentUser = ref.watch(userProvider);
    _nameController.text = currentUser.user.name;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Settings'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CircleAvatar(foregroundImage: NetworkImage(ref.watch(userProvider).user.proofilePic),),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Enter your name'),
            ),
            TextButton(onPressed: (){
             ref.read(userProvider.notifier).update(_nameController.text);
            }, child: Text('Update Name'))
          ],
        ),
      ),
    );
  }
}
