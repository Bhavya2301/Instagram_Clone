import 'package:flutter/material.dart';
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:instagram_flutter/utils/global_variables.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayout({super.key, required this.webScreenLayout, required this.mobileScreenLayout});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    //by setting "listen" to false we can only view only once, and that's what we want
    //this is what take sto store or update value of "_user" in our userProvider
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(//HELPS US TO BUILD RESPONSIVE LAYOUTS
      builder: (context, constraints){
        if(constraints.maxWidth > webScreenSize){
          //if greater than maxWidth than display in web screen layout
          return widget.webScreenLayout;
        }
        //else we pass in a web screen layout
        return widget.mobileScreenLayout;
      },
    );
  }
}