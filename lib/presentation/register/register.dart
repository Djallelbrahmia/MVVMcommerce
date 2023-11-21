import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommvvm/app/app_prefs.dart';
import 'package:ecommvvm/app/di.dart';
import 'package:ecommvvm/data/mapper/mapper.dart';
import 'package:ecommvvm/presentation/common/state_renderer/state_rendrer_impl.dart';
import 'package:ecommvvm/presentation/register/register_view_model.dart';
import 'package:ecommvvm/presentation/ressources/assets_manager.dart';
import 'package:ecommvvm/presentation/ressources/color_manager.dart';
import 'package:ecommvvm/presentation/ressources/routes_manager.dart';
import 'package:ecommvvm/presentation/ressources/string_manager.dart';
import 'package:ecommvvm/presentation/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterViewModel _viewModel = instance<RegisterViewModel>();
  ImagePicker picker = instance<ImagePicker>();
  final _formKey = GlobalKey<FormState>();
  AppPrefrences _appPrefrences = instance<AppPrefrences>();

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();

  _bind() {
    _viewModel.start();
    _userNameController.addListener(() {
      _viewModel.setUserName(_userNameController.text);
    });
    _emailController.addListener(() {
      _viewModel.setEmail(_emailController.text);
    });
    _passwordController.addListener(() {
      _viewModel.setPassword(_passwordController.text);
    });
    _mobileController.addListener(() {
      _viewModel.setMobileNumber(_mobileController.text);
    });
  }

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
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: AppSize.s0,
        iconTheme: IconThemeData(color: ColorManager.primary),
        backgroundColor: ColorManager.white,
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outPutState,
        builder: (context, snapshot) {
          return Center(
            child: snapshot.data?.getScreenWidget(context, _getContentWidget(),
                    () {
                  _viewModel.register();
                }) ??
                _getContentWidget(),
          );
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p20),
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
                  child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorUserName,
                    builder: (context, snapshot) {
                      return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _userNameController,
                          decoration: InputDecoration(
                            hintText: AppStrings.username.tr(),
                            labelText: AppStrings.username.tr(),
                            errorText: snapshot.data,
                          ));
                    },
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: AppPadding.p16,
                        left: AppPadding.p20,
                        right: AppPadding.p20,
                        bottom: AppPadding.p20),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: CountryCodePicker(
                              onChanged: (countryCode) {
                                _viewModel.setCountryCode(
                                    countryCode.dialCode ?? EMPTY);
                              },
                              initialSelection: "+213",
                              showCountryOnly: true,
                              hideMainText: true,
                              showOnlyCountryWhenClosed: true,
                              favorite: const ["+213"],
                            )),
                        Expanded(
                          flex: 4,
                          child: StreamBuilder<String?>(
                            stream: _viewModel.outputErrorMobileNumber,
                            builder: (context, snapshot) {
                              return TextFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: _mobileController,
                                  decoration: InputDecoration(
                                    hintText: AppStrings.mobileNumber.tr(),
                                    labelText: AppStrings.mobileNumber.tr(),
                                    errorText: snapshot.data,
                                  ));
                            },
                          ),
                        )
                      ],
                    ),
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
                  child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorEmail,
                    builder: (context, snapshot) {
                      return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: AppStrings.emailHint,
                            labelText: AppStrings.emailHint,
                            errorText: snapshot.data,
                          ));
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
                  child: Container(
                    height: AppSize.s40,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorManager.lightGrey),
                    ),
                    child: GestureDetector(
                      child: _getMediaWidget(),
                      onTap: () {
                        _showPicker(context);
                      },
                    ),
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
                  child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorPassword,
                    builder: (context, snapshot) {
                      return TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: AppStrings.password.tr(),
                            labelText: AppStrings.password.tr(),
                            errorText: snapshot.data,
                          ));
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
                    stream: _viewModel.outputIsAllInputsValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? () {
                                    _viewModel.register();
                                  }
                                : null,
                            child: Text(AppStrings.register.tr())),
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
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(Routes.loginRoute);
                    },
                    child: Text(
                      AppStrings.haveAccount.tr(),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget _getMediaWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(AppStrings.profilePicture.tr())),
          Flexible(
            child: Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p20,
                  right: AppMargin.m20,
                ),
                child: StreamBuilder<File?>(
                  stream: _viewModel.outputProfilePicture,
                  builder: (context, snapshot) {
                    return _imagePickedByUser(snapshot.data);
                  },
                )),
          ),
          Flexible(
            child: SvgPicture.asset(ImageAssets.cameraIc),
          )
        ],
      ),
    );
  }

  Widget _imagePickedByUser(File? image) {
    if (image != null && image.path.isEmpty) {
      return Image.file(image);
    } else {
      return Container();
    }
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera),
                title: Text(AppStrings.photoGalley.tr()),
                onTap: () {
                  _imageFormGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera_alt_rounded),
                title: Text(AppStrings.photoCamera.tr()),
                onTap: () {
                  _imageFormCamera();
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
        });
  }

  _imageFormGallery() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  _imageFormCamera() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }
}
