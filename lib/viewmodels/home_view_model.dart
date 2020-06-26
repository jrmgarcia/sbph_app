import 'package:sbph_app/locator.dart';
import 'package:sbph_app/services/authentication_service.dart';
import 'package:sbph_app/services/navigation_service.dart';
import 'package:sbph_app/viewmodels/base_model.dart';

class HomeViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService = locator<AuthenticationService>();

  Future logout() async {
    await _authenticationService.logout();
    _navigationService.pop();
  }
}