import 'package:alvamind_library_two/app/asset/app_assets.dart';
import 'package:alvamind_library_two/app/theme/app_colors.dart';
import 'package:alvamind_library_two/app/theme/app_sizes.dart';
import 'package:alvamind_library_two/app/theme/app_text_style.dart';
import 'package:alvamind_library_two/widget/atom/app_button.dart';
import 'package:alvamind_library_two/widget/atom/app_text_field.dart';
import 'package:alvamind_library_two/widget/atom/app_text_fields_wrapper.dart';
import 'package:alvamind_library_two/widget/molecule/circles_background.dart';
import 'package:bangsatnyacintapertama/app/service/locator/service_locator.dart';
import 'package:flutter/material.dart';

import '../../view_model/main_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static String routeName = '/login-screen';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CirclesBackground(
        body: body(),
      ),
    );
  }

  Widget body() {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo(),
            // const SizedBox(height: AppSizes.padding * 3),
            welcomeText(),
            const SizedBox(height: AppSizes.padding * 3),
            form(),
            const SizedBox(height: AppSizes.padding * 2),
            loginButton(),
            registerTextButton(),
          ],
        ),
      ),
    );
  }

  // Widget logo() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(
  //       horizontal: AppSizes.padding * 2,
  //     ),
  //     child: const AppImage(
  //       image: AppAssets.longLogoPath,
  //       imgProvider: ImgProvider.networkImage,
  //     ),
  //   );
  // }

  Widget welcomeText() {
    return Column(
      children: [
        Text(
          'Bangsatnya Cinta pertama',
          style: AppTextStyle.bold(
            context,
            fontSize: 26,
          ),
        ),
        const SizedBox(height: AppSizes.padding / 2),
        Text(
          'Masukan Info login untuk Akses Admin Area',
          style: AppTextStyle.medium(
            context,
            fontSize: 14,
            color: AppColors.baseLv4,
          ),
        ),
      ],
    );
  }

  Widget form() {
    return AppTextFieldsWrapper(
      textFields: [
        AppTextField(
          // controller: model.emailController,
          suffixIcon: Image.asset(AppAssets.contactFormIconPath),
          lableText: 'Email',
        ),
        const Divider(
          color: AppColors.baseLv6,
          thickness: 1.5,
          height: 0,
        ),
        const AppTextField(
          // controller: model.passwordController,
          type: AppTextFieldType.password,
          lableText: 'Password',
        ),
      ],
    );
  }

  Widget loginButton() {
    return AppButton(
      text: 'Masuk',
      onTap: () {
        // TODO REMOVE
        locator<MainViewModel>().userId = "";
        locator<MainViewModel>().notifyListeners();
      },
    );
  }

  Widget registerTextButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.padding),
      child: Wrap(
        spacing: 2,
        children: [
          Text(
            'Belum punya akun?',
            style: AppTextStyle.extraBold(context),
          ),
          InkWell(
            onTap: () {
              // TODO
            },
            child: Text(
              'Hubungi Support Center',
              style: AppTextStyle.extraBold(
                context,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
