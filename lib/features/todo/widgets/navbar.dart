import 'package:timenudge/features/todo/widgets/SignUp.dart';
import 'package:timenudge/features/todo/widgets/activities.dart';
import 'package:timenudge/features/todo/widgets/forum.dart';
import 'package:timenudge/features/todo/widgets/homep.dart';
import 'package:timenudge/features/todo/widgets/shedule.dart';
import 'package:timenudge/features/todo/widgets/Account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBar extends StatefulWidget {
  NavBar();
  int getindex() {
    return 12;
  }

  @override
  State<StatefulWidget> createState() {
    return BottomNav();
  }
}

class BottomNav extends State<StatefulWidget> {
  final panel = [HomeP(), Shedule(), Activities(), Forum(), MyAccout()];

  late String inputtext;
  BottomNav();
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 50,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 5.0, left: 2, right: 2),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 1, 4, 37),
        borderRadius: BorderRadius.circular(10),
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
                      color: Color.fromARGB(255, 12, 31, 94))
                  : const Icon(Icons.home,
                      color: Color.fromARGB(255, 13, 24, 16)),
              onPressed: () {
                setState(() {
                  changePanel(0);
                });
              },
            ),
            onDoubleTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext _context) {
                return GestureDetector(
                  child: Text("Build"),
                  onDoubleTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext _contex) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount:
                            10, // Replace with the actual number of items
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: 150, // Set the desired width of each item
                            margin: EdgeInsets.symmetric(vertical: 3),
                            // Add horizontal spacing between items
                            color: Colors
                                .blue, // Replace with your desired item color
                            child: Center(
                                child: Container(
                              child: Text(
                                'Item $index',
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              width: 200,
                              margin: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10)),
                            )),
                          );
                        },
                      );
                    }));
                  },
                );
              }));
            },
          ),
          IconButton(
            enableFeedback: false,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: index() == 1
                ? const Icon(Icons.event, color: Colors.white)
                : const Icon(Icons.event_available_rounded,
                    color: Color.fromARGB(255, 153, 153, 193)),
            onPressed: () {
              setState(() {
                changePanel(1);
              });
            },
          ),
          IconButton(
            enableFeedback: false,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: index() == 2
                ? const Icon(Icons.local_activity_sharp, color: Colors.white)
                : const Icon(Icons.local_activity_rounded,
                    color: Color.fromARGB(255, 153, 153, 193)),
            onPressed: () {
              setState(() {
                changePanel(2);
              });
            },
          ),
          IconButton(
            enableFeedback: false,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: index() == 3
                ? const Icon(Icons.person_2_outlined, color: Colors.white)
                : const Icon(Icons.person_2,
                    color: Color.fromARGB(255, 153, 153, 193)),
            onPressed: () {
              setState(() {
                changePanel(3);
              });
            },
          ),
        ],
      ),
    );
  }
}
