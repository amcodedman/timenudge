import 'package:timenudge/model/http.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import './navbar.dart';

class Home extends StatefulWidget {
  NavBar _navbar = new NavBar();

  Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<Home> {
  late double _dheight, _dwidth;
  _HomePage();
  HTTPservic? _http;

  @override
  void initState() {
    super.initState();
    _http = GetIt.instance.get<HTTPservic>();
  }

  @override
  Widget build(BuildContext context) {
    _dheight = MediaQuery.of(context).size.height;
    _dwidth = MediaQuery.of(context).size.width;
    return NavBar();
  }
}

Widget Pad(Widget w) {
  return Padding(child: w, padding: EdgeInsets.all(10));
}

Widget ContainB(Widget w) {
  return Align(
      child: Container(
    width: 150,
    height: 50,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
    child: MaterialButton(
      child: Align(
        alignment: Alignment.center,
        child: w,
      ),
      onPressed: () => {},
    ),
  ));
}

Widget ContainL(Widget w, var heigh, var weight) {
  return Align(
      child: Container(
    width: weight,
    height: heigh,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
    child: w,
  ));
}
