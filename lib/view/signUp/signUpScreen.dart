import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:labelize/view/passwordReset/PasswordReset.dart';
import 'package:labelize/view/signIn/signInScreen.dart';
import 'package:labelize/widgets/CustomToast.dart';

import '../../project_theme.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/sign-up';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool visibility = true;
  bool isLoggingIn = false;
  bool checkedValue = false;
  bool checkUser = false;

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return ColorfulSafeArea(
      color: Colors.white,
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign Up',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: _height * 0.06,
              ),
              buildSocialLogin(),
              buildForm(),
              buildButtons(context)
            ],
          ),
        ),
      )),
    );
  }

  Widget buildSocialLogin() {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          height: _height * 0.07,
          width: _width * .82,
          child: FlatButton.icon(
            label: Text(
              'Sign in with Facebook',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            icon: ImageIcon(
              AssetImage(
                'assets/fb.png',
              ),
              color: Colors.white,
            ),
            color: Color(0xFF1877F2),
            onPressed: () {},
          ),
        ),
        SizedBox(
          height: _height * 0.02,
        ),
        Container(
          height: _height * 0.07,
          width: _width * .82,
          child: FlatButton.icon(
            label: Text(
              'Sign in with Google',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            icon: ImageIcon(
              AssetImage(
                'assets/g.png',
              ),
              color: Colors.white,
            ),
            color: Color(0xFFF14336),
            onPressed: () {},
          ),
        ),
        SizedBox(
          height: _height * .06,
        )
      ],
    );
  }

  Widget buildForm() {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email',
            style: TextStyle(color: Color(0xFF8F92A1), fontSize: 12),
          ),
          TextFormField(
            controller: _emailController,
            validator: (value) {
              if (value.isEmpty) return 'Please enter some text';
              return null;
            },
            decoration: InputDecoration(
                prefixIcon: ImageIcon(
                  AssetImage(
                    'assets/email.png',
                  ),
                  color: Colors.black,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF4DD942),
                  ),
                ),
                fillColor: Colors.red[900],
                // hintText: 'Username',
                contentPadding: EdgeInsets.only(top: 20, left: 100)),
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            'Username',
            style: TextStyle(color: Color(0xFF8F92A1), fontSize: 12),
          ),
          TextFormField(
            controller: _userController,
            validator: (value) {
              if (value.isEmpty) return 'Please enter some text';
              return null;
            },
            decoration: InputDecoration(
                prefixIcon: ImageIcon(
                  AssetImage(
                    'assets/user.png',
                  ),
                  color: Colors.black,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF4DD942),
                  ),
                ),
                fillColor: Colors.red[900],
                // hintText: 'Username',
                contentPadding: EdgeInsets.only(top: 20, left: 40)),
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            'Password',
            style: TextStyle(color: Color(0xFF8F92A1), fontSize: 12),
          ),
          TextFormField(
            style: TextStyle(letterSpacing: 5),
            obscureText: visibility,
            controller: _passwordController,
            validator: (value) {
              if (value.isEmpty) return 'Password';
              return null;
            },
            decoration: InputDecoration(
              prefixIcon: ImageIcon(
                AssetImage(
                  'assets/pass.png',
                ),
                color: Colors.black,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF4DD942),
                ),
              ),
              fillColor: Colors.red[900],
              // hintText: 'Password',
              contentPadding: EdgeInsets.only(top: 20),
              suffixIcon: IconButton(
                icon: visibility
                    ? Icon(
                        Icons.visibility,
                        color: Colors.black,
                      )
                    : Icon(
                        Icons.visibility_off_rounded,
                        color: Colors.blue,
                      ),
                onPressed: visibilePassword,
              ),
            ),
          ),
          CheckboxListTile(
              title: Text(
                  'By creating an account, you agree to our Term & Conditions'),
              activeColor: Colors.indigo,
              value: checkedValue,
              onChanged: (bool newValue) {
                setState(() {
                  checkedValue = newValue;
                });
              },
              controlAffinity: ListTileControlAffinity.leading),
          SizedBox(
            height: _height * 0.06,
          )
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
            height: _height * 0.07,
            width: _width * .82,
            child: FlatButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  if (checkedValue == true) {
                    setState(() {
                      isLoggingIn = true;
                    });
                  } else {
                    customToast(text: "Confirm Agreement");
                  }
                }
              },
              color: ProjectTheme.projectPrimaryColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Icon(
                      Icons.east,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            )),
        SizedBox(
          height: _height * .02,
        ),
        InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Already have Account? '),
              Text(
                'Sign In',
                style: TextStyle(
                    color: ProjectTheme.projectPrimaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, SignInScreen.routeName);
          },
        ),
        SizedBox(
          height: _height * .08,
        ),
        InkWell(
          child: Text(
            'Forgot Password',
            style: TextStyle(color: Color(0xFF8297D1), fontSize: 15),
          ),
          onTap: () {
            Navigator.pushNamed(context, PasswordResetScreen.routeName);
          },
        )
      ],
    );
  }

  visibilePassword() {
    setState(() {
      if (visibility)
        visibility = false;
      else
        visibility = true;
    });
  }
}