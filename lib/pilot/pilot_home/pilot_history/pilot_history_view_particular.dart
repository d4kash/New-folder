import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orange_yatri/constant/constant_color.dart';


class PilotHistoryViewParticular extends StatefulWidget {
  final String tripId;
  const PilotHistoryViewParticular({super.key, required this.tripId});

  @override
  State<PilotHistoryViewParticular> createState() => _PilotHistoryViewParticularState();
}

class _PilotHistoryViewParticularState extends State<PilotHistoryViewParticular> {

  var data;

  Future<Object> historyTripData() async {
    var userData = {"tripId": widget.tripId};

    final jsonData = json.encode(userData);
    http.Response response;

    try {
      response = await http.post(
          Uri.parse(
              'https://000quaslq5.execute-api.ap-south-1.amazonaws.com/orange_yatri/orangeYatri_particular_trip_all_data'),
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
      body: FutureBuilder(
        future: historyTripData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Column(
                children: [
                  /// Heading Container ==============================================
                  Container(
                    height: Constant.height * .1,
                    width: Constant.width * 1,
                    padding: EdgeInsets.only(
                        left: Constant.width * .05, right: Constant.width * .05),
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Name and Id Box
                        Column(
                          children: [
                            Text(
                              data['name'] ?? 'null',
                              style: TextStyle(
                                  fontSize: Constant.width * .07,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            Text(
                              data['dlNumber'] ?? 'null',
                              style: TextStyle(
                                  fontSize: Constant.width * .05,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            )
                          ],
                        ),

                        /// Helpline Call Box
                        Container(
                          height: Constant.height * .07,
                          width: Constant.width * .3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.call,
                                color: Colors.green,
                                size: Constant.width * .07,
                              ),
                              Text(
                                'HELP',
                                style: TextStyle(
                                    fontSize: Constant.width * .06,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  /// Details Card Container =========================================
                  Container(
                    height: Constant.height * .39,
                    width: Constant.width * .95,
                    padding: const EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: Constant.height * .015),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade700,
                            blurRadius: 5,
                            spreadRadius: 1,
                          )
                        ]),
                    child: Column(
                      children: [
                        /// Image, Name, Number, DL Number, Mobile Number
                        Row(
                          children: [
                            /// Image Container
                            Container(
                              height: Constant.height * .14,
                              width: Constant.width * .28,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.grey.shade500,
                                    width: Constant.width * .005,
                                  )),
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                  size: Constant.height * .13,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ),

                            SizedBox(
                              width: Constant.width * .05,
                            ),

                            /// Nmae, Number, DL, Mobile Number
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['vehicleName'] ?? 'null',
                                  style: TextStyle(
                                      fontSize: Constant.width * .05, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  data['vehicleNumber'] ?? 'null',
                                  style: TextStyle(
                                      fontSize: Constant.width * .05,
                                      fontWeight: FontWeight.w400,
                                      color: Constant.textColor),
                                ),
                                Text(
                                  data['dlNumber'] == null
                                      ? 'null'
                                      :'DL : ' + data['dlNumber'],
                                  style: TextStyle(
                                      fontSize: Constant.width * .05,
                                      fontWeight: FontWeight.w400,
                                      color: Constant.textColor),
                                ),
                                Text(
                                  data['phone'] == null
                                      ? 'null'
                                      : 'Mob : ' + data['phone'],
                                  style: TextStyle(
                                      fontSize: Constant.width * .05,
                                      fontWeight: FontWeight.w400,
                                      color: Constant.textColor),
                                ),
                              ],
                            )
                          ],
                        ),

                        /// Trip Start Date
                        Row(
                          children: [
                            Text(
                              'Trip Start Date : ',
                              style: TextStyle(
                                  fontSize: Constant.width * .05,
                                  fontWeight: FontWeight.w600,
                                  color: Constant.color1),
                            ),
                            Text(
                              data['date'] ?? 'null',
                              style: TextStyle(
                                  fontSize: Constant.width * .05,
                                  fontWeight: FontWeight.w400,
                                  color: Constant.textColor),
                            )
                          ],
                        ),

                        /// Trip start Time
                        Row(
                          children: [
                            Text(
                              'Trip Start Time : ',
                              style: TextStyle(
                                  fontSize: Constant.width * .05,
                                  fontWeight: FontWeight.w600,
                                  color: Constant.color1),
                            ),
                            Text(
                              data['time'] ?? 'null',
                              style: TextStyle(
                                  fontSize: Constant.width * .05,
                                  fontWeight: FontWeight.w400,
                                  color: Constant.textColor),
                            )
                          ],
                        ),

                        /// Goods Details
                        Row(
                          children: [
                            Text(
                              'Goods Details : ',
                              style: TextStyle(
                                  fontSize: Constant.width * .05,
                                  fontWeight: FontWeight.w600,
                                  color: Constant.color1),
                            ),
                            Text(
                              data['goodsDetails'] ?? 'null',
                              style: TextStyle(
                                  fontSize: Constant.width * .05,
                                  fontWeight: FontWeight.w400,
                                  color: Constant.textColor),
                            )
                          ],
                        ),

                        /// Goods Weight
                        Row(
                          children: [
                            Text(
                              'Goods Weight : ',
                              style: TextStyle(
                                  fontSize: Constant.width * .05,
                                  fontWeight: FontWeight.w600,
                                  color: Constant.color1),
                            ),
                            Text(
                              data['goodsWeight'] ?? 'null',
                              style: TextStyle(
                                  fontSize: Constant.width * .05,
                                  fontWeight: FontWeight.w400,
                                  color: Constant.textColor),
                            )
                          ],
                        ),

                        /// Pickup Address Delivery Address
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// Pickup Address
                            SizedBox(
                              height: Constant.height * .09,
                              width: Constant.width * .44,
                              // color: Colors.red,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pickup Address',
                                    style: TextStyle(
                                        fontSize: Constant.width * .05,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87),
                                  ),
                                  Container(
                                    child: Text(
                                      data['pickUpAddress'] ?? 'null',
                                      style: TextStyle(
                                          fontSize: Constant.width * .04,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey),
                                      maxLines: 2,
                                    ),
                                  )
                                ],
                              ),
                            ),

                            /// Delivery Address
                            SizedBox(
                              height: Constant.height * .09,
                              width: Constant.width * .44,
                              // color: Colors.yellowAccent,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Delivery Address',
                                    style: TextStyle(
                                        fontSize: Constant.width * .05,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87),
                                  ),
                                  Text(
                                    data['deliveryAddress'] ?? 'null',
                                    style: TextStyle(
                                        fontSize: Constant.width * .04,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                    maxLines: 2,
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  /// QR Code Box
                  Container(
                    margin: EdgeInsets.only(
                        top: Constant.height * .03,
                        bottom: Constant.height * .03
                    ),
                    height: Constant.height * .34,
                    width: Constant.height * .34,
                    // color: Colors.grey.shade100,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
