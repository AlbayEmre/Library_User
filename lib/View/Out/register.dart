import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_user/Services/myapp_functions.dart';
import 'package:library_user/root_screen.dart';
import 'package:library_user/widget/App_name_text.dart';
import 'package:library_user/widget/loading_manager.dart';
import 'package:library_user/widget/suptitle_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Colors/validator(Wigdet).dart';
import '../../widget/image_picker_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RegisterScreen extends StatefulWidget {
  static const routName = "/RegisterScreen";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool obscureText = false;
  bool obscureText2 = false;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _repeatPasswwordController;

  late final FocusNode _nameFocusNode;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _repeatPasswwordFocusNode;

  final _formkey = GlobalKey<FormState>();

  XFile? _pickedImage;
  bool _isLoading = false;
  final auth = FirebaseAuth.instance;
  String? userImageUrl;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _repeatPasswwordController = TextEditingController();

    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _repeatPasswwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswwordController.dispose();

    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _repeatPasswwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _registerFCT() async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      try {
        setState(() {
          _isLoading = true;
        });
        await auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        final User? user = auth.currentUser; //?
        final String uid = user!.uid; //?
        final ref = FirebaseStorage.instance.ref().child("userImages").child("${_emailController.text.trim()}.png");
        await ref.putFile(File(_pickedImage!.path));
        userImageUrl = await ref.getDownloadURL();
        //todo     Kulanıcı verilerini veri tabanına ekliyoruz isim : eklenen veri
        await FirebaseFirestore.instance.collection("users").doc(uid).set({
          'userId': uid,
          'userName': _nameController.text,
          'userImage': userImageUrl,
          'userEmail': _emailController.text.toLowerCase(),
          'createdAt': Timestamp.now(),
          'userCard': [],
          'userWish': [],
        });

        Fluttertoast.showToast(msg: "An account has been created", textColor: Colors.white);
        // Toast mesajı
        if (!mounted) {
          return;
        }
        Navigator.pushReplacementNamed(context, RootScreen.routName);
      } on FirebaseException catch (error) {
        MyAppFuncrions.showErrorOrWaningDialog(
          context: context,
          subtitle: error.message.toString(),
          fct: () {},
        );
      } catch (error) {
        MyAppFuncrions.showErrorOrWaningDialog(context: context, subtitle: error.toString(), fct: () {});
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> localImagePicker() async {
    final ImagePicker imagePicker = ImagePicker();
    await MyAppFuncrions.ImagePickerDialog(
        context: context,
        cameraFCT: () async {
          _pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
          setState(() {});
        },
        gallaryFCT: () async {
          _pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
          setState(() {});
        },
        removeFCT: () {
          _pickedImage = null;
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: AppNameTextWidget(
            fontSize: 20,
            HeadText: 'Register',
          ),
        ),
        body: LoadingManager(
          isLoadlin: _isLoading,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Align(
                    //  alignment: Alignment.centerLeft,//Column u Ekranın sağ tarafına hizzalar
                    child: Column(
                      children: [
                        SubTitleTextWidget(
                          label: 'Welcome',
                        ),
                        SubTitleTextWidget(
                          label: "Welcome! Thank you for joining us!",
                          fontSize: 14,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: SizedBox(
                      height: size.height * 0.2,
                      width: size.width * 0.3,
                      child: PickImageWidget(
                        pickedImage: _pickedImage,
                        function: () async {
                          await localImagePicker();
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          focusNode: _nameFocusNode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Full Name ",
                            prefixIcon: Icon(Icons.person_2),
                          ),
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(_passwordFocusNode);
                          },
                          validator: (value) {
                            return MyValidators.DisplayNameValidato(value);
                          },
                        ),
                        /////////////////////////////////
                        SizedBox(
                          height: 16.0,
                        ),
                        /////////////////////////////////
                        TextFormField(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Email Adress",
                            prefixIcon: Icon(IconlyLight.message),
                          ),
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(_passwordFocusNode);
                          },
                          validator: (value) {
                            return MyValidators.EmailValidator(value);
                          },
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        /////////////////////////////////
                        TextFormField(
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscureText2,
                          obscuringCharacter: "*",
                          decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(IconlyLight.password),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscureText2 = !obscureText2;
                                  });
                                },
                                icon: obscureText2
                                    ? Icon(
                                        Icons.visibility_off_outlined,
                                        color: Colors.grey,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: Colors.amber[300],
                                      )),
                          ),
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(_repeatPasswwordFocusNode);
                          },
                          validator: (value) {
                            return MyValidators.PasswordValidator(value);
                          },
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        /////////////////////////////////
                        TextFormField(
                          controller: _repeatPasswwordController,
                          focusNode: _repeatPasswwordFocusNode,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscureText,
                          obscuringCharacter: "*",
                          decoration: InputDecoration(
                            hintText: " Repeat Password",
                            prefixIcon: Icon(IconlyLight.password),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                                icon: obscureText
                                    ? Icon(
                                        Icons.visibility_off_outlined,
                                        color: Colors.grey,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: Colors.amber[300],
                                      )),
                          ),
                          onFieldSubmitted: (value) async {
                            await _registerFCT();
                          },
                          validator: (value) {
                            return MyValidators.PasswordValidator(value);
                          },
                        ),
                        SizedBox(
                          height: 48.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: EdgeInsets.all(16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              onPressed: () async {
                                await _registerFCT(); //Basınca bilgileri konturol edecek
                              },
                              icon: Icon(Icons.person_add_alt_1),
                              label: Text("Sing Up")),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
