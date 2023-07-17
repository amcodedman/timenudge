import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timenudge/common/ultils/appstyle.dart';
import 'package:timenudge/common/ultils/constants.dart';
import 'package:timenudge/common/ultils/resuables.dart';
import 'package:timenudge/common/widgets/customebtn.dart';
import 'package:timenudge/common/widgets/customerextfield.dart';
import 'package:timenudge/common/widgets/heightspacer.dart';
import 'package:timenudge/common/widgets/widthspacer.dart';
import 'package:timenudge/features/auth/controllers/users.dart';
import 'package:timenudge/features/auth/pages/login.dart';

class CreateAccount extends ConsumerStatefulWidget {
  CreateAccount({Key? key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CreateAccount();
  }
}

class _CreateAccount extends ConsumerState<CreateAccount> {
  final TextEditingController textcontroller = TextEditingController();
  late String firstname;
  late String lastname;
  late String email;
  late String password;
  late String compass;
  late String username;
  late String institution;
  late String department;
  late bool success = false;
  @override
  Widget build(BuildContext context) {
    success = ref.watch(usersProvider.notifier).success;
    return Scaffold(
      backgroundColor: AppConsts.klight,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Image.asset("assets/images/create.jpg"),
            ),
            const Heightspacer(value: 20),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Welcome to Timenudge. Sign up now for great experience",
                style: appStyle(24, AppConsts.kBKDark, FontWeight.bold),
              ),
            ),
            const Heightspacer(value: 20),
            CustomTextField(
                secure: false,
                autocor: true,
                hint: "firstname",
                preficon: const Icon(Ionicons.person),
                onChange: (value) {
                  setState(() {
                    firstname = value;
                  });
                  print({"f": firstname});
                }),
            const Heightspacer(value: 10),
            CustomTextField(
                secure: false,
                autocor: true,
                hint: "lastname",
                preficon: const Icon(Ionicons.person),
                onChange: (value) {
                  setState(() {
                    lastname = value;
                  });
                  print({"f": lastname});
                }),
            const Heightspacer(value: 10),
            CustomTextField(
                secure: false,
                autocor: true,
                hint: "Emai",
                preficon: const Icon(Ionicons.mail_open_outline),
                onChange: (value) {
                  setState(() {
                    email = value;
                  });
                }),
            const Heightspacer(value: 10),
            CustomTextField(
                secure: false,
                autocor: true,
                hint: "Create a username",
                preficon: const Icon(Ionicons.people_circle),
                onChange: (value) {
                  setState(() {
                    username = value;
                  });
                }),
            const Heightspacer(value: 10),
            CustomTextField(
                secure: false,
                autocor: true,
                hint: "Institution",
                preficon: const Icon(Ionicons.home_outline),
                onChange: (value) {
                  setState(() {
                    institution = value;
                  });
                }),
            const Heightspacer(value: 10),
            CustomTextField(
                secure: false,
                autocor: true,
                hint: "Department",
                preficon: const Icon(Ionicons.business_outline),
                onChange: (value) {
                  setState(() {
                    department = value;
                  });
                }),
            const Heightspacer(value: 10),
            CustomTextField(
                secure: true,
                autocor: false,
                hint: "password",
                preficon: const Icon(Ionicons.lock_open_outline),
                onChange: (value) {
                  setState(() {
                    password = value;
                  });
                }),
            const Heightspacer(value: 10),
            CustomTextField(
                secure: true,
                autocor: false,
                hint: "Comfirm Password",
                preficon: const Icon(Ionicons.lock_open_outline),
                onChange: (value) {
                  setState(() {
                    compass = value;
                  });
                }),
            const Heightspacer(value: 10),
            ref.watch(usersProvider)
                ? const SizedBox(
                    height: 30,
                    width: 30,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ))
                : CustomBtn(
                    onTap: () async {
                      ref.read(usersProvider.notifier).result(
                            firstname,
                            lastname,
                            username,
                            email,
                            password,
                            institution,
                            department,
                          );
                    },
                    height: 40,
                    width: 50,
                    color2: AppConsts.kGreyBk,
                    color3: AppConsts.klight,
                    text1: "Register "),
            const Heightspacer(value: 20),
            success
                ? Reusables(
                    text:
                        "Please check your email inbox to verify your account",
                    style: appStyle(15, AppConsts.kGreen, FontWeight.bold))
                : Text(
                    ref.watch(usersProvider.notifier).errormessage,
                    style: appStyle(15, AppConsts.kred, FontWeight.bold),
                  ),
            Heightspacer(value: 20),
            Row(
              children: [
                Text(
                  "You already have an account ?",
                  style: appStyle(13, AppConsts.kBluelight, FontWeight.normal),
                ),
                WidthSpacer(value: 10),
                CustomBtn(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return Login();
                      }));
                    },
                    height: 30,
                    width: 130,
                    color2: AppConsts.klight,
                    color3: AppConsts.kBLight,
                    text1: "Login")
              ],
            ),
            const Heightspacer(value: 50),
          ],
        ),
      )),
    );
  }
}
