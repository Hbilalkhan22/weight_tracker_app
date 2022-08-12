import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_tracker/app/constants/My%20Widgets/dialog_boxes.dart';
import 'package:weight_tracker/app/routes/app_pages.dart';
import 'package:weight_tracker/main.dart';

class AuthController extends GetxController {
  final auth = FirebaseAuth.instance;
  RxBool isShowPassword = false.obs;
  RxBool isLoginForm = true.obs;
  var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();

  Future<void> registerUser() async {
    try {
      DialogBoxes.openLoadingDialog();
      var user = await auth.createUserWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
      box.write('userEmail', user.user?.email);
      Navigator.of(Get.context!).pop();
      Get.toNamed(Routes.HOME);
      print(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Navigator.of(Get.context!).pop();
        DialogBoxes.showErroDialog(
            title: 'Alert', description: 'Your Password is too weak');
      } else if (e.code == 'email-already-in-use') {
        Navigator.of(Get.context!).pop();
        DialogBoxes.showErroDialog(
            title: 'Alert',
            description: 'The account already exists for that email');
      }
    } catch (e) {
      Navigator.of(Get.context!).pop();
      DialogBoxes.showErroDialog(title: 'Alert', description: '$e');
    }
  }

  Future<void> loginUser() async {
    try {
      DialogBoxes.openLoadingDialog();
      var user = await auth.signInWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
      box.write('userEmail', user.user?.email);
      Navigator.of(Get.context!).pop();
      Get.toNamed(Routes.HOME);
      print(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Navigator.of(Get.context!).pop();
        DialogBoxes.showErroDialog(
            title: 'Alert', description: 'No user found for that email');
      } else if (e.code == 'wrong-password') {
        Navigator.of(Get.context!).pop();
        DialogBoxes.showErroDialog(
            title: 'Alert', description: 'Incorrect Password');
      }
    } catch (e) {
      Navigator.of(Get.context!).pop();
      DialogBoxes.showErroDialog(title: 'Alert', description: '$e');
    }
  }
}
