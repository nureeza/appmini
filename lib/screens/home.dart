import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:appmini/screens/iotlogin.dart';
import 'package:appmini/screens/iot.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState()=> _HomeState();
}

class _HomeState extends State<Home>{
  IotModel iotModel; 
  var myemail = new TextEditingController();
  var mypass = new TextEditingController();
  String user="",pass="";
  int pushbutton;
  
  FirebaseDatabase firebaseDatabase=FirebaseDatabase.instance;

  void initState(){
    super.initState();
    readData();
  }

  Future<void> readData()async{
    print('Read Data Work');
    DatabaseReference databaseReference=firebaseDatabase.reference().child('bc');
    await databaseReference.once().then((DataSnapshot dataSnapshot){
      print('data=>${dataSnapshot.value.toString()}');
      iotModel=IotModel.formMap(dataSnapshot.value);
      user=iotModel.user;
      pass=iotModel.pass;
      pushbutton=iotModel.pushbutton;
    });
  }

  Future<void> editDatabase()async{
    FirebaseDatabase firebaseDatabase=FirebaseDatabase.instance;
    DatabaseReference databaseReference=firebaseDatabase.reference().child('bc');
    Map<dynamic,dynamic>map=Map();
    map['user']=user;
    map['user']=pass;
    map['user']=pushbutton;
    await databaseReference.set(map).then((response){
      print('Edit Success');
    });
  }

  Widget showlogo(){
    return Image.asset('images/cake.png',width: 220,);
  }

  Widget showText(){
    return Container(
      child:Text(
        'Welcome',
        style: TextStyle(
          fontSize:30.0,
          color:Colors.lightGreenAccent,
          fontWeight:FontWeight.bold,
          
        ),),
      
    );
  }

  Widget emailText() {
    return Container(
        width: 300.0,
        child: TextFormField(
            controller: myemail,
            decoration: InputDecoration(
                icon: Icon(Icons.people,
                size: 30.0,
                color: Colors.lightGreenAccent,
                ),
                labelText: 'Username',
                hintText: 'your@email.com'
            ),
            style: TextStyle(
                fontSize:  18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Righteous-Regular'
            ),
        ),
    );
}

Widget passText(){
    return Container(
        width: 300.0,
        child: TextFormField(
            obscureText: true,
            controller: mypass,
            decoration: InputDecoration(
                icon:Icon(Icons.vpn_key,
                size: 30.0,
                color: Colors.lightGreenAccent,
                ),
                labelText: 'password',
                hintText: 'more 8 charator'
            ),
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Righteous-Regular'
            ),
        ),
    );
}



Widget buttonlogin(){
    readData();
    return Container(
        width: 300.0,
        height: 50.0,
        child: RaisedButton.icon(
            color: Colors.lightGreenAccent,
            icon: Icon(Icons.lightbulb_outline,
            size: 30.0,
        ),
        label: Text('LOGIN',style: TextStyle(
            fontSize: 15.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Righteous-Regular'
        ),),
        onPressed: (){
            var route = MaterialPageRoute(
                builder: (BuildContext context) => Iotlogin(
                    // valueFromRigisPage: myemail.text,
                    //valueFromRigisPage1: generateMd5(mypass.text),
                )
            );
            Navigator.of(context).push(route);
        }
    ),
    );
}

Widget blocklogin(){
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
                colors: [Colors.deepOrangeAccent[200],Colors.pinkAccent[200]]
            )
        ),
        child: Container(
            width: 450.5,
            padding: EdgeInsets.all(16.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[showText(),emailText(),passText(),Text('\n'),buttonlogin()],
            ),
        ),
    );
}


@override
Widget build(BuildContext context){
  return Scaffold(
    body: SafeArea(
      child: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/ra.jpg'),fit: BoxFit.fill)),
      child: Center(child: Column(
        mainAxisSize:MainAxisSize.min,
        children:<Widget>[
          showlogo(),
          blocklogin(),
        ]
      ),),),),
  );
}

}

