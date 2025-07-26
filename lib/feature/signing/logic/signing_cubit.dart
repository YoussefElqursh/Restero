import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restero/feature/signing/data/model/user_model.dart';
import 'package:restero/feature/signing/logic/signing_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  UserModel? currentUser;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user!;
      currentUser = UserModel(
        uid: user.uid,
        email: user.email ?? '',
        name: user.displayName ?? '',
      );

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? 'Unknown error'));
    }
  }
}
