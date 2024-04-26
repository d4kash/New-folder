import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:orange_yatri/common/db/localData.dart';
import 'package:orange_yatri/constant/constant_color.dart';
import 'package:orange_yatri/pilot/pilot_home/pilot_add_vehicle/pilot_add_vehicle.dart';
import 'package:orange_yatri/pilot/pilot_home/pilot_add_trip/pilot_start_your_ride.dart';
import 'package:orange_yatri/ui/ui_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PilotSelectVehicle extends StatefulWidget {
  const PilotSelectVehicle({super.key});

  @override
  State<PilotSelectVehicle> createState() => _PilotSelectVehicleState();
}

class _PilotSelectVehicleState extends State<PilotSelectVehicle> {
  var data;
  var isOnGoing;

  void listOfVehicle(String dlNumber) async {

    var userData = {"dlNumber": dlNumber};

    final jsonData = json.encode(userData);
    http.Response response;

    try {
      response = await http.post(
          Uri.parse(
              'https://000quaslq5.execute-api.ap-south-1.amazonaws.com/orange_yatri/orangeYatri_particular_pilot_vehicle'),
          body: jsonData);

      var newResponse = json.decode(response.body);

      if (newResponse['body-json']['statusCode'] == 200) {
        debugPrint('hallo-2');

        data = newResponse['body-json']['body'];

      }
      else if (newResponse['body-json']['statusCode'] == 400) {

      }

    } catch (e) {
      debugPrint('saddam bhai ye Exception hai');
      debugPrint(e.toString());
    }
  }

  Future<Object> allVehicleData() async {
    var pref = await SharedPreferences.getInstance();
    var dlNumber = pref.getString(LocalDb.KEYDLNUMBER)!;

    var userData = {"dlNumber": dlNumber};

    final jsonData = json.encode(userData);

    http.Response response;



    try {
      response = await http.post(
          Uri.parse(
              'https://000quaslq5.execute-api.ap-south-1.amazonaws.com/orange_yatri/orangeYatri_particular_pilot_vehicle'),
          body: jsonData);

      var newresponse = json.decode(response.body);

      if (newresponse['body-json']['statusCode'] == 200) {
        data = newresponse['body-json']['body'];

        return newresponse['body-json']['body'];
      } else if (newresponse['body-json']['statusCode'] == 400) {
      } else {
        debugPrint('Failed');
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
      body: FutureBuilder(
        future: allVehicleData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: Constant.height * .05,
                  ),

                  /// All Vehicle ( Heading Text )
                  Text(
                    'Select Vehicle',
                    style: TextStyle(
                        fontSize: Constant.width * .08,
                        fontWeight: FontWeight.w500),
                  ),

                  SizedBox(
                    height: Constant.height * .02,
                  ),

                  /// Vehicle List Container

                  data.length == 0
                      ? Column(
                      children: [
                        SizedBox(
                          height: Constant.height * .75,
                          width: Constant.width * 1,
                          child: Center(
                            child: Text('No Vehicle Added', style: TextStyle(fontSize: Constant.width * .07, fontWeight: FontWeight.w500, color: Colors.grey.shade500))
                          ),
                        ),

                            SizedBox(
                              height: Constant.height * .02,
                            ),

                            UiHelper.customButton(() {
                              Get.off(const PilotAddVehicle());
                            }, 'Add Vehicle')
                      ]
                    ) : Container(
                      height: Constant.height * .87,
                      width: Constant.width * 1,
                      //padding: EdgeInsets.all(Constant.height * .015),
                      decoration: const BoxDecoration(
                        // color: Colors.green,
                      ),
                      child: ListView.builder(
                        itemCount: data.length,
                        padding: EdgeInsets.all(Constant.height * .015),
                        itemBuilder: (context, index) {
                          return Container(
                            height: Constant.height * .1,
                            width: Constant.width * 1,
                            margin: EdgeInsets.only(
                                bottom: Constant.height * .01),
                            padding: EdgeInsets.only(
                                left: Constant.width * .02,
                                right: Constant.width * .02),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    /// Image Container
                                    Container(
                                      height: Constant.height * .08,
                                      width: Constant.width * .16,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/images/truck image.jpg'),
                                            fit: BoxFit.cover,
                                          )),
                                    ),

                                    SizedBox(
                                      width: Constant.width * .02,
                                    ),

                                    /// Details
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data[index]['vehicleName'],
                                          style: TextStyle(
                                              fontSize:
                                              Constant.width * .05,
                                              color: Colors.black87,
                                              fontWeight:
                                              FontWeight.w500),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Vehicle Num : ',
                                              style: TextStyle(
                                                  fontSize:
                                                  Constant.width *
                                                      .035,
                                                  color: Colors.grey,
                                                  fontWeight:
                                                  FontWeight.w500),
                                            ),
                                            Text(
                                              data[index]
                                              ['vehicleNumber'],
                                              style: TextStyle(
                                                  fontSize:
                                                  Constant.width *
                                                      .035,
                                                  color: Constant
                                                      .textColor),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Chasis Num : ',
                                              style: TextStyle(
                                                  fontSize:
                                                  Constant.width *
                                                      .035,
                                                  color: Colors.grey,
                                                  fontWeight:
                                                  FontWeight.w500),
                                            ),
                                            Text(
                                              data[index]
                                              ['chasisNumber'],
                                              style: TextStyle(
                                                  fontSize:
                                                  Constant.width *
                                                      .035,
                                                  color: Constant
                                                      .textColor),
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
                                  Get.to(PilotStartYourRide(
                                      dlNumber: data[index]['dlNumber'],
                                      vehicleNumber: data[index]
                                      ['vehicleNumber']));
                                }, 'Select')
                              ],
                            ),
                          );
                        },
                      ))
                ],
              ),
            );
          }
        },
      ),
      backgroundColor: Colors.grey.shade200,
    );
  }
}
