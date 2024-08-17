import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'signup_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> _signInKey = GlobalKey();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final RegExp emailValid = RegExp(
      r'^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _signInKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.twitter,
              color: Colors.blue,
              size: 70,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'SinIn to Twitter',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'Enter Your Email',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 15)),
                controller: _emailController,
                validator: (value) {
                  if (!emailValid.hasMatch(value as String)) {
                    return 'Please Enter a valid Email';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'Enter Your Password',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 15)),
                controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty || value.length < 6) {
                    return "Please Enter a correct password";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue,
              ),
              width: 300,
              child: TextButton(
                onPressed: () {
                  if (_signInKey.currentState!.validate()) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignupPage()));
                  }
                },
                child: Text(
                  'SignIn',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            TextButton(
              onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignupPage()));},
              child: Text("Dont have an account? Sign up here."),
            )
          ],
        ),
      ),
    );
  }
}
