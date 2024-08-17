import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20,10),

              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter Your Email',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 25)
                ),
                controller: _emailController,
                validator: (value) {
                  if (!emailValid.hasMatch(value as String)) {
                    return 'Please Enter a valid Email';
                  }
                  return null;
                },
              ),
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
