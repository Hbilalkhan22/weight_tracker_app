// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weight_tracker/app/constants/My%20Widgets/capsole_container.dart';
import 'package:weight_tracker/app/constants/My%20Widgets/my_text_field.dart';
import 'package:weight_tracker/app/constants/colors.dart';
import 'package:weight_tracker/app/constants/styles.dart';
import 'package:weight_tracker/app/modules/Auth/controllers/auth_controller.dart';

class AuthView extends HookConsumerWidget {
  AuthView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLogin = ref.watch(isLoginProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(gradient: MyStyles.kGradient),
            child: Column(
                mainAxisAlignment: isLogin == true
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.center,
                children: [
                  /// top title of login screen
                  topHeader(isLogin: isLogin),

                  /// Login Form of Login Screen which have TextFields and Login Button
                  loginForm(ref: ref),

                  /// bottom section of Login Screen e.g. Social Links & Register now button etc.
                  loginBottomSection(ref: ref)
                ]),
          )),
    );
  }

  Widget loginBottomSection({required WidgetRef ref}) {
    final isLogin = ref.watch(isLoginProvider);
    return Column(
      children: [
        Visibility(
          visible: isLogin ? true : false,
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
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLogin ? 'Not a member?' : 'Already have account?',
              style: MyStyles.poppinsMedium(
                  color: MyColors.kBlackClr.withOpacity(0.6)),
            ),
            const SizedBox(
              width: 5,
            ),
            InkWell(
              onTap: () {
                ref.read(isLoginProvider.notifier).state = !isLogin;
              },
              child: Text(
                isLogin ? 'Register now' : 'Login',
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

  Padding loginForm({required WidgetRef ref}) {
    final authProvider = ref.read(authConProvider);
    final isShowPass = ref.watch(showPassProvider);
    final isLogin = ref.watch(isLoginProvider);
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
              controller: authProvider.emailTextController,
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
            MTextField(
              label: 'Password',
              controller: authProvider.passwordTextController,
              obsecure: isShowPass ? false : true,
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
                    ref.read(showPassProvider.notifier).state = !isShowPass,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(
                      isShowPass ? Icons.visibility : Icons.visibility_off),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Visibility(
              visible: isLogin ? true : false,
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
                  if (isLogin == true) {
                    authProvider.loginUser();
                  } else {
                    authProvider.registerUser();
                  }
                }
              },
              child: CapsoleContainer(
                color: MyColors.kGreenClr,
                h: 45,
                w: double.infinity,
                text: isLogin ? 'Login' : 'Register',
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

  Column topHeader({var isLogin}) {
    return Column(
      children: [
        Text(
          isLogin ? 'Login' : 'Register',
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
