import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timenudge/common/ultils/appstyle.dart';
import 'package:timenudge/common/ultils/constants.dart';
import 'package:timenudge/common/ultils/resuables.dart';
import 'package:timenudge/common/widgets/widthspacer.dart';
import 'package:timenudge/features/auth/controllers/users.dart';
import 'package:timenudge/features/onboarding/pages/onboarding.dart';
import 'package:timenudge/main.dart';

class MyAccout extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _Account();
  }
}

class _Account extends ConsumerState<MyAccout> {
  late SharedPreferences prefs;
  Future<void> loadDetails() async {
    prefs = await SharedPreferences.getInstance();
    print(prefs?.getString("firstname").toString());
    setState(() {
      String? firstn = prefs.getString("firstname").toString();
      String? lastn = prefs.getString("lastname").toString();
      myname = firstn! + " " + lastn!;
      user_email = prefs.getString("email").toString();
      user_name = prefs.getString("username").toString();
      institution = prefs.getString("company").toString();
      department = prefs.getString("department").toString();
    });
  }

  Future<void> signout() async {
    prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    loadDetails();
  }

  late String? myname = "";
  late String? user_name = "";
  late String? user_email = "";
  late String? institution = "";
  late String? department = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          'My Account',
          style: appStyle(17, AppConsts.kGreyBk, FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Center(
                  // Adjust the left position as needed
                  child: CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage("assets/images/person.png"),
              )),
              Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                width: AppConsts.kwidth * 0.8.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 231, 230, 230)
                            .withOpacity(0.5), // Shadow color
                        spreadRadius: 5, // Spread radius
                        blurRadius: 7, // Blur radius
                        offset: const Offset(0, 3), // Offset
                      ),
                    ]),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Reusables(
                          text: "Name",
                          style: appStyle(
                              15, AppConsts.kBluelight, FontWeight.bold)),
                      Reusables(
                          text: myname!,
                          style:
                              appStyle(14, AppConsts.kGreyBk, FontWeight.bold)),
                    ]),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                width: AppConsts.kwidth * 0.8.w,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 247, 242, 242)
                            .withOpacity(0.5), // Shadow color
                        spreadRadius: 5, // Spread radius
                        blurRadius: 7, // Blur radius
                        offset: const Offset(0, 3), // Offset
                      ),
                    ]),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Reusables(
                          text: "User name",
                          style: appStyle(
                              15, AppConsts.kBluelight, FontWeight.bold)),
                      Reusables(
                          text: user_name!,
                          style:
                              appStyle(14, AppConsts.kGreyBk, FontWeight.bold)),
                    ]),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                width: AppConsts.kwidth * 0.8.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 231, 230, 230)
                            .withOpacity(0.5), // Shadow color
                        spreadRadius: 5, // Spread radius
                        blurRadius: 7, // Blur radius
                        offset: const Offset(0, 3), // Offset
                      ),
                    ]),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Reusables(
                          text: "Email",
                          style: appStyle(
                              15, AppConsts.kBluelight, FontWeight.bold)),
                      Reusables(
                          text: user_email!,
                          style:
                              appStyle(14, AppConsts.kGreyBk, FontWeight.bold)),
                    ]),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                width: AppConsts.kwidth * 0.8.w,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 247, 241, 241)
                            .withOpacity(0.5), // Shadow color
                        spreadRadius: 5, // Spread radius
                        blurRadius: 7, // Blur radius
                        offset: const Offset(0, 3), // Offset
                      ),
                    ]),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Reusables(
                          text: "Institution",
                          style: appStyle(
                              15, AppConsts.kBluelight, FontWeight.bold)),
                      Reusables(
                          text: institution!,
                          style:
                              appStyle(14, AppConsts.kGreyBk, FontWeight.bold)),
                    ]),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                width: AppConsts.kwidth * 0.8.w,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 231, 230, 230)
                            .withOpacity(0.5), // Shadow color
                        spreadRadius: 5, // Spread radius
                        blurRadius: 7, // Blur radius
                        offset: const Offset(0, 3), // Offset
                      ),
                    ]),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Reusables(
                          text: "Department",
                          style: appStyle(
                              15, AppConsts.kBluelight, FontWeight.bold)),
                      Reusables(
                          text: department!,
                          style:
                              appStyle(14, AppConsts.kGreyBk, FontWeight.bold)),
                    ]),
              ),
              MaterialButton(
                  onPressed: () {
                    signout();

                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return Onboarding();
                    }));

                    ref.read(usersProvider);
                  },
                  child: Container(
                      height: 40,
                      width: AppConsts.kwidth * 0.4.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppConsts.klight,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 5, // Spread radius
                              blurRadius: 7, // Blur radius
                              offset: const Offset(0, 3), // Offset
                            ),
                          ],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          )),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              const Icon(Ionicons.log_out),
                              const WidthSpacer(value: 10),
                              Reusables(
                                  text: "Signout",
                                  style: appStyle(18, AppConsts.kBluelight,
                                      FontWeight.bold))
                            ],
                          ))))
            ]),
      ),
    );
  }
}
