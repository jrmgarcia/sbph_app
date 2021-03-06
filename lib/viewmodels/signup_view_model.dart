import 'package:flutter/foundation.dart';
import 'package:sbph_app/constants/route_names.dart';
import 'package:sbph_app/locator.dart';
import 'package:sbph_app/services/authentication_service.dart';
import 'package:sbph_app/services/dialog_service.dart';
import 'package:sbph_app/services/navigation_service.dart';
import 'package:sbph_app/viewmodels/base_model.dart';

class SignUpViewModel extends BaseModel {

  final AuthenticationService _authenticationService = 
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future signUp({
    @required String firstName,
    @required String lastName,
    @required String email,
    @required String password
  }) async {
    setBusy(true);

    var result = await _authenticationService.signUpWithEmail(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(HomeViewRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Sign Up Failed',
          description: 'Please try again later.'
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Sign Up Failed',
        description: result
      );
    }
  }

  void back() {
    _navigationService.pop();
  }

}