import 'package:bazaar/screen/address/address.dart';
import 'package:bazaar/screen/drawer/drawer_controller.dart';
import 'package:bazaar/screen/logout/logout.dart';
import 'package:bazaar/screen/monthlygroceries/monthlygrc.dart';
import 'package:bazaar/screen/orders/orders.dart';
import 'package:bazaar/screen/profile/profile.dart';
import 'package:bazaar/screen/register/register.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  //var userdata = FirebaseFirestore.instance.collection("users-form-data").doc(FirebaseAuth.instance.currentUser!.email).snapshots();
  Stream? documentStream;
  // var isLogIn = false;
  var userid = "";
  final MyDrawerController controller = Get.put(MyDrawerController());

  @override
  Widget build(BuildContext context) {
    controller.getUser();

    return Container(
      color: Colors.white,
      height: double.infinity,
      width: MediaQuery.of(context).size.width / 1.5,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(25),
              color: Theme.of(context).primaryColor,
              width: double.infinity,
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor,
                      size: 40,
                    ),
                  ),
                  Obx(
                    () => controller.isLogIn.value == true
                        ? Text(
                            controller.userName.value,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )
                        : TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register()));
                            },
                            child: const Text(
                              "Register/Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )),
                  ),
                ],
              ),
            ),
            Obx(() => controller.isLogIn.value == true
                ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile()));
                              },
                              child: Text(
                                "Profile",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Address()));
                              },
                              child: Text("Address",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor))),
                          const SizedBox(
                            height: 15,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Orders()));
                              },
                              child: Text("Orders",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor))),
                          const SizedBox(
                            height: 15,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Monthlygrc()));
                              },
                              child: Text("Monthly groceries",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor))),
                          Divider(
                            color: Theme.of(context).primaryColor,
                          ),
                          TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => LogOut());
                              },
                              child: Text("Log out",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor))),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(
                    child: Text(""),
                  ))
          ],
        ),
      ),
    );
  }
}
