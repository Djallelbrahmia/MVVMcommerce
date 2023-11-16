import 'package:ecommvvm/app/di.dart';
import 'package:ecommvvm/presentation/common/state_renderer/state_rendrer_impl.dart';
import 'package:ecommvvm/presentation/forgot_password/forget_password_view_model.dart';
import 'package:ecommvvm/presentation/ressources/assets_manager.dart';
import 'package:ecommvvm/presentation/ressources/color_manager.dart';
import 'package:ecommvvm/presentation/ressources/string_manager.dart';
import 'package:ecommvvm/presentation/values_manager.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  ForgetPasswordViewModel _viewModel = instance<ForgetPasswordViewModel>();
  TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _emailController.addListener(
      () {
        _viewModel.setEmail(_emailController.text);
      },
    );
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _emailController.dispose();
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
                _viewModel.forgetPassword();
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
                    stream: _viewModel.outpuEmailisValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: InputDecoration(
                            hintText: AppStrings.email,
                            labelText: AppStrings.email,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.emailError),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
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
                    stream: _viewModel.outpuEmailisValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? () {
                                    _viewModel.forgetPassword();
                                  }
                                : null,
                            child: const Text(AppStrings.resetPassword)),
                      );
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
