import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:i_sense_lab_project/constants.dart';
import '../home/main.dart';

Map<String, String> users = {'dev': '123', 'q': 'q'};

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return '使用者不存在';
      }
      if (users[data.name] != data.password) {
        return '密碼錯誤';
      }
      return null;
    });
  }

  Future<String> _signUpUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (users.containsKey(data.name)) {
        return '此郵件已經被註冊過';
      }
      users[data.name] = data.password;
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return '使用者不存在';
      }
      return null;
    });
  }

  String _emailValidator(String name) {
    if (name.length == 0) {
      return "帳號不可為空";
    } else
      return null;
  }

  String _passwordValidator(String password) {
    if (password.length == 0) {
      return "密碼不可為空";
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    return FlutterLogin(
      title: 'I SENSE',
      logo: 'images/heart_icon.png',
      onLogin: _authUser,
      onSignup: _signUpUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
      },
      showDebugButtons: true,
      onRecoverPassword: _recoverPassword,
      emailValidator: _emailValidator,
      passwordValidator: _passwordValidator,
      messages: LoginMessages(
        usernameHint: "您的電子信箱",
        passwordHint: "您的密碼",
        confirmPasswordHint: "確認密碼",
        forgotPasswordButton: "忘記密碼",
        loginButton: "登入",
        signupButton: "註冊帳號",
        recoverPasswordButton: "確認",
        recoverPasswordIntro: "忘記密碼",
        recoverPasswordDescription: "輸入您註冊時的電子信箱",
        goBackButton: "返回",
        confirmPasswordError: "兩次輸入的密碼不一致",
        recoverPasswordSuccess: "已經寄送驗證信至該信箱，請查收",
      ),
      theme: LoginTheme(
        primaryColor: kPrimaryThemeColor,
        accentColor: kSecondaryThemeColor,
        errorColor: Colors.black,
        titleStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.w600,
          letterSpacing: 4,
        ),
        bodyStyle: TextStyle(
          fontSize: 20,
        ),
        textFieldStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        buttonStyle: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
          fontSize: 20,
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 5,
          margin: EdgeInsets.only(top: 15),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
        ),
        inputTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.zero,
          errorStyle: TextStyle(
            backgroundColor: Colors.white,
            color: Colors.black,
            fontSize: 18,
          ),
          labelStyle: TextStyle(fontSize: 20),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade700, width: 4),
            borderRadius: inputBorder,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 5),
            borderRadius: inputBorder,
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 7),
            borderRadius: inputBorder,
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade400, width: 8),
            borderRadius: inputBorder,
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 5),
            borderRadius: inputBorder,
          ),
        ),
        buttonTheme: LoginButtonTheme(
          splashColor: Colors.purple,
          backgroundColor: Colors.pinkAccent,
          elevation: 5.0,
          highlightElevation: 6.0,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        beforeHeroFontSize: 50,
        afterHeroFontSize: 30,
      ),
    );
  }
}
