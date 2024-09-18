import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:library_user/Services/myapp_functions.dart';
import 'package:library_user/root_screen.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  Future<void> _googleSignIn({
    required BuildContext context,
  }) async {
    try {
      final googleSignIn = GoogleSignIn();
      final googleAccount = await googleSignIn.signIn();
      if (googleAccount != null) {
        final googleAuth = await googleAccount.authentication;
        if (googleAuth.accessToken != null && googleAuth.idToken != null) {
          final authResults = await FirebaseAuth.instance.signInWithCredential(GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          ));

          if (authResults.user != null) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.pushReplacementNamed(context, RootScreen.routName);
            });
          }
        }
      }
    } on FirebaseException catch (error) {
      await MyAppFuncrions.showErrorOrWaningDialog(
        context: context,
        subtitle: error.message.toString(),
        fct: () {},
      );
    } catch (error) {
      await MyAppFuncrions.showErrorOrWaningDialog(
        context: context,
        subtitle: error.toString(),
        fct: () {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: const Color.fromARGB(59, 158, 158, 158),
      onTap: () async {
        await _googleSignIn(context: context);
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.topCenter,
            begin: Alignment.bottomCenter,
            colors: [const Color.fromARGB(255, 255, 17, 0), Color.fromARGB(255, 119, 0, 255)],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Row(
            children: [
              Icon(
                Ionicons.logo_google,
                size: MediaQuery.of(context).size.width * 0.05,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Sign in with Google",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
