
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:json/Json.dart';
    class ShowUser extends StatefulWidget {
      var user;
      ShowUser(this.user);
      @override
      _ShowUserState createState() => _ShowUserState(user);
    }

    class _ShowUserState extends State<ShowUser> {
      var user;
      _ShowUserState(this.user);
      @override
      Widget build(BuildContext context) {
        var width = MediaQuery.of(context).size.width;
        var height = MediaQuery.of(context).size.height;
        var address = user['address'];
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.blue[800],
                  title: Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.arrow_back ,
                              color: Colors.white,
                            ),
                            onPressed: () async{
                              showToast("back");
                              Navigator.pop(context, MaterialPageRoute(builder:(context) => JsonMe()));
                            }
                        ),
                        Text("information" , style: TextStyle(fontWeight: FontWeight.w800 , fontSize: 30),)
                      ],
                    ),
                ),
              body: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      width: width,
                      height: height,
                     color: Colors.blue[700],
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                              width: width,
                              height: height/5,
                              child: SvgPicture.network(user['avatar'])
                          ),
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  width: width,
                                  child: Text(
                                    user['name'],
                                    style: TextStyle(fontSize: 45 , fontWeight: FontWeight.w800 , color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                info(user['username'], width),
                                info(user['phone'] , width),
                                info(user['email'], width),
                                info(address['country'], width),
                                info(address['city'], width),
                                info(address['street'] , width),
                                info(user['website'] , width),
                                info(user['company'], width),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ),
          ),
        );
      }
      void showToast(String msg, {int duration, int gravity}) {
        Toast.show(msg, context, duration: duration, gravity: gravity);
      }
    }

Widget info(var str , var width){
      return
        Container(
          margin: EdgeInsets.only(top: 7 , bottom: 7),
          width: width,
          child: Text(
            str,
            style: TextStyle(fontSize: 32 ,fontWeight: FontWeight.w400 ,color: Colors.white),
            textAlign: TextAlign.center,
          ),
      );
}