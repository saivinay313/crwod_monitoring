import 'package:crowd_monitoring/graphscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:intl/intl.dart';

String crowddata = "null";
int count = 0;
int limit = 50;
bool safety = true;

var datefor = DateFormat.MMMd('en_US');
String date = datefor.format(DateTime.now()).toString();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String api =
      "https://api.thingspeak.com/channels/1344656/feeds.json?results=1";

  Future getdata() async {
    var response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var crowd = data['feeds'];
      int n = crowd.length;

      setState(() {
        count = int.parse(crowd[n - 1]['field1']);
        crowddata = crowd[n - 1]['field1'];
        print(crowddata);
        if (count > 5) {
          safety = false;
        }
      });

      return crowddata;
    }
  }

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
            SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  height: 500,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.deepOrangeAccent, Colors.orange[200]]),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Today',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w300),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                date,
                                style: TextStyle(
                                    fontSize: 33, fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                          Icon(
                            Icons.food_bank_outlined,
                            size: 80,
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black12,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      safety
                          ? Container(
                              alignment: Alignment.topLeft,
                              child: crowddata == "null"
                                  ? CircularProgressIndicator(
                                      strokeWidth: 3,
                                      backgroundColor: Colors.black45,
                                    )
                                  : Text(
                                      crowddata.toString(),
                                      style: TextStyle(
                                          fontSize: 80,
                                          fontWeight: FontWeight.w400),
                                    ),
                            )
                          : Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                crowddata.toString(),
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 80,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                      Row(
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.people_outline_sharp,
                                color: Colors.black87,
                              ),
                              onPressed: () {
                                getdata();
                              }),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'CROWD TODAY',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 90),
                      Container(
                        alignment: Alignment.center,
                        height: 8,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(12)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (limit - count).toString(),
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Tables left",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                    SizedBox(
                      width: 140,
                    ),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 120,
                        child: Text(
                          "Book your slot",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Graph(count)),
                        (route) => true);
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '          View Stats',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 40,
                        )
                      ],
                    ),
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(35)),
                  ),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
