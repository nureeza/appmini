import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class IotModel {
  int led1;
  String user = "", pass = "";
  int pushbutton;

  IotModel(
    this.led1,
  );

  IotModel.formMap(Map<dynamic, dynamic> map) {
    led1 = map['led1'];
  }

  Map<dynamic, dynamic> toMap() {
    final Map<dynamic, dynamic> map = Map<dynamic, dynamic>();
    map['led1'] = led1;

    return map;
  }
}
