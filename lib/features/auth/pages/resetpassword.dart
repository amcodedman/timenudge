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
import 'package:timenudge/features/auth/pages/login.dart';

import '../controllers/users.dart';

class ResetPass extends ConsumerStatefulWidget {
  ResetPass({Key? key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ResetPass();
  }
}

class _ResetPass extends ConsumerState<ResetPass> {
  late bool success = false;
  late String email;
  final TextEditingController textcontroller = TextEditingController();
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
              child: Image.asset("assets/images/passw.jpg"),
            ),
            const Heightspacer(value: 10),
            const Text(
                "Enter your email address. We will send you a link to recover your account"),
            const Heightspacer(value: 10),
            CustomTextField(
                secure: false,
                autocor: false,
                hint: "Email address",
                preficon: const Icon(Ionicons.mail_open_outline),
                onChange: (value) {
                  setState(() {
                    email = value;
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
                    onTap: () {
                      ref.read(usersProvider.notifier).forgotpassword(email);
                    },
                    height: 40,
                    width: 50,
                    color2: AppConsts.kGreyBk,
                    color3: AppConsts.klight,
                    text1: "Continue "),
            const Heightspacer(value: 20),
            Text(
              ref.watch(usersProvider.notifier).errormessage,
              style: appStyle(
                  15, Color.fromARGB(255, 60, 185, 112), FontWeight.bold),
            ),
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
