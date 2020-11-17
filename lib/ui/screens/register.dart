import 'package:flutter/material.dart';
import 'package:kedatonkomputer/ui/screens/home_page.dart';
import 'package:kedatonkomputer/ui/widget/button.dart';
import 'package:kedatonkomputer/ui/widget/form.dart';
import 'package:kedatonkomputer/ui/widget/text.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleText("REGISTER"),
              SizedBox(height: 32),
              TextFieldBorderBottom(
                textHint: "Nama",
              ),
              SizedBox(height: 16),
              TextFieldBorderBottom(
                textHint: "Email",
              ),
              SizedBox(height: 16),
              TextFieldBorderBottom(
                textHint: "Username",
              ),
              SizedBox(height: 16),
              TextFieldBorderBottom(
                textHint: "Password",
              ),
              SizedBox(height: 16),
              RaisedButtonPrimary(
                text: "Daftar",
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => HomePage()
                )),
              ),
              SizedBox(height: 32),
              FlatButton(
                onPressed: () => Navigator.pop(context), 
                child: Text("Login")
              )
            ],
          ),
        )
      ),
    );
  }
}