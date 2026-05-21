import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider =  // klasörlerdeki repository dosyalarında provider oluşturulur
  Provider((ref) => AuthRepository(auth: FirebaseAuth.instance));

class AuthRepository {
  final FirebaseAuth auth;

  AuthRepository({ // constructor
    required this.auth});

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password
    }) async{
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password);
  }
}