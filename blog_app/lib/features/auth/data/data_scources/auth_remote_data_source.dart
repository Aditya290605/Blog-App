import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentSession;

  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> userData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Session? get currentSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      if (response.user == null) {
        throw ServerException('Failed to sign up user is null');
      }
      final res = response.user!.toJson();
      return UserModel.toJson(res);
    } catch (e) {
      throw ServerException('Failed to sign up: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final resonse = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );

      if (resonse.user == null) {
        throw ServerException('Failed to sign in user is null');
      }

      final res = resonse.user!.toJson();
      return UserModel.toJson(res);
    } catch (e) {
      throw ServerException('Failed to sign in: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> userData() async {
    try {
      if (currentSession != null) {
        final res = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentSession!.user.id);
        return UserModel.toJson(
          res.first,
        ).copyWith(email: currentSession!.user.email);
      }
      return null;
    } catch (e) {
      throw ServerException('Failed to get user data: ${e.toString()}');
    }
  }
}
