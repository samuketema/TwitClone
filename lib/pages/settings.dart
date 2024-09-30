import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
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
            GestureDetector(
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
// Pick an image.
                  final XFile? pickedImage = await picker.pickImage(
                      source: ImageSource.gallery, requestFullMetadata: false);
                  if (pickedImage != null) {
                    ref.read(userProvider.notifier).updateImage(File(pickedImage.path));
                  }
                      
                },
                child: CircleAvatar(
                  radius: 100,
                  foregroundImage:
                      NetworkImage(ref.watch(userProvider).user.proofilePic),
                )),
            SizedBox(
              height: 10,
            ),
            Center(child: Text('Tap the image to change your profile picture')),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Enter your name'),
            ),
            TextButton(
                onPressed: () {
                  ref.read(userProvider.notifier).updateName(_nameController.text);
                },
                child: Text('Update Name'))
          ],
        ),
      ),
    );
  }
}
