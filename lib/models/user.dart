
import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  User({
    required this.email, 
    required this.uid, 
    required this.photoUrl, 
    required this.username, 
    required this.bio, 
    required this.followers, 
    required this.following,
  });

  //function to convert any user object to an object
  Map<String, dynamic> toJson() =>  {
    "username": username,
    "uid": uid,
    "email": email,
    "photoUrl": photoUrl,
    "bio": bio,
    "followers": followers,
    "following": following,
  };

  //a function to take in documentSnapshot and convert it to a user model
  static User fromSnap(DocumentSnapshot snap){
    var snapShot = snap.data() as Map<String, dynamic>;
    
    return User(
      username: snapShot['username'],
      uid: snapShot['uid'],
      email: snapShot['email'],
      photoUrl: snapShot['photoUrl'],
      bio: snapShot['bio'],
      followers: snapShot['followers'],
      following: snapShot['following'],
    );
  }
}