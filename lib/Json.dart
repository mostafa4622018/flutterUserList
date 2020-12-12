import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'ShowUser.dart';
import 'Drawer.dart';
class JsonMe extends StatefulWidget {
  @override
  _JsonMeState createState() => _JsonMeState();
}

class _JsonMeState extends State<JsonMe> {
  List<dynamic> userList = new List();
  bool isLoading = true;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _setData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          key: _drawerKey,
          drawer: drawer(),
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                  Icons.menu,
              ),
              onPressed: (){
                _drawerKey.currentState.openDrawer();
              },
            ),
            title: Text(
                "users",
              style: TextStyle(fontSize: 35 , color: Colors.black , fontWeight: FontWeight.w700),
            ),
          ),
          body: Container(
            color: Colors.blue[900],
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                itemCount: userList.length,
                itemBuilder: (BuildContext context, int index) {
                  var user = userList[index];
                  return new Container(
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(
                        user['username'],
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        user['email'],
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                      leading: IconButton(
                        icon: new CircleAvatar(
                          radius: 30,
                          child: Container(
                            width:  100,
                            height: 100,
                            child: SvgPicture.network(
                              user['avatar'],
                            ),
                          ),
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () async{
                          await showDialog(
                              context: context, builder: (_) => ImageDialog(user));
                        },
                      ),
                      onTap: () async {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => ShowUser(user)));
                      },
                    ),
                  );
                },
              ),
            ),

          )
        ),
      ),
    );
  }


  Future<Null> _refresh() async{

    setState(() {
      userList.clear();
    });
     await _setData();
  }

  void _setData() async {
    var url = "https://jsonplaceholder.ir/users";

    var response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      setState(
            () {
          userList = convert.jsonDecode(response.body);
          userList += userList;
          isLoading = false;
        },
      );
    }
  }
}

// ignore: must_be_immutable
class ImageDialog extends StatefulWidget {
  dynamic list;
  ImageDialog(this.list);
  @override
  _ImageDialogState createState() => _ImageDialogState(list);
}

class _ImageDialogState extends State<ImageDialog> {
  dynamic list;
  _ImageDialogState(this.list);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.blue[800],
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            child: SvgPicture.network(
              this.list['avatar'],
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
