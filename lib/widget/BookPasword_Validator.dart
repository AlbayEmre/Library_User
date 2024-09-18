import 'package:flutter/material.dart';
import 'package:library_user/Services/Assets_Manager.dart';
import '../widget/suptitle_text.dart';

class PaswordContoller {
  static Future<bool> PaswordContollers({
    required GlobalKey<FormState> key,
    required BuildContext context,
    required String subtitle,
    required List<String> passwordList,
  }) async {
    String? inputValue;
    bool isPasswordValid = false;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AssetsManager.password,
                height: 60,
                width: 60,
              ),
              SizedBox(height: 16.0),
              SubTitleTextWidget(
                label: subtitle,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 16.0),
              Form(
                key: key,
                child: TextFormField(
                  onChanged: (value) {
                    inputValue = value;
                  },
                  validator: (value) {
                    if (passwordList.contains(value)) {
                      isPasswordValid = true;
                      return null;
                    }
                    isPasswordValid = false;
                    return 'Wrong password';
                  },
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        Navigator.pop(context);
                      }
                    },
                    child: SubTitleTextWidget(
                      label: "Ok",
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

    return isPasswordValid;
  }
}
