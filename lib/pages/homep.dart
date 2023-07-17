import 'dart:convert';

import 'package:timenudge/model/http.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomeP extends StatefulWidget {
  final url = GetIt.instance.get<HTTPservic>();
  HomeP({Key? key});

  @override
  State<StatefulWidget> createState() {
    return _HomeP();
  }
}

class _HomeP extends State<StatefulWidget> {
  var label = "bitcoin";

  void onChange(String selectedValue) {
    setState(() {
      label = selectedValue;
    });
  }

  String name() {
    return label;
  }

  Widget Dropdown() {
    List<String> Lists = const ["bitcoin", "tether", "ripple"];
    List<DropdownMenuItem<String>> items = Lists.map((String value) {
      return DropdownMenuItem<String>(
        child: Text(value),
        value: value,
      );
    }).toList();

    return DropdownButton<String>(
      value: "bitcoin",
      items: items,
      onChanged: (String? selectedValue) {
        setState(() {
          onChange("$selectedValue");
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Dropdown(), WidgetUi(HomeP().url, name())],
    );
  }
}

Widget WidgetUi(var url, line) {
  return FutureBuilder(
    future: url.get("/coins/$line"),
    builder: (BuildContext _context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (snapshot.hasData) {
        Map _data = jsonDecode(snapshot.data.toString());
        var sim = _data["market_data"]["current_price"]["btc"];
        return Container(
          alignment: Alignment.center,
          child: Text(sim.toString()),
        );
      }
      return Container(); // Return an empty container if none of the conditions are met
    },
  );
}
