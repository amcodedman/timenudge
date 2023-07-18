import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timenudge/common/ultils/appstyle.dart';
import 'package:timenudge/common/ultils/constants.dart';
import 'package:timenudge/common/ultils/resuables.dart';

import 'package:timenudge/common/widgets/customerextfield.dart';
import 'package:timenudge/common/widgets/heightspacer.dart';
import 'package:timenudge/common/widgets/widthspacer.dart';
import 'package:timenudge/features/todo/widgets/todotail.dart';
import 'package:timenudge/features/todo/widgets/SignUp.dart';
import 'package:timenudge/features/todo/widgets/activities.dart';
import 'package:timenudge/features/todo/widgets/forum.dart';
import 'package:timenudge/features/todo/widgets/homep.dart';
import 'package:timenudge/features/todo/widgets/shedule.dart';
import 'package:timenudge/features/todo/widgets/Account.dart';
import 'package:timenudge/features/todo/widgets/landpage.dart';

import '../controllers/expensions.dart';
import '../widgets/navbar.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends ConsumerState<HomePage> with TickerProviderStateMixin {
  final panel = [
    const LandPage(),
    Shedule(),
    Activities(),
    MyAccout(),
  ];
  late String inputtext;
  int _index = 0;

  void changePanel(int index) {
    setState(() {
      _index = index;
    });
  }

  int index() {
    return _index;
  }

  String datas() {
    return inputtext;
  }

  late final TabController tabController =
      TabController(length: 2, vsync: this);
  late bool switchv = false;
  late bool checker = false;
  late bool home = true;
  @override
  Widget build(
    BuildContext context,
  ) {
    ref.read(homeloadProvider.notifier).result();
    if (!checker) {
      ref.watch(homeloadProvider.notifier).loaded;
      ref.watch(homeloadProvider);
    }

    return Scaffold(
        bottomNavigationBar: Container(
          height: 35,
          width: AppConsts.kwidth.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 248, 246, 246),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: IconButton(
                  enableFeedback: false,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: index() == 0
                      ? const Icon(Icons.home_filled,
                          color: Color.fromARGB(255, 85, 16, 79))
                      : const Icon(Icons.home,
                          color: Color.fromARGB(255, 85, 87, 94)),
                  onPressed: () {
                    changePanel(0);
                  },
                ),
              ),
              IconButton(
                enableFeedback: false,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: index() == 1
                    ? const Icon(Icons.event,
                        color: Color.fromARGB(255, 85, 16, 79))
                    : const Icon(Icons.event_available_rounded,
                        color: Color.fromARGB(255, 85, 87, 94)),
                onPressed: () {
                  changePanel(1);
                },
              ),
              IconButton(
                enableFeedback: false,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: index() == 2
                    ? const Icon(Icons.local_activity_sharp,
                        color: Color.fromARGB(255, 85, 16, 79))
                    : const Icon(Icons.local_activity_rounded,
                        color: Color.fromARGB(255, 85, 87, 94)),
                onPressed: () {
                  changePanel(2);
                },
              ),
              IconButton(
                enableFeedback: false,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: index() == 3
                    ? const Icon(Icons.person_2_outlined,
                        color: Color.fromARGB(255, 85, 16, 79))
                    : const Icon(Icons.person_2,
                        color: Color.fromARGB(255, 85, 87, 94)),
                onPressed: () {
                  changePanel(3);
                },
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 99, 87, 87),
        body: SafeArea(child: panel[index()]));
  }
}
