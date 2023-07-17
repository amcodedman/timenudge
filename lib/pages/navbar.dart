import 'package:provider/provider.dart';
import 'package:timenudge/pages/account.dart';
import 'package:timenudge/pages/activities.dart';
import 'package:timenudge/pages/forum.dart';
import 'package:timenudge/pages/homep.dart';
import 'package:timenudge/pages/shedule.dart';
import 'package:timenudge/pages/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timenudge/provider/homeprovider.dart';

class NavBar extends StatelessWidget {
  NavBar();
  HomeProvider? _homeProvider;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(context: context),
      child: Scaff(),
    );
  }

  Widget Scaff() {
    return Builder(builder: (context) {
      _homeProvider = context.watch<HomeProvider>();
      if (_homeProvider!.datalist != null) {
        return Text("home");
      } else {
        return const Center(
          child: CircularProgressIndicator(color: Colors.blue),
        );
      }
    });
  }

  Widget Scaffi() {
    return Scaffold(
      body: Column(children: [
        MaterialButton(
          child: const Icon(Icons.push_pin),
          onPressed: () {},
        )
      ]),
    );
  }
}
