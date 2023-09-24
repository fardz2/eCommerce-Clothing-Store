import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  late String? uid;
  late String? name;
  late FirebaseAuth auth;

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return {"error": false, "message": "berhasil"};
    } on FirebaseAuthException catch (e) {
      return {"error": true, "message": "${e.message}"};
    } catch (e) {
      return {"error": true, "message": "tidak dapat login"};
    }
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return {"error": false, "message": "berhasil"};
    } on FirebaseAuthException catch (e) {
      return {"error": true, "message": "${e.message}"};
    } catch (e) {
      return {"error": true, "message": "tidak register"};
    }
  }

  Future<Map<String, dynamic>> logout() async {
    try {
      await auth.signOut();
      return {"error": false, "message": "berhasil"};
    } on FirebaseAuthException catch (e) {
      return {"error": true, "message": "${e.message}"};
    } catch (e) {
      return {"error": true, "message": "tidak berhasil"};
    }
  }

  @override
  void onInit() {
    auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((event) {
      uid = event?.uid;
      name = event?.email;
    });
    super.onInit();
  }
}
