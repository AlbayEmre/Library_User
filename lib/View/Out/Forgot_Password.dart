import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../Colors/validator(Wigdet).dart';
import '../../Services/Assets_Manager.dart';
import '../../widget/App_name_text.dart';
import '../../widget/suptitle_text.dart';

class ForgotPassword extends StatefulWidget {
  static const routName = "/ForgotPassword";
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>(); //!Formun doğruluğunu konturol etmek için
  late final TextEditingController _emailController;

  @override
  void initState() {
    _emailController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    if (mounted) //?Kullanıcı tarafında görüntülenmiyorsa veya kulanılmıyorsa aşağıdaki işlemleri yap(ÖRNEK :SAYFADAN ÇIKMAK )
    {
      _emailController.dispose();
    }
    super.dispose();
  }

  Future<void> _ForgetFCT() async {
    final isValid = _formKey.currentState!.validate(); //!Geçerli ise true
    FocusScope.of(context).unfocus();
    if (isValid) {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppNameTextWidget(
          HeadText: "Forget Password",
          isShimer: false,
          fontSize: 20,
          TextColor: const Color.fromARGB(255, 93, 0, 255),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: 10,
              ),
              Image.asset(
                AssetsManager.forget,
                width: size.width * 0.6,
                height: size.height * 0.3,
              ),
              SubTitleTextWidget(
                label: "Forget Password",
              ),
              SubTitleTextWidget(
                label: "Pleace Enter Email address " * 2,
                fontSize: 13,
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email Adress",
                        prefixIcon: Icon(IconlyLight.message),
                      ),
                      onFieldSubmitted: (value) {},
                      validator: (value) {
                        return MyValidators.EmailValidator(value);
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
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
                          await _ForgetFCT(); //Basınca bilgileri konturol edecek
                        },
                        icon: Icon(Icons.send),
                        label: Text("Password Send Email"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
