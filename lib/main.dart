// WE NEED SHA-1 DEBUG CERTIFICATION ONLY WHEN WE DO PHONE OR GOOGLE AUTHENTICATION
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:instagram_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_flutter/screens/login_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'responsive/responsive_layout_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        //for the web
        options: const FirebaseOptions(
      apiKey: "AIzaSyABD5Xb_vbKrkEhC0bQHpe5tLpIl81VQ3M",
      appId: "1:878502002452:web:b9c23073248df1fd918c01",
      messagingSenderId: "878502002452",
      projectId: "instagram-clone-d105d",
      storageBucket: "instagram-clone-d105d.appspot.com",
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //"MutliProvider" merges multiple linear provider trees into single one, for quick switching and show chenges on screen
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme: ThemeData.dark(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        //persisting user state
        home: StreamBuilder(
          stream: FirebaseAuth.instance
              .authStateChanges(), //only runs when user sign's or sign's out
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                    webScreenLayout: WebScreenLayout(),
                    mobileScreenLayout: MobileScreenLayout());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.inkDrop(
                    color: Colors.white, size: 60.0),
              );
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
