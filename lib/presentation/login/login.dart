import 'package:easy_localization/easy_localization.dart';
import 'package:ecommvvm/app/app_prefs.dart';
import 'package:ecommvvm/app/di.dart';
import 'package:ecommvvm/presentation/common/state_renderer/state_rendrer_impl.dart';
import 'package:ecommvvm/presentation/login/login_view_model.dart';
import 'package:ecommvvm/presentation/ressources/assets_manager.dart';
import 'package:ecommvvm/presentation/ressources/color_manager.dart';
import 'package:ecommvvm/presentation/ressources/routes_manager.dart';
import 'package:ecommvvm/presentation/ressources/string_manager.dart';
import 'package:ecommvvm/presentation/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModel _viewModel = instance<LoginViewModel>();
  AppPrefrences _appPrefrences = instance<AppPrefrences>();
  _bind() {
    _viewModel.start();
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
  }

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _bind();
    _viewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isSuccess) {
      if (isSuccess) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPrefrences.setIsUserLoggedIn();
          Navigator.of(context).popAndPushNamed(Routes.mainRoute);
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outPutState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.login();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      color: ColorManager.white,
      child: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(ImageAssets.splashlogo),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppPadding.p20,
                    right: AppMargin.m20,
                  ),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsUserNameValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _userNameController,
                        decoration: InputDecoration(
                            hintText: AppStrings.username.tr(),
                            labelText: AppStrings.username.tr(),
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.usernameError.tr()),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppPadding.p20,
                    right: AppMargin.m20,
                  ),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputPasswordValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        decoration: InputDecoration(
                            hintText: AppStrings.password.tr(),
                            labelText: AppStrings.password.tr(),
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.passwordError.tr()),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppPadding.p20,
                    right: AppMargin.m20,
                  ),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputisAllInputValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? () {
                                    _viewModel.login();
                                  }
                                : null,
                            child: const Text(AppStrings.login)),
                      );
                    },
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      top: AppPadding.p8,
                      left: AppPadding.p20,
                      right: AppMargin.m20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(
                                Routes.forgetPasswordRoute);
                          },
                          child: Text(
                            AppStrings.forgetPassword,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(Routes.registerRoute);
                          },
                          child: Text(
                            AppStrings.registerText,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ],
                    ))
              ],
            )),
      ),
    );
  }
}
