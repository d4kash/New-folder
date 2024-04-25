import 'package:flutter/material.dart';
import 'package:orange_yatri/constant/constant_color.dart';
import 'package:orange_yatri/ui/ui_helper.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: Constant.height * .03, left: Constant.width * .03, right: Constant.width * .03),
          child: Column(
            children: [

              /// Greeting and Profile
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  /// Hallo Sharma ji and Welcome to E-Yatri
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello Sharma ji', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Constant.textColor),),
                      Text('Welcome to E-Yatri', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),),
                    ],
                  ),

                  /// Profile
                  Container(
                    height: Constant.height * .08,
                    width: Constant.width * .16,
                    decoration: BoxDecoration(
                        color: Colors.black,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  )
                ],
              ),

              /// Track My Vehicle Card
              Container(
                padding: EdgeInsets.all(Constant.height * .01),
                height: Constant.height * .35,
                width: Constant.width * 1,
                color: Colors.transparent,
                child: Stack(
                  children: [
                    /// Lower Container
                    Container(
                      height: Constant.height * .39,
                      width: Constant.width * 1,
                      padding: EdgeInsets.only(top: Constant.height * .25),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                          bottomLeft: Radius.circular(60),
                          bottomRight: Radius.circular(60)
                        )
                      ),
                      child: TextButton(
                        child: const Text('Track My Vehicle', style: TextStyle(fontSize: 20, color: Colors.white),),
                        onPressed: () {

                        },
                      ),
                    ),

                    /// Upper Container
                    Container(
                      height: Constant.height * .25,
                      width: Constant.width * 1,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            /// Identity row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /// Vehicle Number , Name and Date
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('TATA [ JH 02 AM 2548 ]', style: TextStyle(color: Constant.textColor, fontSize: 15),),
                                    Text('Ashok Tiwari [ pilot-id ]', style: TextStyle(fontSize: 15),),
                                    Text('Fri, 2 Mar 2024', style: TextStyle(fontSize: 15),),
                                  ],
                                ),

                                /// On The Way Button
                                Container(
                                  height: Constant.height * .06,
                                  width: Constant.width * .3,
                                  decoration: BoxDecoration(
                                    color: Constant.textBtnColor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: TextButton(
                                    onPressed: () {

                                    },
                                    child: const Text('On The Way', style: TextStyle(color: Colors.white),),

                                  ),
                                )

                              ],
                            ),

                            /// Single Line Baar
                            SizedBox(
                              height: Constant.height * .05,
                              width: Constant.width * 1,
                              // color: Constant.textBtnColor,
                            ),


                            /// Pickup Adress Delivery address
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /// Pickup Address
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Pickup Address', style: TextStyle(color: Constant.textColor),),
                                    Text('Jharkhand, India', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                                  ],
                                ),
                                
                                /// Delivery Address
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('Delivery address', style: TextStyle(color: Constant.textColor),),
                                    Text('Mumbai, India', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                                  ],
                                )
                              ],
                            )

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// All Cards
              // GridView.builder(
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2,
              //   ),
              //   itemCount: 4,
              //   itemBuilder: (context, index) {
              //     UiHelper.customHomeCard(() {
              //
              //     }, 'saddam', Icons.home);
              //   },
              // ),


              // Container(
              //   height: Constant.height * .4,
              //   width: Constant.width * 1,
              //   child: GridView(
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       mainAxisSpacing: Constant.height * .01,
              //       crossAxisSpacing: Constant.width * .02,
              //     ),
              //     children: [
              //       UiHelper.customHomeCard(() {
              //
              //       }, 'Home-1', Icons.home),
              //
              //       UiHelper.customHomeCard(() {
              //
              //       }, 'Home-2', Icons.home),
              //
              //       UiHelper.customHomeCard(() {
              //
              //       }, 'Home-3', Icons.home),
              //
              //       UiHelper.customHomeCard(() {
              //
              //       }, 'Home-4', Icons.home),
              //     ],
              //   ),
              // ),


              SizedBox(height: Constant.height * .03),

              Column(
                children: [
                  Row(
                    children: [
                      UiHelper.customHomeCard(() {

                      }, 'Pilot', Icons.home),

                      SizedBox(width: Constant.width * .04),

                      UiHelper.customHomeCard(() {

                      }, 'All Vehicle', Icons.home),
                    ],
                  ),
                  SizedBox(height: Constant.height * .02),
                  Row(
                    children: [
                      UiHelper.customHomeCard(() {

                      }, 'Live Trips', Icons.home),

                      SizedBox(width: Constant.width * .04),

                      UiHelper.customHomeCard(() {

                      }, 'History', Icons.home),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade200,
    );
  }
}
