// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:weight_tracker/app/constants/My%20Widgets/capsole_container.dart';
import 'package:weight_tracker/app/constants/My%20Widgets/my_text_field.dart';
import 'package:weight_tracker/app/constants/colors.dart';
import 'package:weight_tracker/app/constants/styles.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  AuthView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  var authCon = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(gradient: MyStyles.kGradient),
              child: Column(
                  mainAxisAlignment: authCon.isLoginForm.isTrue
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.center,
                  children: [
                    /// top title of login screen
                    topHeader(),

                    /// Login Form of Login Screen which have TextFields and Login Button
                    loginForm(),

                    /// bottom section of Login Screen e.g. Social Links & Register now button etc.
                    loginBottomSection()
                  ]),
            )),
      ),
    );
  }

  Widget loginBottomSection() {
    return Visibility(
      visible: authCon.isLoginForm.isTrue ? true : false,
      child: Column(
        children: [
          Text(
            'or continue with',
            style: MyStyles.poppinsMedium(
                color: MyColors.kBlackClr.withOpacity(0.6)),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              socialButton(() {}, 'google'),
              const SizedBox(
                width: 25,
              ),
              socialButton(() {}, 'apple-logo'),
              const SizedBox(
                width: 25,
              ),
              socialButton(() {}, 'facebook'),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Not a member?',
                style: MyStyles.poppinsMedium(
                    color: MyColors.kBlackClr.withOpacity(0.6)),
              ),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () {
                  authCon.isLoginForm(false);
                },
                child: Text(
                  'Register now',
                  style: MyStyles.poppinsMedium(
                      color: MyColors.kGreenClr, fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  InkWell socialButton(VoidCallback ontap, String imageName) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MyColors.kWhiteClr)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            'assets/icons/$imageName.png',
          ),
        ),
      ),
    );
  }

  Padding loginForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            MTextField(
              label: 'Enter email',
              controller: authCon.emailTextController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is Required';
                } else if (!GetUtils.isEmail(value.toString())) {
                  return 'Email is not correct';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 25,
            ),
            Obx(() => MTextField(
                  label: 'Password',
                  controller: authCon.passwordTextController,
                  obsecure: authCon.isShowPassword.isTrue ? false : true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is Required';
                    } else if (!GetUtils.isLengthGreaterOrEqual(value, 8)) {
                      return 'Password can`t be less then 8';
                    }
                    return null;
                  },
                  suffix: InkWell(
                    onTap: () =>
                        authCon.isShowPassword(!authCon.isShowPassword.value),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Icon(authCon.isShowPassword.isTrue
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                )),
            const SizedBox(
              height: 15,
            ),
            Visibility(
              visible: authCon.isLoginForm.isTrue ? true : false,
              child: Text(
                'Recover Password',
                style: MyStyles.poppinsMedium(
                    color: MyColors.kBlackClr.withOpacity(0.6)),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  if (authCon.isLoginForm.isTrue) {
                    authCon.loginUser();
                  } else {
                    authCon.registerUser();
                  }
                }
              },
              child: CapsoleContainer(
                color: MyColors.kGreenClr,
                h: 45,
                w: double.infinity,
                text: authCon.isLoginForm.isTrue ? 'Login' : 'Register',
              ),
            ),
            const SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }

  Column topHeader() {
    return Column(
      children: [
        Text(
          authCon.isLoginForm.isTrue ? 'Login' : 'Register',
          style: MyStyles.poppinsBold(fontSize: 30),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Chance to get your\n life better',
          textAlign: TextAlign.center,
          style: MyStyles.poppinsRegular(fontSize: 20),
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
