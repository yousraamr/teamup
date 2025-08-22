import 'package:firebase_auth/firebase_auth.dart';
import 'package:teamup_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signIn(String email, String password);
  Future<UserEntity> signUp(String email, String password, String name);
  Future<void> sendPasswordResetEmail(String email);
  Future<void> signOut();
  Stream<UserEntity?> getUser(); // listen for auth changes
}