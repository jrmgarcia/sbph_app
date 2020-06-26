import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sbph_app/locator.dart';
import 'package:sbph_app/services/authentication_service.dart';
import 'package:sbph_app/ui/shared/ui_helpers.dart';
import 'package:sbph_app/ui/widgets/busy_button.dart';
import 'package:sbph_app/ui/widgets/input_field.dart';
import 'package:sbph_app/viewmodels/home_view_model.dart';

class HomeView extends StatelessWidget {
  // const HomeView({Key key}) : super(key: key);

  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = _authenticationService.currentUser;
    return ViewModelProvider<HomeViewModel>.withConsumer(
      viewModel: HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth(context)/8, vertical: screenHeight(context)/4),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Welcome!',
                style: Theme.of(context).textTheme.headline4.apply(color: Color(0xff009051)),
              ),
              verticalSpaceLarge,
              Text('Full Name', style: Theme.of(context).textTheme.subtitle2),
              verticalSpaceTiny,
              InputField(
                placeholder: user.firstName + user.lastName,
                controller: textController,
                isReadOnly: true
              ),
              verticalSpaceSmall,
              Text('Email', style: Theme.of(context).textTheme.subtitle2),
              verticalSpaceTiny,
              InputField(
                placeholder: user.email,
                controller: textController,
                isReadOnly: true
              ),
              verticalSpaceLarge,
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BusyButton(
                    title: 'Log Out',
                    onPressed: () {
                      model.logout();
                    },
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
