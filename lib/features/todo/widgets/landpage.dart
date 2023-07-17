import 'package:flutter/material.dart';

import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timenudge/common/ultils/appstyle.dart';
import 'package:timenudge/common/ultils/constants.dart';
import 'package:timenudge/common/ultils/resuables.dart';
import 'package:timenudge/common/widgets/Expansiontile.dart';
import 'package:timenudge/common/widgets/customerextfield.dart';

import 'package:timenudge/common/widgets/heightspacer.dart';
import 'package:timenudge/common/widgets/widthspacer.dart';
import 'package:timenudge/features/todo/widgets/todotail.dart';

import 'package:timenudge/features/todo/widgets/activities.dart';
import 'package:timenudge/features/todo/widgets/forum.dart';
import 'package:timenudge/features/todo/widgets/homep.dart';
import 'package:timenudge/features/todo/widgets/shedule.dart';
import 'package:timenudge/features/todo/widgets/Account.dart';

import '../controllers/expensions.dart';

class LandPage extends ConsumerStatefulWidget {
  const LandPage({Key? key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _LandPage();
  }
}

class _LandPage extends ConsumerState<LandPage> with TickerProviderStateMixin {
  final panel = [HomeP(), Shedule(), Activities(), Forum(), MyAccout()];
  late String inputtext;
  int _index = 0;

  void changePanel(int index) {
    this._index = index;
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
  @override
  Widget build(
    BuildContext context,
  ) {
    ref.read(homeloadProvider.notifier).result();
    if (!checker) {
      ref.watch(homeloadProvider.notifier).loaded;
      ref.watch(homeloadProvider);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: [
          const Heightspacer(value: 20),
          const Heightspacer(value: 10),
          CustomTextField(
            hint: "Search",
            preficon: const Icon(
              Ionicons.search,
              color: AppConsts.kBKDark,
            ),
            onChange: (value) {},
            secure: false,
            autocor: true,
            suffix: const Icon(
              FontAwesome.sliders,
              color: AppConsts.kBKDark,
            ),
          ),
          const Heightspacer(value: 10),
          Row(
            children: [
              const Icon(
                FontAwesome.tasks,
                size: 20,
                color: AppConsts.klight,
              ),
              const WidthSpacer(value: 10),
              Reusables(
                  text: "Todays task",
                  style: appStyle(18, AppConsts.klight, FontWeight.bold))
            ],
          ),
          const Heightspacer(value: 10),
          Container(
            decoration: const BoxDecoration(
                color: AppConsts.klight,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicator: const BoxDecoration(
                  color: Color.fromARGB(255, 139, 144, 148),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                controller: tabController,
                labelPadding: EdgeInsets.zero,
                labelColor: AppConsts.kBluelight,
                isScrollable: false,
                unselectedLabelColor: AppConsts.klight,
                labelStyle: appStyle(24, AppConsts.kBluelight, FontWeight.w700),
                tabs: [
                  Tab(
                      child: SizedBox(
                    width: AppConsts.kwidth * 0.7,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Reusables(
                          text: "Pending",
                          style:
                              appStyle(16, AppConsts.kBKDark, FontWeight.bold),
                        )),
                  )),
                  Tab(
                      child: Container(
                    width: AppConsts.kwidth * 0.7,
                    padding: const EdgeInsets.only(left: 20),
                    child: Reusables(
                      text: "Completed",
                      style: appStyle(16, AppConsts.kBKDark, FontWeight.bold),
                    ),
                  ))
                ]),
          ),
          const Heightspacer(value: 10),
          SizedBox(
            height: AppConsts.kheight * 0.3,
            width: AppConsts.kwidth,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: TabBarView(controller: tabController, children: [
                Container(
                    color: const Color.fromARGB(255, 212, 255, 237),
                    height: AppConsts.kheight * 0.3,
                    child: ListView(
                      children: [
                        Todotile(
                          start: "12:22",
                          end: "4:32",
                          switcher: Switch(
                            value: switchv,
                            onChanged: (value) {
                              setState(() {
                                switchv = !switchv;
                              });
                            },
                          ),
                        )
                      ],
                    )),
                Container(
                    color: AppConsts.klight,
                    height: AppConsts.kheight * 0.3,
                    child: ListView(
                      children: [
                        Todotile(
                          start: "12:22",
                          end: "4:32",
                        )
                      ],
                    ))
              ]),
            ),
          ),
          const Heightspacer(value: 10),
          Expensiontile(
            text1: "Tomorrow tasks",
            text2: "tomorrow tasks are how here",
            onExpensionchange: (bool epend) {
              ref.read(pageExpensionProvider.notifier).setStart(!epend);
            },
            trailing: ref.watch(pageExpensionProvider)
                ? const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child:
                        Icon(AntDesign.circledown, color: AppConsts.kBluelight),
                  )
                : const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(
                      AntDesign.closecircleo,
                      color: AppConsts.klight,
                    ),
                  ),
            children: [
              Todotile(
                start: "12:22",
                end: "4:32",
                switcher: Switch(
                  value: switchv,
                  onChanged: (value) {
                    setState(() {
                      switchv = !switchv;
                    });
                  },
                ),
              ),
              Todotile(
                start: "12:22",
                end: "4:32",
                switcher: Switch(
                  value: switchv,
                  onChanged: (value) {
                    setState(() {
                      switchv = !switchv;
                    });
                  },
                ),
              )
            ],
          ),
          const Heightspacer(value: 10),
          Expensiontile(
            text1: DateTime.now()
                .add(Duration(days: 2))
                .toString()
                .substring(5, 10),
            text2: "Next two days tasks are how here",
            onExpensionchange: (bool epend) {
              ref.read(pageExpensionSzeroProvider.notifier).setStart(!epend);
            },
            trailing: ref.watch(pageExpensionSzeroProvider)
                ? const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child:
                        Icon(AntDesign.circledown, color: AppConsts.kBluelight),
                  )
                : const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(
                      AntDesign.closecircleo,
                      color: AppConsts.klight,
                    ),
                  ),
            children: [
              Todotile(
                start: "12:22",
                end: "4:32",
                switcher: Switch(
                  value: switchv,
                  onChanged: (value) {
                    setState(() {
                      switchv = !switchv;
                    });
                  },
                ),
              ),
              Todotile(
                start: "12:22",
                end: "4:32",
                switcher: Switch(
                  value: switchv,
                  onChanged: (value) {
                    setState(() {
                      switchv = !switchv;
                    });
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
