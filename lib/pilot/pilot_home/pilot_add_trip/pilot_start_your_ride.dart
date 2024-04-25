import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_yatri/constant/constant_color.dart';
import 'package:orange_yatri/pilot/pilot_home/pilot_add_trip/pilot_end_your_trip.dart';
import 'package:orange_yatri/ui/ui_helper.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:http/http.dart' as http;

class PilotStartYourRide extends StatefulWidget {
  final String dlNumber;
  final String vehicleNumber;
  const PilotStartYourRide(
      {super.key, required this.dlNumber, required this.vehicleNumber});

  @override
  State<PilotStartYourRide> createState() => _PilotStartYourRideState();
}

class _PilotStartYourRideState extends State<PilotStartYourRide> {

  String selectedDate = 'Select Date';
  String selectedTime = 'Select Time';

  TextEditingController goodsDetailsController = TextEditingController();
  TextEditingController goodsWeightController = TextEditingController();
  TextEditingController pickupAddressController = TextEditingController();
  TextEditingController deliveryAddressController = TextEditingController();
  TextEditingController enterDateController = TextEditingController();
  TextEditingController enterTimeController = TextEditingController();

  void StartRide(String dlNumber, vehicleNumber, goodsDetail, goodsWeight,
      pickupAddress, deliveryAddress, date, time) async {
    if (goodsDetail == '' ||
        goodsWeight == '' ||
        pickupAddress == '' ||
        deliveryAddress == '' ||
        date == 'Select Date' ||
        time == 'Select Time') {
      showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.info(
            message: 'Fill Required Field',
            backgroundColor: Colors.white,
            textStyle: TextStyle(
                fontSize: 25,
                color: Constant.textBtnColor,
                fontWeight: FontWeight.w600),
          ),
          displayDuration: const Duration(seconds: 2));
    } else {
      var userData = {
        "tripStartedBy": "TID946497",
        "tollName": "chordaha - Hazaribagh",
        "tollId": "TOLL24676467",
        'dlNumber': dlNumber,
        'vehicleNumber': vehicleNumber,
        'goodsDetails': goodsDetail,
        'goodsWeight': goodsWeight,
        'pickUpAddress': pickupAddress,
        'deliveryAddress': deliveryAddress,
        'date': date,
        'time': time
      };

      var jsonData = json.encode(userData);
      http.Response response;

      try {
        response = await http.post(
            Uri.parse(
                'https://000quaslq5.execute-api.ap-south-1.amazonaws.com/orange_yatri/orangeYatri_pilot_start_trip'),
            body: jsonData);

        if (response.statusCode == 200) {
          var newResponse = json.decode(response.body);

          if (newResponse['body-json']['statusCode'] == 200) {
            showTopSnackBar(
                Overlay.of(context),
                const CustomSnackBar.info(
                  message: 'Trip Started successfully',
                  backgroundColor: Colors.green,
                  textStyle: TextStyle(
                      fontSize: 25,
                      color: Constant.textBtnColor,
                      fontWeight: FontWeight.w600),
                ),
                displayDuration: const Duration(seconds: 2)
            );

            Get.off(PilotEndYourRide(tripId: newResponse['body-json']['tripId']));

          } else if (newResponse['body-json']['statusCode'] == 400) {
            showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.info(
                  message: newResponse['body-json']['body'],
                  backgroundColor: Colors.white,
                  textStyle: const TextStyle(
                      fontSize: 25,
                      color: Constant.textBtnColor,
                      fontWeight: FontWeight.w600),
                ),
                displayDuration: const Duration(seconds: 3));
          }
        } else {
          debugPrint('failed');

          showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.info(
                message: 'failed',
                backgroundColor: Colors.white,
                textStyle: TextStyle(
                    fontSize: 25,
                    color: Constant.textBtnColor,
                    fontWeight: FontWeight.w600),
              ),
              displayDuration: const Duration(seconds: 3));
        }
      } catch (e) {
        debugPrint('saddam bhai ye Exception hai');
        debugPrint(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: Constant.height * .08,
              ),

              /// Start Your Ride ( Heading Text )
              Text(
                'Start Your Ride',
                style: TextStyle(fontSize: Constant.width * .075, fontWeight: FontWeight.w700),
              ),

              SizedBox(
                height: Constant.height * .04,
              ),

              ///Goods Detailes ( TextField )
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 10),
              //       child: Text('GOODS DETAILS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Constant.textColor),),
              //     ),
              //     SizedBox(width: Constant.width *.001,)
              //   ],
              // ),
              UiHelper.customTextFieldWithLabel(
                  goodsDetailsController, 'Goods Detail', false),
              SizedBox(
                height: Constant.height * .02,
              ),

              ///Goods Weight ( TextField )
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 10),
              //       child: Text('GOODS WEIGHT', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Constant.textColor),),
              //     ),
              //     SizedBox(width: Constant.width *.001,)
              //   ],
              // ),
              UiHelper.customTextFieldWithLabel(
                  goodsWeightController, 'Goods Weight', false),
              SizedBox(
                height: Constant.height * .02,
              ),

              /// Pickup Adress ( TextField )
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 10),
              //       child: Text('GOODS DETAILS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Constant.textColor),),
              //     ),
              //     SizedBox(width: Constant.width *.001,)
              //   ],
              // ),
              UiHelper.customTextFieldWithLabel(
                  pickupAddressController, 'Pickup Address', false),
              SizedBox(
                height: Constant.height * .02,
              ),

              /// Delivery Address ( TextField )
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 10),
              //       child: Text('GOODS DETAILS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Constant.textColor),),
              //     ),
              //     SizedBox(width: Constant.width *.001,)
              //   ],
              // ),
              UiHelper.customTextFieldWithLabel(
                  deliveryAddressController, 'Delivery Address', false),
              SizedBox(
                height: Constant.height * .02,
              ),

              /// Date ( TextField )
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: Constant.width *.02),
                    child: Text('DATE', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.w400, color: Colors.grey.shade800),),
                  ),
                  SizedBox(width: Constant.width *.001,)
                ],
              ),
              // UiHelper.customTextFieldWithLabel(
              //     enterDateController, 'Date', false),


              /// Date ( DatePicker )
              Padding(
                padding: EdgeInsets.only(
                  left: Constant.width * .02,
                  right: Constant.width * .02,
                ),
                child: Container(
                  height: Constant.height * .08,
                  width: Constant.width * 1,
                  padding: EdgeInsets.only(
                    left: Constant.width * .02,
                    right: Constant.width * .02,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Constant.width * .01),
                    border: Border.all(
                      width: 1,
                      color: Constant.textColor
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(selectedDate, style: TextStyle(fontSize: Constant.width * .04, color: Colors.grey.shade800),),
                      IconButton(onPressed: () async {
                        /// Show Date Picker Funcnality
                        DateTime? datePicked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2099),
                        );

                        if(datePicked != null){
                          debugPrint('Date Selected : ${datePicked.day}-${datePicked.month}-${datePicked.year}');
                          setState(() {
                            selectedDate = '${datePicked.day}/${datePicked.month}/${datePicked.year}';
                          });
                        }
                      },
                        icon: Icon(Icons.calendar_month, color: Colors.grey.shade600, size: Constant.width * .08,),
                      )
                    ],
                  ),
                ),
              ),



              SizedBox(
                height: Constant.height * .02,
              ),

              /// TIME ( TextField )
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: Constant.width * .02),
                    child: Text('TIME', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.w400, color: Colors.grey.shade800),),
                  ),
                  SizedBox(width: Constant.width *.001,)
                ],
              ),
              // UiHelper.customTextFieldWithLabel(
              //     enterTimeController, 'Time', false),

              /// Time ( Time Picker )
              Padding(
                padding: EdgeInsets.only(
                  left: Constant.width * .02,
                  right: Constant.width * .02,
                ),
                child: Container(
                  height: Constant.height * .08,
                  width: Constant.width * 1,
                  padding: EdgeInsets.only(
                    left: Constant.width * .02,
                    right: Constant.width * .02,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Constant.width * .01),
                      border: Border.all(
                          width: 1,
                          color: Constant.textColor
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(selectedTime, style: TextStyle(fontSize: Constant.width * .04, color: Colors.grey.shade800),),
                      IconButton(onPressed: () async {
                        /// Show Date Picker Funcnality
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          initialEntryMode: TimePickerEntryMode.dial,
                        );

                        if(pickedTime != null){
                          debugPrint('time Selected : ${pickedTime.hour} : ${pickedTime.minute}');

                          setState(() {
                            selectedTime = '${pickedTime.hour} : ${pickedTime.minute}';
                          });
                        }
                      },
                        icon: Icon(Icons.access_time_rounded, color: Colors.grey.shade600, size: Constant.width * .08,),
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: Constant.height * .1,
              ),

              /// START Button
              UiHelper.customButton(() {
                StartRide(
                    widget.dlNumber,
                    widget.vehicleNumber,
                    goodsDetailsController.text.toString(),
                    goodsWeightController.text.toString(),
                    pickupAddressController.text.toString(),
                    deliveryAddressController.text.toString(),
                    selectedDate,
                    selectedTime
                );
              }, 'START')
            ],
          ),
        ),
      ),
    );
  }
}
