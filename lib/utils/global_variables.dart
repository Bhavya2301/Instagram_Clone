import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/screens/feed_screen.dart';
import 'package:instagram_flutter/screens/profile_screen.dart';
import 'package:instagram_flutter/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  Text(
    "NOTIFICATIONS",
    style: TextStyle(color: Colors.amber, fontSize: 27),
  ),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid)
];
