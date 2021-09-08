import 'package:firebase_auth/firebase_auth.dart';
import 'package:firelearn/screens/home_screen.dart';
import 'package:firelearn/screens/register_screen.dart';
import 'package:firelearn/services/auth_service.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCont = TextEditingController();

  TextEditingController passwordCont = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            TextField(
              controller: emailCont,
              decoration: InputDecoration(
                labelText: "Email",
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              obscureText: true,
              controller: passwordCont,
              decoration: InputDecoration(
                labelText: "Password",
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            isLoading
                ? CircularProgressIndicator()
                : Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        if (emailCont.text == '' || passwordCont == '') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('All Fields are required')));
                        } else {
                          User result = await AuthService().login(
                              emailCont.text, passwordCont.text, context);

                          if (result != null) {
                            print('success');
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                                (route) => false);
                          }
                        }

                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                      (route) => false);
                },
                child: Text('Don\'t have a account ?  Register here'))
          ],
        ),
      ),
    );
  }
}
