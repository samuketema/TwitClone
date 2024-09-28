// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class FirebaseUser {
  String email;
  String name;
  String proofilePic;
  
  FirebaseUser({
    required this.email,
    required this.name,
    required this.proofilePic,
  });
  

  FirebaseUser copyWith({
    String? email,
    String? name,
    String? proofilePic,
  }) {
    return FirebaseUser(
      email: email ?? this.email,
      name: name ?? this.name,
      proofilePic: proofilePic ?? this.proofilePic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'proofilePic': proofilePic,
    };
  }

  factory FirebaseUser.fromMap(Map<String, dynamic> map) {
    return FirebaseUser(
      email: map['email'] as String,
      name: map['name'] as String,
      proofilePic: map['proofilePic'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FirebaseUser.fromJson(String source) => FirebaseUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FirebaseUser(email: $email, name: $name, proofilePic: $proofilePic)';

  @override
  bool operator ==(covariant FirebaseUser other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.name == name &&
      other.proofilePic == proofilePic;
  }

  @override
  int get hashCode => email.hashCode ^ name.hashCode ^ proofilePic.hashCode;
}
