import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  GlobalKey<FormState> _signInKey = GlobalKey();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final RegExp emailValid = RegExp(r'^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Twitter'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Form(
        key: _signInKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              validator: (value) {
                if (!emailValid.hasMatch(value as String)) {
                  return 'Please Enter a valid Email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              validator: (value){
                if(value!.isEmpty || value.length < 6){
                  return "Please Enter a correct password";
                }
                return null;
              },
            ),
            ElevatedButton(onPressed: () {
              if (_signInKey.currentState!.validate()) {
                debugPrint('Email: ${_emailController.text}');
                debugPrint('Password: ${_passwordController.text}');
              }
            }, child: Text('SignIn'))
          ],
        ),
      ),
    );
  }
}
