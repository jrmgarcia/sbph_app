import 'package:sbph_app/ui/shared/ui_helpers.dart';
import 'package:sbph_app/ui/widgets/busy_button.dart';
import 'package:sbph_app/ui/widgets/input_field.dart';
import 'package:sbph_app/ui/widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sbph_app/viewmodels/login_view_model.dart';

class LoginView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final focusPassword = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<LoginViewModel>.withConsumer(
      viewModel: LoginViewModel(),
      builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenWidth(context)/8, vertical: screenHeight(context)/6),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 150,
                  child: Image.asset('assets/images/title.png'),
                ),
                verticalSpaceMedium,
                InputField(
                  placeholder: 'Email',
                  controller: emailController,
                  nextFocusNode: focusPassword,
                ),
                verticalSpaceSmall,
                InputField(
                  fieldFocusNode: focusPassword,
                  placeholder: 'Password',
                  password: true,
                  controller: passwordController,
                  enterPressed: () {
                    model.login(email: emailController.text, password: passwordController.text);
                  }
                ),
                verticalSpaceMedium,
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextLink(
                      'Create an Account',
                      onPressed: () {
                        model.navigateToSignUp();
                      },
                    ),
                    horizontalSpaceSmall,
                    BusyButton(
                      title: 'Login',
                      busy: model.busy,
                      onPressed: () {
                        model.login(email: emailController.text, password: passwordController.text);
                      },
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
