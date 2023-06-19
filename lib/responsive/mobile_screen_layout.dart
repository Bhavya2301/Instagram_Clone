import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';
import '../utils/global_variables.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: onPageChanged,
              children: homeScreenItems,
            ),
            Container(
              height: 85,
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: CustomNavigationBar(
                selectedColor: primaryColor,
                unSelectedColor: secondaryColor,
                onTap: navigationTapped,
                currentIndex: _page,
                backgroundColor: const Color(0xFF1a1a1a),
                strokeColor: primaryColor,
                blurEffect: true,
                borderRadius: const Radius.circular(50),
                isFloating: true,
                elevation: 5.0,
                items: [
                  CustomNavigationBarItem(
                    icon: const Icon(FeatherIcons.home),
                  ),
                  CustomNavigationBarItem(
                    icon: const Icon(FeatherIcons.search),
                  ),
                  // CustomNavigationBarItem(
                  //   icon: const Icon(FeatherIcons.plusSquare),
                  // ),
                  CustomNavigationBarItem(
                    icon: const Icon(FeatherIcons.heart),
                  ),
                  CustomNavigationBarItem(
                    icon: const Icon(FeatherIcons.user),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
