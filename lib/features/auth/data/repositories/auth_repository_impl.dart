import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teamup_app/features/auth/domain/entities/user_entity.dart';
import 'package:teamup_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRepositoryImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  UserEntity _mapUser(User? user) {
    if (user == null) return throw Exception("User is null");
    return UserEntity(
      uid: user.uid,
      email: user.email!,
      name: user.displayName,
    );
  }

  @override
  Future<UserEntity> signIn(String email, String password) async {
    final result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    return _mapUser(result.user);
  }

  @override
  Future<UserEntity> signUp(String email, String password, String name) async {
    final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
    );

    await firestore.collection("users").doc(result.user!.uid).set({
      "name": name,
      "email": email,
      "createdAt": FieldValue.serverTimestamp(),
    });

    return _mapUser(result.user);
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signOut() async{
    await firebaseAuth.signOut();
  }

  @override
  Stream<UserEntity?> getUser() {
    return firebaseAuth.authStateChanges().map(
        (user) => user != null ? _mapUser(user) : null,
    );
  }
}