import 'package:appafhopades/constants/constants.dart';
import 'package:appafhopades/screens/dashboard/home_page.dart';
import 'package:appafhopades/screens/dashboard/sliding_cards.dart';
import 'package:appafhopades/screens/electeurs/list_electeur_page.dart';
import 'package:appafhopades/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class SignUpPage extends StatefulWidget{
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>{

  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController quartierController = TextEditingController();
  TextEditingController secteurController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController sexeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController agent_idController = TextEditingController();

  TextEditingController avis_electeurController = TextEditingController()..text = 'Oui';
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  SignUp( _nom, _prenom,_quartier,_secteur,_contact,_sexe,_password,_agent_id,_avis_electeur) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map data = {
      'nom': _nom,
      'prenom': _prenom,
      'quartier': _quartier,
      'secteur': _secteur,
      'contact': _contact,
      'sexe': _sexe,
      'password': _password,
      'agent_id': _agent_id,
      'avis_electeur': _avis_electeur
    };
    // The easiest way for creating RFlutter Alert
    _onBasicAlertPressed(context) {
      Alert(
        context: context,
        title: "Succès",
        desc: "Ajout du militant réussi",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                ),
            width: 120,
          )
        ],
      ).show();
    }
    // The easiest way for creating RFlutter Alert
    _echec(context) {
      Alert(
        context: context,
        title: "ECHEC",
        desc: "Veuillez vérifier les informations",
      ).show();
    }

    var jsonResponse = null;
    var response = await http.post("https://dry-garden-22624.herokuapp.com/api/client/electeur/store",
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
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
      print("ooogg noioo");
      _echec(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Text(
              "Créer un compte",
              textAlign: TextAlign.center,
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
                controller: nomController,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: kPrimaryColor,
                    ),
                    labelText: "Nom"
                ),
              ),
            ),
            Container(
              padding:  EdgeInsets.all(10),
              child: TextField(
                controller: prenomController,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: kPrimaryColor,
                    ),
                    labelText: "Prénom"
                ),
              ),
            ),
            Container(
              padding:  EdgeInsets.all(10),
              child: TextField(
                controller: quartierController,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.location_city,
                      color: kPrimaryColor,
                    ),
                    labelText: "Quartier"
                ),
              ),
            ),
            Container(
              padding:  EdgeInsets.all(10),
              child: TextField(
                controller: secteurController,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.location_on,
                      color: kPrimaryColor,
                    ),
                    labelText: "Secteur"
                ),
              ),
            ),
            Container(
              padding:  EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.number,

                controller: phoneController,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.phone,
                      color: kPrimaryColor,
                    ),
                    labelText: "Numéro de téléphone"
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: sexeController,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.person_outline ,
                      color: kPrimaryColor,
                    ),
                    labelText: "Sexe"
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
                      Icons.lock ,
                      color: kPrimaryColor,
                    ),

                    labelText: "Mot de passe",
                ),
              ),
            ),
            Container(
              padding:  EdgeInsets.all(10),
              child: TextField(
                controller: agent_idController,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.person_pin,
                      color: kPrimaryColor,
                    ),
                    labelText: "Id Agent"
                ),
              ),
            ),
            Container(
              padding:  EdgeInsets.all(10),
              child: TextField(
                controller: avis_electeurController,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.person_pin,
                      color: kPrimaryColor,
                    ),
                    labelText: "Avis electeur"
                ),
              ),
            ),

            SizedBox(height: 40),

            RoundedButton(
              text: "ENREGISTRER",
              color: kPrimaryColor,
              textColor: Colors.white,
              press: () {
                setState(() {
                  _isLoading = true;
                });
                print("cliqued");
                SignUp(nomController.text, prenomController.text,quartierController.text,
                  secteurController.text,phoneController.text,
                  sexeController.text,passwordController.text,
                  agent_idController.text,avis_electeurController.text);
              },
            ),


          ],
        ),
      ),
    );
  }

}