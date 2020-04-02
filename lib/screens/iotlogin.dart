import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:appmini/screens/iot.dart';

class Iotlogin extends StatefulWidget {
  @override
  _IotloginState createState() => _IotloginState();
}

class _IotloginState extends State<Iotlogin> {
  bool led1Bool = false,led2Bool = false,door1Bool=false,door2Bool=false;
  int led1Int = 0, led2Int=0,door1Int=0,door2Int=0;
  String door1="Close Door",door2="Close Door";
  IotModel iotModel; 

  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future <void> readData() async {
    print('Read Data Work');

    DatabaseReference databaseReference = firebaseDatabase.reference().child('room');
    
    await databaseReference.once().then((DataSnapshot dataSnapshot){
      print('data=>${dataSnapshot.value}');//ทุกอย่างใน document ถูกอ่านหมดเลย
      // Map <dynamic,dynamic> values= dataSnapshot.value;
      // values.forEach((key,values){
      //   print(values['led1']);
      // });
      iotModel=IotModel.formMap(dataSnapshot.value);
      led1Int=iotModel.led1;
      led2Int=iotModel.led2;
      door1Int=iotModel.door1;
      door2Int=iotModel.door2;
      checkSwitch();
    });
  }

  Future<void> editDatabase() async{//โยนค่าขึ้น firebase
    //print('mode=$modeBool');
    FirebaseDatabase firebaseDatabase= FirebaseDatabase.instance;
    DatabaseReference databaseReference = firebaseDatabase.reference().child('room');

    Map<dynamic,dynamic> map = Map();
    map['led1']=led1Int;
    map['led2']=led2Int;
    map['door1']=door1Int;
    map['door2']=door2Int;

    await databaseReference.set(map).then((response){
      print('Edit Success');
    });
  }

  void checkSwitch(){
    setState(() {
      if(iotModel.led1==0){
        led1Bool=false;
      }
      else{
        led1Bool=true;
      }

      if(iotModel.led2==0){
        led2Bool=false;
      }
      else{
        led2Bool=true;
      }
    });
    print('led1=$led1Bool,led2=$led2Bool');
  }

  Widget switchLed1(){
    return Container(
      width: 200,
      child: Card(
        color:Colors.orangeAccent,
        child: Container(
          padding:EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text('Led10305'),
              Row(
                children: <Widget>[
                  Text('Off'),
                  Switch(
                    value: led1Bool, 
                    onChanged:(bool value){
                      changLed1Bool(value);
                    },
                    ),
                  Text('On')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  void changLed1Bool(bool value){
    setState(() {
      led1Bool=value;
      if(led1Bool){
        led1Int=1;
      }
      else{
        led1Int=0;
      }
      editDatabase();
    });
  }
  Widget bottonDoor1(){
    return Container(
      padding: new EdgeInsets.all(32.0),
      child: SizedBox(
        height: 100,
        width: 300,
        child:  RaisedButton.icon(
          color: Colors.orangeAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0)
          ),
          onPressed: (){
            setState(() {
              door1Int=door1Int;
              if(door1Int==0){
                door1Int=1;
                door1="Open Door";
              }
              else {
                door1Int=0;
                door1="Close Door";
              }
              print('$door1Int');
              editDatabase();
            });
          },
          icon: Icon(Icons.adjust),
          label: Text('10305:$door1'),
          ),
      ),
    );
  }

  Widget switchLed2(){
    return Container(
      width: 200,
      child: Card(
        color:Colors.redAccent,
        child: Container(
          padding:EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text('Led10307'),
              Row(
                children: <Widget>[
                  Text('Off'),
                  Switch(
                    value: led2Bool, 
                    onChanged:(bool value){
                      changLed2Bool(value);
                    },
                    ),
                  Text('On')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  void changLed2Bool(bool value){
    setState(() {
      led2Bool=value;
      if(led2Bool){
        led2Int=1;
      }
      else{
        led2Int=0;
      }
      editDatabase();
    });
  }

  Widget bottonDoor2(){
    return Container(
      padding: new EdgeInsets.all(32.0),
      child: SizedBox(
        height: 100,
        width: 300,
        child:  RaisedButton.icon(
          color: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0)
          ),
          onPressed: (){
            setState(() {
              door2Int=door2Int;
              if(door2Int==0){
                door2Int=1;
                door2="Open Door";
              }
              else {
                door2Int=0;
                door2="Close Door";
              }
              print('$door2Int');
              editDatabase();
            });
          },
          icon: Icon(Icons.adjust),
          label: Text('10307 :$door2'),
          ),
      ),
    );
  }

  Widget room1(){
    return Text("Room10305",
      style: TextStyle(
      fontSize: 40.0,
      fontWeight:FontWeight.bold,
      color:Colors.black
    ),
    );
  }
  Widget room2(){
    return Text("Room10307",
    style: TextStyle(
      fontSize: 40.0,
      fontWeight:FontWeight.bold,
      color:Colors.black
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child : Container(
          decoration: BoxDecoration(color: Colors.greenAccent
          ),
          child: Center(
            child : Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
              room1(),
              switchLed1(),
              bottonDoor1(),
              room2(),
              switchLed2()
              ,bottonDoor2(),
            ],)
          ),
        )
      ),
    );
  }
}