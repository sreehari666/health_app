import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:health_app/services/constant.dart';
import 'package:health_app/theme/extention.dart';

import '../services/url.dart';
import '../theme/light_color.dart';
import '../theme/text_styles.dart';

Dio dio = new Dio();

class AppointmentScreen extends StatelessWidget {

  Future<List<List_>> getAppointment() async {
   
    List<List_> list_=[];
    
    var response = await dio.get(URL + '/patient/get-appointments/'+userId);
    
    for(int i=0;i<response.data["length"];i++){
      List_ obj = List_(response.data["data"][i]["patientid"],response.data["data"][i]["doctorid"], response.data["data"][i]["time"],);
      print(obj);
      list_.insert(i, obj);
    }
    
    return list_;
   }

   Future<String> getDocName(String doc_id) async{
    
    var response = await dio.get(URL+'/patient/get-doctor-data/'+doc_id);
    
    return response.toString();

   }




    AppointmentScreen({Key? key,}) : super(key: key);
    
      @override
      Widget build(BuildContext context) {

        return Scaffold(
          appBar: AppBar(
            title: Text("My appointments"),
          ),
          body: Column(
            children: [

              Expanded(
                  child: FutureBuilder(
                      future: getAppointment(),
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
                                            //color: randomColor(),
                                          ),
                                          // child: Image.asset(
                                          //   "assets/doctor_$index.png",
                                          //   height: 50,
                                          //   width: 50,
                                          //   fit: BoxFit.contain,
                                          // ),
                                        ),
                                      ),
                                      title: FutureBuilder(
                                      future: getDocName(snapshot.data[index].doctorId),
                                      builder: (BuildContext context, AsyncSnapshot snapshot){
                                        if(snapshot.data == null){
                                          return Text(" ", style: TextStyles.title.bold);
                                        }else{
                                          return Text(snapshot.data, style: TextStyles.title.bold);
                                        }
                                      }),
                                      //title: Text(snapshot.data[index].doctorId, style: TextStyles.title.bold),
                                      subtitle: Text(
                                        snapshot.data[index].time,
                                        style: TextStyles.bodySm.subTitleColor.bold,
                                      ),
                                      // trailing: Icon(
                                      //   Icons.keyboard_arrow_right,
                                      //   size: 30,
                                      //   color: Theme.of(context).primaryColor,
                                      // ),
                                    ),
                                  ).ripple(
                                    () {
                                      
                                      //Navigator.of(context).pushNamed(DETAIL_SCREEN);
                                    },
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                );
                               
                              });
                        }
                      }),
                ),
            ],
          ),
        );
    
      }
}

class List_{
  final String patientId;
  final String doctorId;
  final String time;
  List_(this.patientId,this.doctorId,this.time);

}