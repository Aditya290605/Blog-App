import 'package:blog_app/core/entities/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void updateUser(UserProfile? user) {
    if (user == null) {
      emit(AppUserInitial());
    } else {
      emit(AppUserLogedIn(user));
    }
  }
}
