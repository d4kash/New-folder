import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_yatri/constant/constant_color.dart';
import 'package:orange_yatri/pilot/pilot_authentication/pilot_login.dart';
import 'package:orange_yatri/pilot/pilot_home/pilot_history/pilot_history_view_particular.dart';
import 'package:orange_yatri/ui/ui_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PilotHistoryList extends StatefulWidget {
  const PilotHistoryList({super.key});

  @override
  State<PilotHistoryList> createState() => _PilotHistoryListState();
}

class _PilotHistoryListState extends State<PilotHistoryList> {

  var data;
  var dlNumber;

  Future<Object> historyData() async {
    var pref = await SharedPreferences.getInstance();
    dlNumber = pref.getString(PilotLoginState.KEYDLNUMBER)!;

    var userData = {"dlNumber": dlNumber};

    final jsonData = json.encode(userData);

    http.Response response;

    try {
      response = await http.post(
          Uri.parse(
              'https://000quaslq5.execute-api.ap-south-1.amazonaws.com/orange_yatri/orangeYatri_particular_pilot_all_trips'),
          body: jsonData
      );
      if(response.statusCode == 200){

        var newresponse = json.decode(response.body);

        if (newresponse['body-json']['statusCode'] == 200) {

          data = newresponse['body-json']['body'];

        } else if (newresponse['body-json']['statusCode'] == 400) {

        }

      }else{

        debugPrint('failed');

      }


    } catch (e) {
      debugPrint(e.toString());
      debugPrint('saddam ye exception hai');
    }
    return {
      'name': 'Null',
      'phone': 'Null',
      'dlNumber': 'Null',
    };
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: Constant.height * .05,),

            /// Heading Text
            Text('History', style: TextStyle(fontSize: Constant.width * .09, fontWeight: FontWeight.w700),),


            FutureBuilder(
                future: historyData(),
                builder: (context, snapshot) {

                  if(snapshot.connectionState == ConnectionState.waiting){

                    return const Center(
                      child: CircularProgressIndicator(),
                    );

                  }else{

                    return Container(
                      height: Constant.height * .888,
                      width: Constant.width * 1,
                      padding: EdgeInsets.only(
                        left: Constant.width * .01,
                        right: Constant.width * .01,
                      ),
                      // color: Colors.green,
                      child: ListView.builder(
                        padding: EdgeInsets.only(
                          top: Constant.height * .01
                        ),
                        itemCount: data.length,
                        itemBuilder: (context, index) {

                          return Container(
                            height: Constant.height * .1,
                            width: Constant.width * 1,
                            margin:
                            EdgeInsets.only(bottom: Constant.height * .01),
                            padding: EdgeInsets.only(
                                left: Constant.width * .01,
                                right: Constant.width * .01),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Row(
                                  children: [
                                    /// Image Container
                                    Container(
                                      height: Constant.height * .08,
                                      width: Constant.width * .16,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(20),
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/images/truck image.jpg'),
                                            fit: BoxFit.cover,
                                          )),
                                    ),

                                    SizedBox(width: Constant.width * .02,),

                                    /// Details
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data[index]['vehicleName'],
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey.shade800,
                                              fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'Vehicle Num : ',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              data[index]['vehicleNumber'],
                                              style: const TextStyle(
                                                  color: Constant.textColor),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'Trip Status : ',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              data[index]['tripStatus'],
                                              style: TextStyle(
                                                  color: data[index]['tripStatus'] == 'completed' ? Colors.green : Colors.red),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),


                                // SizedBox(width: Constant.width * .01,),

                                /// View Button
                                UiHelper.customOneByFourButton(() {
                                  
                                  Get.to(PilotHistoryViewParticular(tripId: data[index]['tripId']));

                                }, 'View')
                              ],
                            ),
                          );

                        },
                      ),
                    );

                  }

                },
            )


          ],
        ),
      ),
      backgroundColor: Constant.textColor,
    );
  }
}
