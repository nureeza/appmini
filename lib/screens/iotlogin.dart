import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:appmini/screens/iot.dart';

class Iotlogin extends StatefulWidget {
  @override
  _IotloginState createState() => _IotloginState();
}

class _IotloginState extends State<Iotlogin> {
  bool led1Bool = false;
  int led1Int = 0;
  IotModel iotModel;

  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    print('Read Data Work');

    DatabaseReference databaseReference =
        firebaseDatabase.reference().child('LED');

    await databaseReference.once().then((DataSnapshot dataSnapshot) {
      print('data=>${dataSnapshot.value}'); //ทุกอย่างใน document ถูกอ่านหมดเลย
      // Map <dynamic,dynamic> values= dataSnapshot.value;
      // values.forEach((key,values){
      //   print(values['led1']);
      // });
      iotModel = IotModel.formMap(dataSnapshot.value);
      led1Int = iotModel.led1;

      checkSwitch();
    });
  }

  Future<void> editDatabase() async {
    //โยนค่าขึ้น firebase
    //print('mode=$modeBool');
    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    DatabaseReference databaseReference =
        firebaseDatabase.reference().child('LED');

    Map<dynamic, dynamic> map = Map();
    map['led1'] = led1Int;

    await databaseReference.set(map).then((response) {
      print('Edit Success');
    });
  }

  void checkSwitch() {
    setState(() {
      if (iotModel.led1 == 0) {
        led1Bool = false;
      } else {
        led1Bool = true;
      }
    });
    print('led1=$led1Bool');
  }

  Widget switchLed1() {
    return Container(
      width: 200,
      child: Card(
        color: Colors.orangeAccent,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Text('Led',style: TextStyle(
            fontSize: 30.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Righteous-Regular'
        ),),
              Row(
                children: <Widget>[
                  Text('Off',style: TextStyle(
            fontSize: 25.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Righteous-Regular'
        ),),
                  Switch(
                    value: led1Bool,
                    onChanged: (bool value) {
                      changLed1Bool(value);
                    },
                  ),
                  Text('On',style: TextStyle(
            fontSize: 25.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Righteous-Regular'
        ),)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changLed1Bool(bool value) {
    setState(() {
      led1Bool = value;
      if (led1Bool) {
        led1Int = 1;
      } else {
        led1Int = 0;
      }
      editDatabase();
    });
  }

  
   Widget showlogo(){
    return Image.asset('images/cake.png',width: 220,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(color: Colors.greenAccent),
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            showlogo(),
            
            switchLed1(),
          ],
        )),
      )),
    );
  }
}
