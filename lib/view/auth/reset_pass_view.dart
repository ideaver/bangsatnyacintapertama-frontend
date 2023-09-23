import 'package:flutter/material.dart';

import '../../app/asset/app_assets.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_text_style.dart';
import '../../app/utility/validator.dart';
import '../../widget/atom/app_button.dart';
import '../../widget/atom/app_image.dart';
import '../../widget/atom/app_text_field.dart';
import '../../widget/atom/app_text_fields_wrapper.dart';
import '../../widget/molecule/circles_background.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  static String routeName = '/reset-password-screen';

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
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
            logo(),
            const SizedBox(height: AppSizes.padding * 3),
            welcomeText(),
            const SizedBox(height: AppSizes.padding * 3),
            form(),
            const SizedBox(height: AppSizes.padding * 1.5),
            validatorInfo(),
            const SizedBox(height: AppSizes.padding * 2),
            loginButton(),
            registerTextButton(),
          ],
        ),
      ),
    );
  }

  Widget bigCircle() {
    return Container(
      width: 600,
      height: 600,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(55, 114, 255, 0.05),
      ),
    );
  }

  Widget logo() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.padding * 2,
      ),
      child: const AppImage(
        image: AppAssets.longLogoPath,
        imgProvider: ImgProvider.networkImage,
      ),
    );
  }

  Widget welcomeText() {
    return Column(
      children: [
        Text(
          'Reset Password',
          style: AppTextStyle.bold(
            context,
            fontSize: 26,
          ),
        ),
        const SizedBox(height: AppSizes.padding / 2),
        Text(
          'Masukan password baru anda dan pastikan hanya anda yang dapat mengetahuinya',
          textAlign: TextAlign.center,
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
          // controller: model.newPasswordCtrl,
          type: AppTextFieldType.password,
          showSuffixButton: false,
          lableText: 'Password Baru',
          onChanged: (val) {
            setState(() {});
          },
        ),
        AppTextField(
          // controller: model.confirmPasswordCtrl,
          type: AppTextFieldType.password,
          showSuffixButton: false,
          lableText: 'Ulangi Password',
          onChanged: (val) {
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget loginButton() {
    return AppButton(
      text: 'Reset Password',
      onTap: () {
        // TODO
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
            'Terkendala Masuk?',
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

  Widget validatorInfo() {
    // TODO
    // bool isLengthMoreThan5 = model.newPasswordCtrl.text.length > 5;
    // bool isContainUppercase = Validator.isContainsUppercase(model.newPasswordCtrl.text);
    // bool isContainerNumber = Validator.isContainsNumber(model.newPasswordCtrl.text);
    // bool isConfirmPassValid = model.newPasswordCtrl.text.isNotEmpty && model.newPasswordCtrl.text == model.confirmPasswordCtrl.text;
    bool isLengthMoreThan5 = "".length > 5;
    bool isContainUppercase = Validator.isContainsUppercase("");
    bool isContainerNumber = Validator.isContainsNumber("");
    bool isConfirmPassValid = "".isNotEmpty && "" == "";

    return Column(
      children: [
        Opacity(
          opacity: isContainUppercase ? 1.0 : 0.5,
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: isContainUppercase ? AppColors.greenLv1 : AppColors.baseLv4,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                'Password mengandung karakter besar atau kecil',
                style: AppTextStyle.medium(context),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.padding / 2),
        Opacity(
          opacity: isLengthMoreThan5 ? 1.0 : 0.5,
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: isLengthMoreThan5 ? AppColors.greenLv1 : AppColors.baseLv4,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                'Password 6 atau lebih karakter',
                style: AppTextStyle.medium(context),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.padding / 2),
        Opacity(
          opacity: isContainerNumber ? 1.0 : 0.5,
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: isContainerNumber ? AppColors.greenLv1 : AppColors.baseLv4,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                'Password mengandung setidaknya 1 angka',
                style: AppTextStyle.medium(context),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.padding / 2),
        Opacity(
          opacity: isConfirmPassValid ? 1.0 : 0.5,
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: isConfirmPassValid ? AppColors.greenLv1 : AppColors.baseLv4,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                'Ulangi password harus sama',
                style: AppTextStyle.medium(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
