import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_yatri/common/db/localData.dart';
import 'package:orange_yatri/constant/constant_color.dart';
import 'package:orange_yatri/pilot/pilot_home/pilot_home_page.dart';
import 'package:orange_yatri/ui/ui_helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PilotVehicleView extends StatefulWidget {
  final String vehicleNumber;
  const PilotVehicleView({super.key, required this.vehicleNumber});

  @override
  State<PilotVehicleView> createState() => _PilotVehicleViewState();
}

class _PilotVehicleViewState extends State<PilotVehicleView> {

  var data;
  var token;

  Future vehicleDetailsData() async {



    var userData = {'vehicleNumber': widget.vehicleNumber};

    var jsonData = json.encode(userData);

    http.Response response;

    try{

      response = await http.post(
        Uri.parse(
          'https://000quaslq5.execute-api.ap-south-1.amazonaws.com/orange_yatri/orangeYatri_pilot_particular_vehicle_all_data'
        ),
        body: jsonData,
      );
      
      if(response.statusCode == 200){
        
        var newResponse = json.decode(response.body);

        if(newResponse['body-json']['statusCode'] == 200){

          data = newResponse['body-json']['body'];

        }else if(newResponse['body-json']['statusCode'] == 400){

          debugPrint(newResponse['body-json']['body']);

        }
        
      }else{
        
        debugPrint('Failed');
        
      }

    }catch(e){

      debugPrint('saddam bhai ye Exception hai');
      debugPrint(e.toString());

    }



  }

  void deleteVehicle() async {

    var pref = await SharedPreferences.getInstance();
    token = pref.getString(LocalDb.KEYTOKEN);

    var userData = {'vehicleNumber': widget.vehicleNumber};
    // var authData = {
    //   'Authorization': token
    // };
    debugPrint(widget.vehicleNumber);

    var jsonData = json.encode(userData);

    http.Response response;

    try{

      response = await http.delete(
          Uri.parse(
              'https://000quaslq5.execute-api.ap-south-1.amazonaws.com/orange_yatri/orangeYatri_vehcile_delete'
          ),
          headers: <String, String> {
            'Authorization': token
          },
          body: jsonData,

      );

      if(response.statusCode == 200){

        var newResponse = json.decode(response.body);

        if(newResponse['body-json']['statusCode'] == 200){

          showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.info(
                message: 'Vehicle Deleted successfully',
                backgroundColor: Colors.green,
                textStyle: TextStyle(
                    fontSize: 25,
                    color: Constant.textBtnColor,
                    fontWeight: FontWeight.w600),
              ),
              displayDuration: const Duration(seconds: 2)
          );

          Get.offAll(const PilotHomePage());

        }else if(newResponse['body-json']['statusCode'] == 400){

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
              displayDuration: const Duration(seconds: 2)
          );

        }

      }else{

        showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.info(
              message: 'Failed',
              backgroundColor: Colors.white,
              textStyle: TextStyle(
                  fontSize: 25,
                  color: Constant.textBtnColor,
                  fontWeight: FontWeight.w600),
            ),
            displayDuration: const Duration(seconds: 2)
        );

      }

    }catch(e){

      debugPrint('saddam bhai ye Exception hai');
      debugPrint(e.toString());

    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: Constant.width * .02,
          right: Constant.width * .02,
        ),
        child: FutureBuilder(
          future: vehicleDetailsData(),
          builder: (context, snapshot) {

            if(snapshot.connectionState == ConnectionState.waiting){

              return const Center(
                child: CircularProgressIndicator(),
              );

            }else{

              return Center(
                child: Column(
                  children: [
                    SizedBox(height: Constant.height * .04,),

                    /// Heading Text
                    Text('Vehicle Details', style: TextStyle(fontSize: Constant.width * .07, fontWeight: FontWeight.w700, color: Colors.grey.shade800),),


                    /// Edit Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(''),
                        UiHelper.customOneByFourButton(() {

                          // Get.to(PilotUpdateProfile());

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
                          )
                      ),
                      child: Center(
                        child: Icon(Icons.drive_eta, size: Constant.height * .15,color: Colors.grey.shade800,),
                      ),
                    ),

                    SizedBox(height: Constant.height * .02,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Vehicle Name', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey.shade800, fontFamily: 'FontMain'),),
                        const Text('')
                      ],
                    ),
                    Container(
                      height: Constant.height * .06,
                      width: Constant.width * 1,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Colors.grey.shade800,
                              width: 1
                          )
                      ),
                      child: Text(data['vehicleName'] ?? 'null',style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade800
                      ),),
                    ),
                    SizedBox(height: Constant.height * .01,),

                    /// Mobile
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Vehicle Number', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey.shade800, fontFamily: 'FontMain'),),
                        const Text('')
                      ],
                    ),
                    Container(
                      height: Constant.height * .06,
                      width: Constant.width * 1,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Colors.grey.shade800,
                              width: 1
                          )
                      ),
                      child: Text(data['vehicleNumber'] ?? 'null',style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade800
                      ),),
                    ),
                    SizedBox(height: Constant.height * .01,),


                    /// Email
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Engine Number', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey.shade800, fontFamily: 'FontMain'),),
                        const Text('')
                      ],
                    ),
                    Container(
                      height: Constant.height * .06,
                      width: Constant.width * 1,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Colors.grey.shade800,
                              width: 1
                          )
                      ),
                      child: Text(data['engineNumber'] ?? 'null',style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade800
                      ),),
                    ),
                    SizedBox(height: Constant.height * .01,),

                    /// DL Number
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Chasis Number', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey.shade800, fontFamily: 'FontMain'),),
                        const Text('')
                      ],
                    ),
                    Container(
                      height: Constant.height * .06,
                      width: Constant.width * 1,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Colors.grey.shade800,
                              width: 1
                          )
                      ),
                      child: Text(data['chasisNumber'] ?? 'null',style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade800
                      ),),
                    ),
                    SizedBox(height: Constant.height * .135),


                    /// Logout Button
                    UiHelper.customButton(() {

                      deleteVehicle();

                    }, 'Delete Vehicle')
                  ],
                ),
              );

            }

          },
        ),
      ),
    );
  }
}
