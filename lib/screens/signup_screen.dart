import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../widgets/text_field_input.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
  }

  void selectImage() async {
    Uint8List im =  await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true; 
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text, 
        password: _passwordController.text, 
        username: _userNameController.text, 
        bio: _bioController.text,
        file: _image!,
      );
    
    setState(() {
      _isLoading = false;
    });

    if(res != 'success')
    {
      showSnackBar(res, context);
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
         return const ResponsiveLayout(webScreenLayout: WebScreenLayout(), mobileScreenLayout: MobileScreenLayout());
      },),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            //a container because we need to add some padding and set width of our app
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              //for our content to be centered
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(child: Container(), flex: 1,),
                //svg image
                SvgPicture.asset(
                  'assets/ic_instagram.svg', 
                  color: primaryColor, 
                  height: 64,
                ),
                const SizedBox(height: 64,),
                //circular widget to accept and show our selected file
                Stack(
                  children: [
                    _image != null ? CircleAvatar(radius: 64, backgroundImage: MemoryImage(_image!)) : const CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage("https://cdn3d.iconscout.com/3d/premium/thumb/user-3711850-3105265.png"),
                      backgroundColor: primaryColor,
                    ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24,),
                //text field input for username
                TextFieldInput(
                  textEditingController: _userNameController, 
                  hintText: 'Enter your username', 
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 24,),
                //text field input for email
                TextFieldInput(
                  textEditingController: _emailController, 
                  hintText: 'Enter your email', 
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 24,),
                //text field input for password
                TextFieldInput(
                  textEditingController: _passwordController, 
                  hintText: 'Enter your password', 
                  textInputType: TextInputType.text,
                  isPass: true,
                ),
                const SizedBox(height: 24,),
                //text field for bio
                TextFieldInput(
                  textEditingController: _bioController, 
                  hintText: 'Enter a bio', 
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 24,),
                //button login
                InkWell(
                  onTap: signUpUser,
                  child: Container(
                    width: double.infinity,
                    height: 50.0,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4),),
                      ),
                      color: blueColor,
                    ),
                    child: _isLoading ? Center(child: LoadingAnimationWidget.horizontalRotatingDots(color: Colors.white, size: 30.0),)
                    : const Text('Sign up', style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                const SizedBox(height: 12,),
                Flexible(child: Container(), flex: 1,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}