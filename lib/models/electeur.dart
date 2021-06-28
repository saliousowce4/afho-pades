class Electeur {
  final int id;
  final String nom;
  final String prenom;
  final String quartier;
  final String secteur;
  final String contact;
  final String sexe;
  final String password;
  final String agent_id;
  final String avis_electeur;


  Electeur({this.id, this.nom, this.prenom,
    this.quartier, this.secteur, this.contact,
    this.sexe, this.password, this.agent_id, this.avis_electeur});

  factory Electeur.fromJson(Map<String, dynamic> json) {
    return Electeur(
      nom: json['nom'],
      prenom: json['prenom'],
      quartier: json['quartier'],
      secteur: json['secteur'],
      contact: json['contact'],
      sexe: json['sexe'],
      avis_electeur: json['avis_electeur'],
    );
  }
}
