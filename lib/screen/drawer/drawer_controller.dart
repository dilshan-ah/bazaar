import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MyDrawerController extends GetxController {
  var isLogIn = false.obs;
  var userName = "".obs;

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  @override
  void onReady() {
    getUser();
    super.onReady();
  }

  void getUser() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        isLogIn.value = true;
        print('User signed in');
        print(user);
      } else {
        isLogIn.value = false;
        print('User signed out');
      }
    });

    if (isLogIn.value) {
      FirebaseFirestore.instance
          .collection('users-form-data')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get()
          .then((DocumentSnapshot? documentSnapshot) {
        if (documentSnapshot!.exists) {
          Map<String, dynamic> data =
              documentSnapshot.data()! as Map<String, dynamic>;
          print('Document data: ${data['name']}');
          userName.value = data['name'].toString();

          print('Document data: ${documentSnapshot.data()}');
        } else {
          print('Document does not exist on the database');
        }
      });
    }
  }
}
