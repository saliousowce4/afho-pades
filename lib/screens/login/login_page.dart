import 'package:appafhopades/SignUp/sign_up_page.dart';
import 'package:appafhopades/constants/constants.dart';
import 'package:appafhopades/screens/dashboard/home_page.dart';
import 'package:appafhopades/screens/electeurs/list_electeur_page.dart';
import 'package:appafhopades/widgets/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_auth/http_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget{
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  Widget FadeAlertAnimation(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return Align(
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
  signIn( _contact, _password) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map data = {
        'contact': _contact,
        'password': _password
    };
    _onBasicAlertPressed(context) {
    Alert(
    context: context,
    title: "Succès",
    desc: "Authentification réussie",
      alertAnimation: FadeAlertAnimation,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () =>
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            ),
          width: 120,
        )
      ],
    ).show();
    }
    var jsonResponse = null;
    var response = await http.post("https://dry-garden-22624.herokuapp.com/api/agent/login",
        body: data);

    if(response.statusCode == 200){
      jsonResponse = json.decode(response.body);
      if(jsonResponse!=null){
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
        print("hooora good response");
        _onBasicAlertPressed(context);
   ;

      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
      print("ooogg noioo");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          Text(
            "LOGIN",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
            Image.asset(
              "assets/logowithpresi.jpeg",
              height: 150,
              width: 150,
            ),
            Container(
              padding:  EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: phoneController,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: kPrimaryColor,
                    ),
                    labelText: "Téléphone"
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                obscureText: true,

                controller: passwordController,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.vpn_key ,
                      color: kPrimaryColor,
                    ),
                    labelText: "Mot de passe"
                ),
              ),
            ),
            SizedBox(height: 40),

                  RoundedButton (
              text: "SE CONNECTER",
              color: kPrimaryColor,
              textColor: Colors.white,
                    press: () {
                      setState(() {
                        _isLoading = true;
                      });
                      print("cliqued");
                      signIn(phoneController.text, passwordController.text);

                      /* */
                    },
            ),

          ],
        ),
      ),
    );
  }

}