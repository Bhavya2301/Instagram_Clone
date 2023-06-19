import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter/screens/add_post_screen.dart';

import '../utils/colors.dart';


class AppBarr extends StatelessWidget implements PreferredSizeWidget{
  const AppBarr({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddPostScreen())),
                icon: const Icon(FeatherIcons.plusSquare),
                iconSize: 28.0,
                color: primaryColor,
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset(
                  "assets/ic_instagram.svg",
                  // ignore: deprecated_member_use
                  color: primaryColor,
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width*0.35,
                ),
              ),
              IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.chat_bubble_2, color: primaryColor, size: 30.0,))
            ],
          ),
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}