import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_app/main.dart';
import 'package:health_app/model/doctor_model.dart';
import 'package:health_app/services/constant.dart';
import 'package:health_app/theme/light_color.dart';
import 'package:health_app/theme/text_styles.dart';
import 'package:health_app/theme/theme.dart';
import 'package:health_app/widgets/progress_widget.dart';
import 'package:health_app/widgets/rating_star_widget.dart';
import 'package:health_app/theme/extention.dart';

 

// ignore: must_be_immutable
class DetailScreen extends StatelessWidget {
  String count;
  String id;
  String name;
  String type;
  String description;
  // DoctorModel model;
  DetailScreen({Key? key,required this.count,required this.id,required this.name,required this.type,required this.description}) : super(key: key);

  

  Widget _appbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        BackButton(
          color: Colors.blue,
        ),
        IconButton(
          icon: Icon(
            Icons.favorite
            //model.isfavourite ? Icons.favorite : Icons.favorite_border,
            //color: model.isfavourite ? Colors.red : LightColor.grey,
          ),
          onPressed: () {
            // setState(() {
            //   //model.isfavourite = !model.isfavourite;
            // });
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyles.title.copyWith(fontSize: 25).bold;
    if (AppTheme.fullWidth(context) < 393) {
      titleStyle = TextStyles.title.copyWith(fontSize: 23).bold;
    }
    return Scaffold(
      backgroundColor: LightColor.extraLightBlue,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Image.asset("assets/doctor_"+ count +".png"),
            DraggableScrollableSheet(
              maxChildSize: .8,
              initialChildSize: .6,
              minChildSize: .6,
              builder: (context, scrollController) {
                return Container(
                  height: AppTheme.fullHeight(context) * .5,
                  padding: EdgeInsets.only(
                    left: 19,
                    right: 19,
                    top: 16,
                  ), //symmetric(horizontal: 19, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                name,
                                //model.name,
                                style: titleStyle,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.check_circle,
                                size: 18,
                                color: Theme.of(context).primaryColor,
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: RatingStarWidget(
                                  rating: 4.5,
                                  //rating: model.rating,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            type,
                            // model.type,
                            style: TextStyles.bodySm.subTitleColor.bold,
                          ),
                        ),
                        Divider(
                          thickness: .3,
                          color: LightColor.grey,
                        ),
                        // Row(
                        //   children: <Widget>[
                        //     ProgressWidget(
                        //       value: 4.5,
                        //       //value: model.goodReviews,
                        //       totalValue: 100,
                        //       activeColor: LightColor.purpleExtraLight,
                        //       backgroundColor: LightColor.grey.withOpacity(.3),
                        //       title: "Good Review",
                        //       durationTime: 500, key: null,
                        //     ),
                        //     ProgressWidget(
                        //       value: 4.5,
                        //       //value: model.totalScore,
                        //       totalValue: 100,
                        //       activeColor: LightColor.purpleLight,
                        //       backgroundColor: LightColor.grey.withOpacity(.3),
                        //       title: "Total Score",
                        //       durationTime: 300, key: null,
                        //     ),
                        //     ProgressWidget(
                        //       value: 4.5,
                        //       //value: model.satisfaction,
                        //       totalValue: 100,
                        //       activeColor: LightColor.purple,
                        //       backgroundColor: LightColor.grey.withOpacity(.3),
                        //       title: "Satisfaction",
                        //       durationTime: 800,
                        //     ),
                        //   ],
                        // ),
                        Divider(
                          thickness: .3,
                          color: LightColor.grey,
                        ),
                        Text("About", style: titleStyle).vP16,
                        Text(
                          description,
                          //model.description,
                          style: TextStyles.body.subTitleColor,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: LightColor.grey.withAlpha(150),
                              ),
                              child: Icon(
                                Icons.call,
                                color: Colors.white,
                              ),
                            ).ripple(
                              () {},
                              borderRadius: BorderRadius.circular(10),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: LightColor.grey.withAlpha(150),
                              ),
                              child: Icon(
                                Icons.chat_bubble,
                                color: Colors.white,
                              ),
                            ).ripple(
                              () {},
                              borderRadius: BorderRadius.circular(10),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                onPressed: () {

                                  authService.appointment(userId,id).then((response)=>{
                                    
                                    if(response != null){
                                      Fluttertoast.showToast(
                                      msg: "Appointment booked",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0)
                                    }else{
                                      Fluttertoast.showToast(
                                      msg: "Error",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0)
                                    }
                                    
                                  });

                                },
                                child: Text(
                                  "Make an appointment",
                                  style: TextStyles.titleNormal.white,
                                ),
                              ),
                            ),
                          ],
                        ).vP16
                      ],
                    ),
                  ),
                );
              },
            ),
            _appbar(),
          ],
        ),
      ),
    );
  }
}
