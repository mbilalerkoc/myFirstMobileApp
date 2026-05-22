import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myfirstapp/models/user_model.dart';

final authRepositoryProvider = // klasörlerdeki repository dosyalarında provider oluşturulur
Provider(
  (ref) => AuthRepository(auth: FirebaseAuth.instance, firebaseFirestore: FirebaseFirestore.instance),
);

class AuthRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth auth;

  AuthRepository({
    // constructor
    required this.auth, required this.firebaseFirestore,
  });

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<void> storeUserInfoToFirebase(UserModel userModel) async {
    // Firestore'a kullanıcı bilgilerini kaydetme işlemi burada yapılır
    if (userModel.profilePhoto == null) {
      userModel = userModel.copyWith(profilePhoto: "https://www.pngall.com/wp-content/uploads/5/Profile-PNG-High-Quality-Image.png");
    }

    userModel.uid = auth.currentUser!.uid; // kullanıcı id'si auth.currentUser!.uid ile alınır
    await FirebaseFirestore.instance 
        .collection("users")// users adında bir koleksiyon oluşturulur
        .doc(auth.currentUser!.uid)// kullanıcı id'si ile bir belge oluşturulur
        .set(userModel.toMap());// kullanıcı bilgileri belgeye kaydedilir
  }
}
