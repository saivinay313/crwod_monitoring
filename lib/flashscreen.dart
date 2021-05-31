import 'package:crowd_monitoring/homescreen.dart';
import 'package:flutter/material.dart';

class FlashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(12),
          decoration: new BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blueGrey, Colors.lightBlueAccent])),
          child: ListView(
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Select the Store',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (route) => true);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.topLeft,
                      height: 170,
                      width: 180,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/kfclogo.jpg'),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.topLeft,
                              colors: [
                                Colors.deepOrangeAccent,
                                Colors.orange[200]
                              ])),
                    ),
                  ),
                  SizedBox(width: 20,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (route) => true);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.topLeft,
                      height: 170,
                      width: 180,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/pumalogo.jpg'),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.topLeft,
                              colors: [
                                Colors.deepOrangeAccent,
                                Colors.orange[200]
                              ])),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
