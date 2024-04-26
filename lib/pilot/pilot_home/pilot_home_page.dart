import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_yatri/common/db/localData.dart';
import 'package:orange_yatri/constant/constant_color.dart';
import 'package:orange_yatri/pilot/pilot_home/pilot_add_trip/pilot_select_vehicle.dart';
import 'package:orange_yatri/pilot/pilot_home/pilot_add_trip/pilot_end_your_trip.dart';
import 'package:orange_yatri/pilot/pilot_home/pilot_add_vehicle/pilot_all_vehicle.dart';
import 'package:orange_yatri/pilot/pilot_home/pilot_history/pilot_history_list.dart';
import 'package:orange_yatri/pilot/pilot_profile/pilot_profile_screen.dart';
import 'package:orange_yatri/ui/ui_helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PilotHomePage extends StatefulWidget {
  const PilotHomePage({super.key});

  @override
  State<PilotHomePage> createState() => _PilotHomePageState();
}

class _PilotHomePageState extends State<PilotHomePage> {
  var data = {};
  var dlNumber;
  var token;

  Future profileData() async {
    var pref = await SharedPreferences.getInstance();
    dlNumber = pref.getString(LocalDb.KEYDLNUMBER)!;
    token = pref.getString(LocalDb.KEYTOKEN)!;

    var userData = {"dlNumber": dlNumber};

    final jsonData = json.encode(userData);

    http.Response response;

    try {
      response = await http.post(
          Uri.parse(
              'https://000quaslq5.execute-api.ap-south-1.amazonaws.com/orange_yatri/orangeYatri_particular_pilot_all_data'),
          headers: <String, String>{'Authorization': token},
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
    // return {
    //   'name': 'Null',
    //   'phone': 'Null',
    //   'dlNumber': 'Null',
    // };
  }

  void tripNavigate() async {
    var userData = {"dlNumber": dlNumber};

    final jsonData = json.encode(userData);

    http.Response response;

    try {
      response = await http.post(
          Uri.parse(
              'https://000quaslq5.execute-api.ap-south-1.amazonaws.com/orange_yatri/orangeYatri_pilot_ongoing_trip_status'),
          body: jsonData);

      var newResponse = json.decode(response.body);

      if (newResponse['body-json']['statusCode'] == 200) {
        if (newResponse['body-json']['body']['status']) {
          Get.to(() => const PilotSelectVehicle());
        } else {
          Get.to(() => PilotEndYourRide(tripId: newResponse['body-json']['body']['data']['tripId']));
        }
      } else if (newResponse['body-json']['statusCode'] == 400) {
      } else {
        debugPrint('Failed');
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('saddam ye exception hai');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: profileData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Stack(
              children: [
                /// Heading Container
                Container(
                  height: Constant.height * .2,
                  width: Constant.width * 1,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      // color: Constant.textBtnColor,
                      gradient: LinearGradient(
                          colors: [Constant.textBtnColor, Colors.deepOrangeAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Hallo Sharma ji and Welcome to E-Yatri
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, ${data['name'] ?? 'null'}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: 'FontMain'),
                          ),
                          Text(
                            'Welcome to Orange-Yatri',
                            style: TextStyle(
                              fontSize: Constant.width * .06,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'FontMain',
                            ),
                          ),
                        ],
                      ),

                      /// Profile
                      GestureDetector(
                        onTap: () {
                          /// Send to profile page
                          Get.to(() => const PilotProfileScreen());
                        },
                        child: Container(
                          height: Constant.height * .08,
                          width: Constant.height * .08,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(100),
                              // image: DecorationImage(
                              //   image: AssetImage('assets/images/saddam.jpg'),
                              //   fit: BoxFit.cover,
                              // ),
                              border: Border.all(
                                color: Colors.grey.shade500,
                                width: Constant.width * .005,
                              )),
                          child: Center(
                            child: Icon(
                              Icons.person,
                              size: Constant.height * .06,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                Container(
                  height: Constant.height * .85,
                  width: Constant.width * 1,
                  margin: EdgeInsets.only(
                      top: Constant.height * .17, left: Constant.width * .04, right: Constant.width * .04),
                  child: Column(
                    children: [
                      Container(
                        height: Constant.height * .16,
                        width: Constant.width * 1,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade500,
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                  offset: const Offset(2.0, 2.0))
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /// Image Container
                            Container(
                              height: Constant.height * .15,
                              width: Constant.width * .3,
                              margin: EdgeInsets.all(Constant.height * .01),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20),
                                  // image: DecorationImage(
                                  //   image:
                                  //       AssetImage('assets/images/saddam.jpg'),
                                  //   fit: BoxFit.cover,
                                  // ),
                                  border: Border.all(
                                    color: Colors.grey.shade500,
                                    width: Constant.width * .005,
                                  )),
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                  size: Constant.height * .14,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ),
                            Container(
                              height: Constant.height * .15,
                              width: Constant.width * .5,
                              margin: EdgeInsets.all(Constant.height * .01),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// Name
                                  Row(
                                    children: [
                                      const Text(
                                        'Name : ',
                                        style:
                                            TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        data['name'] ?? 'null',
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.grey, fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),

                                  /// Mobile
                                  Row(
                                    children: [
                                      const Text(
                                        'Mob : ',
                                        style:
                                            TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        data['phone'] ?? 'null',
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.grey, fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),

                                  /// DL
                                  Row(
                                    children: [
                                      const Text(
                                        'DL : ',
                                        style:
                                            TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        data['dlNumber'] ?? 'null',
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.grey, fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                      SizedBox(
                        height: Constant.height * .02,
                      ),

                      /// All Cards

                      Row(
                        children: [
                          UiHelper.customFullWidthHomeCard(() {
                            Get.to(() => const PilotAllVehicle());
                          }, 'Add Vehicle', Icons.drive_eta),
                          SizedBox(width: Constant.width * .04),
                          UiHelper.customFullWidthHomeCard(() {
                            tripNavigate();
                          }, 'Add Trips', Icons.location_on_outlined),
                        ],
                      ),

                      SizedBox(
                        height: Constant.height * .02,
                      ),

                      Row(
                        children: [
                          UiHelper.customFullWidthHomeCard(() {
                            Get.to(() => const PilotHistoryList());
                          }, 'History', Icons.history_edu_outlined),
                          SizedBox(width: Constant.width * .04),
                          SizedBox(
                            width: Constant.width * .4,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
      backgroundColor: Colors.grey.shade200,
    );
  }
}
