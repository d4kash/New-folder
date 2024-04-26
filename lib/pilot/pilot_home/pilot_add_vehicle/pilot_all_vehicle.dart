import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_yatri/common/db/localData.dart';
import 'package:orange_yatri/constant/constant_color.dart';
import 'package:orange_yatri/pilot/pilot_home/pilot_add_vehicle/pilot_add_vehicle.dart';
import 'package:orange_yatri/pilot/pilot_home/pilot_add_vehicle/pilot_vehicle_view.dart';
import 'package:orange_yatri/ui/ui_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PilotAllVehicle extends StatefulWidget {
  const PilotAllVehicle({super.key});

  @override
  State<PilotAllVehicle> createState() => _PilotAllVehicleState();
}

class _PilotAllVehicleState extends State<PilotAllVehicle> {
  var data;

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
        // debugPrint('hallo-2');

        // debugPrint(newresponse['body-json']['body']);

        data = newresponse['body-json']['body'];

        // debugPrint(data);

        return newresponse['body-json']['body'];
      } else if (newresponse['body-json']['statusCode'] == 400) {
        // debugPrint('hallo-3');

        //debugPrint(newresponse['body-json']['statusCode']);
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
                    'All Vehicle',
                    style: TextStyle(fontSize: Constant.width * .08, fontWeight: FontWeight.w600),
                  ),

                  SizedBox(
                    height: Constant.height * .02,
                  ),

                  /// Vehicle List Container

                  data.length == 0 ?
                      SizedBox(
                        height: Constant.height * .74,
                        width: Constant.width * 1,
                        child: const Center(child: Text('No vehicle Added', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.grey),),),
                      ) :
                  Container(
                      height: Constant.height * .74,
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
                                              fontSize: Constant.width * .04,
                                              color: Colors.grey.shade800,
                                              // fontWeight: FontWeight.w500,
                                              fontFamily: 'PopinsBlack'
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Vehicle Num : ',
                                              style: TextStyle(
                                                  fontSize: Constant.width * .035,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              data[index]['vehicleNumber'],
                                              style: TextStyle(
                                                  fontSize: Constant.width * .035,
                                                  color: Constant.textColor),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Chasis Num : ',
                                              style: TextStyle(
                                                  fontSize: Constant.width * .035,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              data[index]['chasisNumber'],
                                              style: TextStyle(
                                                  fontSize: Constant.width * .035,
                                                  color: Constant.textColor),
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

                                  Get.to(PilotVehicleView(vehicleNumber: data[index]['vehicleNumber']));

                                }, 'View')
                              ],
                            ),
                          );
                        },
                      )),

                  SizedBox(
                    height: Constant.height * .04,
                  ),

                  /// Add Vehicle Button
                  UiHelper.customButton(() {
                    Get.to(const PilotAddVehicle());
                  }, 'Add Vehicle')
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
