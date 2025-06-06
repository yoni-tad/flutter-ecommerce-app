import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  Future<AuthResponse> signup(String email, String password) {
    return supabase.auth.signUp(email: email, password: password);
  }

  Future<AuthResponse> signin(String email, String password) {
    return supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signout() => supabase.auth.signOut();

  Session? getSession() => supabase.auth.currentSession;

  Stream<AuthState> get authChanges => supabase.auth.onAuthStateChange;
}
