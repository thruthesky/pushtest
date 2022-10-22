import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class PushTestFirebaseUser {
  PushTestFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

PushTestFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<PushTestFirebaseUser> pushTestFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<PushTestFirebaseUser>(
      (user) {
        currentUser = PushTestFirebaseUser(user);
        return currentUser!;
      },
    );
