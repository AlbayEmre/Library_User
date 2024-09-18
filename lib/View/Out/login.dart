import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';
import 'package:library_user/Services/myapp_functions.dart';
import 'package:library_user/View/Out/register.dart';
import 'package:library_user/root_screen.dart';
import 'package:library_user/widget/App_name_text.dart';
import 'package:library_user/widget/loading_manager.dart';

import '../../Colors/validator(Wigdet).dart';
import '../../widget/google_btn.dart';
import '../../widget/suptitle_text.dart';
import 'Forgot_Password.dart';

part 'Login_Widget.dart';

class LoginScreen extends StatefulWidget {
  static const routName = "/LoginScreen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

//todo ->   Odaklanma durumlarını konturol etmek için
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  final _formKey = GlobalKey<FormState>(); //!Formun doğruluğunu konturol etmek için
  bool _isLoading = false;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) //?Kullanıcı tarafında görüntülenmiyorsa veya kulanılmıyorsa aşağıdaki işlemleri yap(ÖRNEK :SAYFADAN ÇIKMAK )
    {
      _emailController.dispose();
      _passwordController.dispose();
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
    }
    super.dispose();
  }

  Future<void> _loginFCT() async {
    final isValid = _formKey.currentState!.validate(); //!Geçerli ise true
    FocusScope.of(context).unfocus();

    if (isValid) {
      try {
        setState(() {
          _isLoading = true;
        });
        await auth.signInWithEmailAndPassword(
          //!Kulanıcının oluşmuş hesabı ile giriş yapıyouz
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        Fluttertoast.showToast(msg: "Login Successfull", textColor: Colors.white);
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: AppNameTextWidget(
            fontSize: 20,
            HeadText: 'Login',
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
                    //Column u Ekranın sağ tarafına hizzalar
                    alignment: Alignment.centerLeft,
                    child: SubTitleTextWidget(
                      label: 'Welcome back',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey, //! Formu doğrulamak için
                    child: Column(
                      children: [
                        _EmailTextFormField(
                            emailController: _emailController,
                            emailFocusNode: _emailFocusNode,
                            passwordFocusNode: _passwordFocusNode),
                        SizedBox(
                          height: 16.0,
                        ),
                        _PasswordTextFormField(
                            function: _loginFCT,
                            passwordController: _passwordController,
                            passwordFocusNode: _passwordFocusNode),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, ForgotPassword.routName);
                            },
                            child: SubTitleTextWidget(
                              label: "Forget Password",
                              fontStyle: FontStyle.italic,
                              textDecoration: TextDecoration.underline, //ALT ÇİZGİ
                              fontSize: 13,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            onPressed: () async {
                              await _loginFCT(); //Basınca bilgileri konturol edecek
                            },
                            icon: Icon(Icons.login),
                            label: Text("Login"),
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        SubTitleTextWidget(
                          label: "Or login using",
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        SizedBox(
                          height: kBottomNavigationBarHeight + 10,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: kBottomNavigationBarHeight,
                                  child: FittedBox(
                                    child: GoogleButton(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: kBottomNavigationBarHeight - 15,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(context, RootScreen.routName);
                                    },
                                    child: Text("Guest"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SubTitleTextWidget(
                              label: "New User?",
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(RegisterScreen
                                      .routName); //?Sadece name ile gitmke için sayfa basında adı ve main icidne "(Rout Name Tanımlanmalı)"
                                },
                                child: SubTitleTextWidget(
                                  label: "Sing up",
                                )),
                          ],
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
