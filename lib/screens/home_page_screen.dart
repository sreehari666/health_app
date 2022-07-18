// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_app/main.dart';
import 'package:health_app/model/doctor_model.dart';
import 'package:health_app/model/data.dart';
import 'package:health_app/screens/detail_screen.dart';
import 'package:health_app/services/authservices.dart';
import 'package:health_app/services/constant.dart';
import 'package:health_app/services/url.dart';
import 'package:health_app/theme/light_color.dart';
import 'package:health_app/theme/text_styles.dart';
import 'package:health_app/theme/extention.dart';
import 'package:health_app/theme/theme.dart';


 Dio dio = new Dio();

class HomePageScreen extends StatefulWidget {
  HomePageScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageScreen> {
  Future<List<Doctor>> getDoctors() async {
   
    List<Doctor> list_=[];
    
    var response = await dio.get(URL + '/patient/get-doctor-details');
    
    for(int i=0;i<response.data["length"];i++){
      Doctor doctor = Doctor((i).toString(),response.data["data"][i]["_id"],response.data["data"][i]["name"], response.data["data"][i]["type"], response.data["data"][i]["description"]);
      print(doctor);
      list_.insert(i, doctor);
    }
    
    return list_;
  }

  Future getName() async{
      print(userId);
      
      var response = await dio.get(URL+'/patient/get-patient-data/'+userId);
      print(response.data["name"]);
      String name = response.data["name"];
      
      return name;
  }

  @override
  void initState() {
    super.initState();
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: (){
                  userId = null;
                  loggedin = false;
                  Navigator.of(context).pushNamed(HOME);
              },
            child: Icon(
              Icons.logout_sharp,
              size: 30,
              color: LightColor.grey,
            ),
          ),
        ),
        
      ],
    );
  }

  Widget _header() {
    return FutureBuilder(
      future: getName(),
      //future: getDoctors(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
          if (snapshot.data == null) {
            return Container(
              child: const Center(
                child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 66, 97, 189))));
        } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Hello,",
              style: TextStyles.title.subTitleColor,
            ),
            Text(snapshot.data, style: TextStyles.h1Style),
          ],
        );
      }}
    );
  }

  Widget _searchField() {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(13)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: LightColor.grey.withOpacity(.3),
            blurRadius: 15,
            offset: Offset(5, 5),
          )
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyles.body.subTitleColor,
          suffixIcon: SizedBox(
            width: 50,
            child:
                Icon(Icons.search, color: LightColor.purple).alignCenter.ripple(
                      () {},
                      borderRadius: BorderRadius.circular(13),
                    ),
          ),
        ),
      ),
    );
  }

  Widget _category() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Category", style: TextStyles.title.bold),
              Text(
                "See All",
                style: TextStyles.titleNormal
                    .copyWith(color: Theme.of(context).primaryColor),
              ).p(8).ripple(() {})
            ],
          ),
        ),
        SizedBox(
          height: AppTheme.fullHeight(context) * .28,
          width: AppTheme.fullWidth(context),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _categoryCardWidget(
                "Neurology",
                "",
                color: LightColor.green,
                lightColor: LightColor.lightGreen,
              ),
              _categoryCardWidget(
                "Heart sergeon",
                "",
                color: LightColor.skyBlue,
                lightColor: LightColor.lightBlue,
              ),
              _categoryCardWidget(
                "Cardio Sergeon",
                "",
                color: LightColor.orange,
                lightColor: LightColor.lightOrange,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _categoryCardWidget(
    String title,
    String subtitle, {
    required Color color,
    required Color lightColor,
  }) {
    TextStyle titleStyle = TextStyles.title.bold.white;
    TextStyle subtitleStyle = TextStyles.body.bold.white;
    if (AppTheme.fullWidth(context) < 392) {
      titleStyle = TextStyles.body.bold.white;
      subtitleStyle = TextStyles.bodySm.bold.white;
    }
    return AspectRatio(
      aspectRatio: 6 / 8,
      child: Container(
        height: 280,
        width: AppTheme.fullWidth(context) * .3,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 10,
              color: lightColor.withOpacity(.8),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -20,
                  left: -20,
                  child: CircleAvatar(
                    backgroundColor: lightColor,
                    radius: 60,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                      child: Text(title, style: titleStyle).hP8,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: Text(
                        subtitle,
                        style: subtitleStyle,
                      ).hP8,
                    ),
                  ],
                ).p16
              ],
            ),
          ),
        ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }

  
  Color randomColor() {
    var random = Random();
    final colorList = [
      Theme.of(context).primaryColor,
      LightColor.orange,
      LightColor.green,
      LightColor.grey,
      LightColor.lightOrange,
      LightColor.skyBlue,
      LightColor.titleTextColor,
      Colors.red,
      Colors.brown,
      LightColor.purpleExtraLight,
      LightColor.skyBlue,
    ];
    var color = colorList[random.nextInt(colorList.length)];
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          children: [
            _header(),
            const SizedBox(height: 20,),
         
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: RaisedButton(
                          child: Text("My appointments",style: TextStyle(fontSize: 10),),
                          onPressed: (){
                            Navigator.of(context).pushNamed(APPOINTMENT);
                          },
                          color: Color.fromARGB(255, 57, 68, 194),
                          textColor: Colors.white,
                          splashColor: Colors.grey,
                          padding: EdgeInsets.all(15),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Top Doctors", style: TextStyles.title.bold),
              ),
            ),
            
            Expanded(
              child: FutureBuilder(
                  future: getDoctors(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    print(snapshot.data);
                    if (snapshot.data == null) {
                      return Container(
                          child: Center(
                              child: CircularProgressIndicator(
                                  color: Color.fromARGB(255, 66, 97, 189))));
                    } else {
                      print(snapshot.data);
                      print(snapshot.data.runtimeType);
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    offset: Offset(4, 4),
                                    blurRadius: 10,
                                    color: LightColor.grey.withOpacity(.2),
                                  ),
                                  BoxShadow(
                                    offset: Offset(-3, 0),
                                    blurRadius: 15,
                                    color: LightColor.grey.withOpacity(.1),
                                  )
                                ],
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(13)),
                                    child: Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: randomColor(),
                                      ),
                                      child: (snapshot.data.length>4)?Image.asset(
                                        "assets/doctor_$index.png",
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.contain,
                                      ):Image.asset(
                                        "assets/user.png",
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  title: Text(snapshot.data[index].name, style: TextStyles.title.bold),
                                  subtitle: Text(
                                    snapshot.data[index].type,
                                    style: TextStyles.bodySm.subTitleColor.bold,
                                  ),
                                  trailing: Icon(
                                    Icons.keyboard_arrow_right,
                                    size: 30,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ).ripple(
                                () {
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(count:snapshot.data[index].count,id:snapshot.data[index]._id,name: snapshot.data[index].name,type:snapshot.data[index].type,description:snapshot.data[index].description),
                                  ));
                                  //Navigator.of(context).pushNamed(DETAIL_SCREEN);
                                },
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                            );
                            // return ListTile(
                            //     leading: Image.asset('assets/doctor_$index.png'),
                            //     trailing: Text(
                            //       snapshot.data[index].type,
                            //       style: TextStyle(color: Colors.green, fontSize: 15),
                            //     ),
                            //     title: Text(snapshot.data[index].name));
                          });
                    }
                  }),
            ),
          ],
        ));
  }
}

class Doctor {
  final String count;
  final String _id;
  final String name;
  final String type;
  final String description;

  Doctor(this.count,this._id,this.name, this.type, this.description);
}
