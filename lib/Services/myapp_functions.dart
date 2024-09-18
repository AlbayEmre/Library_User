import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:library_user/Services/Assets_Manager.dart';

import '../widget/suptitle_text.dart';

class MyAppFuncrions {
  static Future<void> showErrorOrWaningDialog({
    required BuildContext context,
    required String subtitle,
    bool isError = true,
    required Function fct,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          content: Column(
            mainAxisSize: MainAxisSize.min, //!Sayfa içindekilerin sığabileceği en küçük halini alır
            children: [
              Image.asset(
                isError ? AssetsManager.error : AssetsManager.warning,
                height: 60,
                width: 60,
              ),
              SizedBox(
                height: 16.0,
              ),
              SubTitleTextWidget(
                label: subtitle,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: !isError,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: SubTitleTextWidget(
                        label: "Cancel",
                        color: Colors.greenAccent,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      fct();
                      Navigator.pop(context);
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
  }

  static Future<void> ImagePickerDialog({
    required BuildContext context,
    required Function cameraFCT,
    required Function gallaryFCT,
    required Function removeFCT,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: SubTitleTextWidget(
              label: "Choose option ",
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextButton.icon(
                  onPressed: () {
                    cameraFCT();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(Icons.camera_alt),
                  label: Text("Camera"),
                ),
                ///////////////////////////////

                TextButton.icon(
                  onPressed: () {
                    gallaryFCT();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(Icons.image_outlined),
                  label: Text("Gallery"),
                ),
                /////////////////////////////////
                TextButton.icon(
                  onPressed: () {
                    removeFCT();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(Icons.camera_alt),
                  label: Text("Remove"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
