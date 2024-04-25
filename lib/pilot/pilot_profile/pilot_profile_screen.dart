import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_yatri/components/splash_screen/splash_screen.dart';
import 'package:orange_yatri/constant/constant_color.dart';
import 'package:orange_yatri/pilot/pilot_authentication/pilot_login.dart';
import 'package:orange_yatri/pilot/pilot_profile/pilot_update_profile.dart';
import 'package:orange_yatri/ui/ui_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PilotProfileScreen extends StatefulWidget {
  const PilotProfileScreen({super.key});

  @override
  State<PilotProfileScreen> createState() => _PilotProfileScreenState();
}

class _PilotProfileScreenState extends State<PilotProfileScreen> {
  var data = {};
  var dlNumber;
  var token;

  Future<Object> profileData() async {
    var pref = await SharedPreferences.getInstance();
    dlNumber = pref.getString(PilotLoginState.KEYDLNUMBER);
    token = pref.getString(PilotLoginState.KEYTOKEN);

    var userData = {"dlNumber": dlNumber};

    final jsonData = json.encode(userData);
    http.Response response;

    try {
      response = await http.post(
          Uri.parse(
              'https://000quaslq5.execute-api.ap-south-1.amazonaws.com/orange_yatri/orangeYatri_particular_pilot_all_data'),
          headers: <String, String>{'Authorization': token},
          body: jsonData);

      var newResponse = json.decode(response.body);

      if (newResponse['body-json']['statusCode'] == 200) {
        data = newResponse['body-json']['body'];
        debugPrint(newResponse['body-json']['body']);
      } else if (newResponse['body-json']['statusCode'] == 400) {
        debugPrint(newResponse['body-json']['body']);
      }
    } catch (e) {
      debugPrint('saddam ye Exception hai');
      debugPrint(e.toString());
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
      body: Padding(
        padding: EdgeInsets.only(
          left: Constant.width * .02,
          right: Constant.width * .02,
          top: Constant.height * .01,
          bottom: Constant.height * .01,
        ),
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: profileData(),
            builder: (context, AsyncSnapshot<Object> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Center(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Constant.height * .04,
                      ),
          
                      /// Heading Text
                      Text(
                        'Profile',
                        style: TextStyle(
                            fontSize: Constant.width * .07, fontWeight: FontWeight.w700, color: Colors.grey.shade800),
                      ),
          
                      /// Edit Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(''),
                          UiHelper.customOneByFourButton(() {
                            Get.to(const PilotUpdateProfile());
                          }, 'Edit')
                        ],
                      ),
          
                      /// Image Container
                      Container(
                        height: Constant.height * .2,
                        width: Constant.height * .2,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(100),
                            // image: DecorationImage(
                            //   image: AssetImage('assets/images/saddam.jpg'),
                            //   fit: BoxFit.cover
                            // ),
                            border: Border.all(
                              color: Colors.grey.shade500,
                              width: Constant.width * .005,
                            )),
                        child: Center(
                          child: Icon(
                            Icons.person,
                            size: Constant.height * .15,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
          
                      SizedBox(
                        height: Constant.height * .02,
                      ),
          
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Name',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey.shade800),
                          ),
                          const Text('')
                        ],
                      ),
                      Container(
                        height: Constant.height * .06,
                        width: Constant.width * 1,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey.shade800, width: 1)),
                        child: Text(
                          data['name'] ?? 'null',
                          style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
                        ),
                      ),
                      SizedBox(
                        height: Constant.height * .01,
                      ),
          
                      /// Mobile
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data['phone'] ?? 'null',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey.shade800),
                          ),
                          const Text('')
                        ],
                      ),
                      Container(
                        height: Constant.height * .06,
                        width: Constant.width * 1,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey.shade800, width: 1)),
                        child: Text(
                          '6202548771',
                          style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
                        ),
                      ),
                      SizedBox(
                        height: Constant.height * .01,
                      ),
          
                      /// Email
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Email Id',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey.shade800),
                          ),
                          const Text('')
                        ],
                      ),
                      Container(
                        height: Constant.height * .06,
                        width: Constant.width * 1,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey.shade800, width: 1)),
                        child: Text(
                          data['email'] ?? 'null',
                          style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
                        ),
                      ),
                      SizedBox(
                        height: Constant.height * .01,
                      ),
          
                      /// DL Number
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'DL Number',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey.shade800),
                          ),
                          const Text('')
                        ],
                      ),
                      Container(
                        height: Constant.height * .06,
                        width: Constant.width * 1,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey.shade800, width: 1)),
                        child: Text(
                          data['dlNumber'] ?? 'null',
                          style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
                        ),
                      ),
                      SizedBox(height: Constant.height * .135),
          
                      /// Registered Vehicles
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text('Registered Vehicle', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey.shade800),),
                      //     Text('')
                      //   ],
                      // ),
                      // Container(
                      //   height: Constant.height * .082 * 2,
                      //   width: Constant.width * 1,
                      //   // color: Colors.green,
                      //   child: ListView.builder(
                      //     padding: EdgeInsets.all(0),
                      //     itemCount: 2,
                      //     itemBuilder: (context, index) {
                      //       return Container(
                      //         height: Constant.height * .06,
                      //         width: Constant.width * 1,
                      //         margin: EdgeInsets.only(
                      //           bottom: Constant.height * .01,
                      //         ),
                      //         padding: EdgeInsets.all(10),
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(5),
                      //             border: Border.all(
                      //                 color: Colors.grey.shade800,
                      //                 width: 1
                      //             )
                      //         ),
                      //         child: Text('DL123456',style: TextStyle(
                      //             fontSize: 20,
                      //             color: Colors.grey.shade800
                      //         ),),
                      //       );
                      //     },
                      //   ),
                      // ),
                      // SizedBox(height: Constant.height * .01,),
          
                      /// Logout Button
                      UiHelper.customButton(() {
                        loginPersistent();
                        Get.offAll(const PilotLogin());
                      }, 'LOG OUT')
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

void loginPersistent() async {
  var pref = await SharedPreferences.getInstance();
  pref.setBool(SplashScreenState.KEYLOGINPERSIST, false);
}
