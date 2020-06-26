import 'package:sbph_app/ui/shared/ui_helpers.dart';
import 'package:sbph_app/ui/widgets/busy_button.dart';
import 'package:sbph_app/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sbph_app/ui/widgets/text_link.dart';
import 'package:sbph_app/viewmodels/signup_view_model.dart';

class SignUpView extends StatelessWidget {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final focusLastName = FocusNode();
  final focusEmail = FocusNode();
  final focusPassword = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SignUpViewModel>.withConsumer(
      viewModel: SignUpViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth(context)/8, vertical: screenHeight(context)/6),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Sign Up',
                style: Theme.of(context).textTheme.headline4.apply(color: Color(0xff009051)),
              ),
              verticalSpaceLarge,
              InputField(
                autoFocus: true,
                placeholder: 'First Name',
                controller: firstNameController,
                nextFocusNode: focusLastName,
              ),
              verticalSpaceSmall,
              InputField(
                fieldFocusNode: focusLastName,
                placeholder: 'Last Name',
                controller: lastNameController,
                nextFocusNode: focusEmail,
              ),
              verticalSpaceSmall,
              InputField(
                fieldFocusNode: focusEmail,
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
                additionalNote: 'Password has to be a minimum of 6 characters.',
                enterPressed: () => FocusScope.of(context).unfocus(),
              ),
              verticalSpaceMedium,
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextLink(
                    'Back',
                    onPressed: () {
                      model.back();
                    },
                  ),
                  horizontalSpaceSmall,
                  BusyButton(
                    title: 'Sign Up',
                    busy: model.busy,
                    onPressed: () {
                      model.signUp(
                        firstName: firstNameController.text, 
                        lastName: lastNameController.text, 
                        email: emailController.text, 
                        password: passwordController.text
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
