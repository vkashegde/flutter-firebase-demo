import 'package:firebase_auth/firebase_auth.dart';
import 'package:firelearn/screens/home_screen.dart';
import 'package:firelearn/screens/login_screen.dart';
import 'package:firelearn/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firelearn/extensions/validator.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailCont = TextEditingController();

  TextEditingController passwordCont = TextEditingController();

  TextEditingController confirmCont = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
            TextField(
              obscureText: true,
              controller: confirmCont,
              decoration: InputDecoration(
                labelText: "Confirm Password",
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
                        } else if (passwordCont.text != confirmCont.text) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Passwords don\'t match')));
                        } else {
                          User result = await AuthService().register(
                              emailCont.text, passwordCont.text, context);

                          if (result != null) {
                            print('success');
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen(result)),
                                (route) => false);
                          }
                        }

                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Text(
                        'Submit',
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
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
                },
                child: Text('Already have a account ?  Login here')),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            isLoading
                ? CircularProgressIndicator()
                : SignInButton(
                    Buttons.Google,
                    text: 'Continue with Google',
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await AuthService().signinwithgoogle();
                      setState(() {
                        isLoading = false;
                      });
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
