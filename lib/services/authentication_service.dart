import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sbph_app/locator.dart';
import 'package:sbph_app/models/user.dart';
import 'package:sbph_app/services/firestore_service.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();

  User _currentUser;
  User get currentUser => _currentUser;

  Future loginWithEmail({
    @required String email, 
    @required String password
  }) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, 
          password: password
      );
      await _populateCurrentUser(authResult.user);
      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future signUpWithEmail({
    @required String firstName,
    @required String lastName,
    @required String email, 
    @required String password
    }
  ) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );

      // create a new user on Firestore
      _currentUser = User(
        id: authResult.user.uid,
        firstName: firstName,
        lastName: lastName,
        email: email
      );

      await _firestoreService.createUser(_currentUser);

      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    var user = await _firebaseAuth.currentUser();
    return user != null;
  }

  Future _populateCurrentUser(FirebaseUser user) async {
    if (user != null) {
      _currentUser = await _firestoreService.getUser(user.uid);
    }
  }
}
