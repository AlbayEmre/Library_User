import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:library_user/Model/user_model.dart';
import 'package:library_user/Provider/user_Provider.dart';
import 'package:library_user/View/Out/login.dart';
import 'package:library_user/widget/App_name_text.dart';
import 'package:library_user/widget/loading_manager.dart';
import 'package:provider/provider.dart';

import '../Provider/theme_provider.dart';
import '../Services/Assets_Manager.dart';
import '../Services/myapp_functions.dart';
import '../constant/lottie_Items.dart';
import '../widget/Order/order_screen.dart';
import '../widget/suptitle_text.dart';
import 'init_screen/Viewed_resently.dart';
import 'init_screen/wishlist.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  User? user = FirebaseAuth.instance.currentUser;

  bool _changeAnimate = false;
  UserModel? userModel;
  bool _isLoading = true;

  Future<void> fetchUserInfo() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      setState(() {
        _isLoading = true;
      });
      userModel = await userProvider.fetchUserInfo();
    } catch (error) {
      await MyAppFuncrions.showErrorOrWaningDialog(context: context, subtitle: error.toString(), fct: () {});
    } finally {
      if (mounted) {
        // mounted kontrolü eklendi
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  late AnimationController _controller;

  @override
  void initState() {
    fetchUserInfo();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 3));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final themaProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          //  child: Image.asset(AssetsManager.file_112),
        ),
        title: AppNameTextWidget(
          fontSize: 20,
          HeadText: 'Profile',
        ),
      ),
      body: LoadingManager(
        isLoadlin: _isLoading,
        child: Column(
          crossAxisAlignment: user == null ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          mainAxisAlignment: user == null ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            //!Kullanıcı Giriş Uyarısı (görünürlük deyişebilir)
            Visibility(
              visible: user == null ? true : false,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SubTitleTextWidget(
                      label: "Pleace login to have unlimited access",
                      color: Colors.blueGrey,
                    ),
                  ],
                ),
              ),
            ),
            userModel == null
                ? SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).cardColor,
                              border: Border.all(
                                color: Theme.of(context).colorScheme.background,
                                width: 3,
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    userModel!.userImage,
                                  ),
                                  fit: BoxFit.fill)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SubTitleTextWidget(label: userModel!.userName),
                            SizedBox(
                              height: 5,
                            ),
                            SubTitleTextWidget(label: userModel!.userEmail),
                          ],
                        ),
                      ],
                    ),
                  ),

            SizedBox(
              height: 15,
            ),
            userModel == null
                ? SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SubTitleTextWidget(
                          label: "Information",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomListTile(
                          imagePath: "assets/user/bag/SuAnaKadar.png",
                          text: "Received so far",
                          function: () {
                            // Navigator.pushNamed(context, OrderScreen.routName);
                          },
                        ),
                        CustomListTile(
                          imagePath: "assets/user/bag/1.png",
                          text: "Favorite",
                          function: () {
                            Navigator.pushNamed(context, WishListScreen.routName);
                          },
                        ),
                        CustomListTile(
                          imagePath: AssetsManager.clock,
                          text: "Viwed Recently",
                          function: () {
                            Navigator.pushNamed(context, ViwedResentyScreen.routName);
                          },
                        ),
                        CustomListTile(
                          imagePath: AssetsManager.location,
                          text: "Address",
                          function: () {},
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        CustomListTile(
                          imagePath: AssetsManager.privacy, //Setting uygun olanı koy
                          text: "Settings",
                          function: () {},
                        ),
                        _ChangeTheme(themaProvider, context),
                      ],
                    ),
                  ),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.watch<ThemeProvider>().getIsDerkTehme ? Colors.deepPurple : Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  if (user == null) {
                    Navigator.pushNamed(context, LoginScreen.routName); //Eyer giris yoksa Loogine gidecek
                  } else {
                    MyAppFuncrions.showErrorOrWaningDialog(
                      //? Eminmisin deyilmisin sor
                      context: context,
                      subtitle: "Are you sure ? ",
                      fct: () async {
                        await FirebaseAuth.instance.signOut(); //Çıkış yap
                        if (!mounted) {
                          //Eğer widget kaldırılmışsa ve siz hala onunla etkileşime geçmeye çalışıyorsanız, bu durum hatalara yol açabilir.
                          //mounted kontrolü, widget'ın hala mevcut olduğundan emin olmanızı sağlar.
                          return;
                        }
                        Navigator.pushNamed(context, LoginScreen.routName); //Yes e basınca çıkış yapacak
                      },
                      isError: false,
                    );
                  }
                },
                icon: Icon(user == null ? Icons.login : Icons.logout),
                label: Text(
                  user == null ? "Login" : "Logout",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _ChangeTheme(ThemeProvider themaProvider, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _changeAnimate ? "Dark Modde" : "Light Modde",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          onTap: () {
            _changeAnimate ? _controller.animateTo(1) : _controller.animateTo(0.5);

            Future.microtask(() => themaProvider.setDarkTheme(tehemeValue: _changeAnimate));

            _changeAnimate = !_changeAnimate;
          },
          child: Lottie.asset(lottieItem.changeTheme_Lottie,
              repeat: false, controller: _controller, width: MediaQuery.sizeOf(context).width * 0.2),
        ),
      ],
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.imagePath,
    required this.text,
    required this.function,
  });
  final String imagePath, text;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      title: SubTitleTextWidget(label: text),
      leading: Image.asset(
        imagePath,
        height: 34,
      ),
      trailing: Icon(CupertinoIcons.chevron_right),
    );
  }
}
