import 'package:barcode/values/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../responsive/Responsive.dart';
import '../view model/UserViewModel.dart';
import 'OtpVerify.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobileNumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(23),
          child: ResponsiveRowColumn(
            layout: ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                ? ResponsiveRowColumnType.ROW
                : ResponsiveRowColumnType.COLUMN,
            children:   [
            const ResponsiveRowColumnItem(
            rowFlex: 1,
            columnFlex: 1,
            child: SizedBox(
              height: 20,
            ),
          ),
              const ResponsiveRowColumnItem(
                rowFlex: 1,
                columnFlex: 1,
                child: SizedBox(
                  width: 100,
                ),
              ),
              const ResponsiveRowColumnItem(
                  rowFlex: 3,
                  columnFlex: 3,
                  child: Image(image: AssetImage('assets/frame.png'))),
              const ResponsiveRowColumnItem(
                rowFlex: 1,
                columnFlex: 1,
                child: SizedBox(
                  width: 200,
                ),
              ),

              ResponsiveRowColumnItem(
                rowFlex:2,
                columnFlex: 6,
                child: Column(
                   mainAxisAlignment: ResponsiveWrapper.of(context).isTablet|| ResponsiveWrapper.of(context).isDesktop?  MainAxisAlignment.center: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 34,),
                    Text('लॉगिन करे',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: AppColor().textcolor1)),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'अपना मोबाइल नंबर दर्ज करें, हम आपको बाद में सत्यापित करने के लिए ओटीपी भेजेंगे',
                      style: GoogleFonts.poppins(
                          color: AppColor().textcolor1,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      maxLength: 10,
                      controller: mobileNumController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Text(
                          '  +91  ',
                          style: GoogleFonts.poppins(
                              color: AppColor().textcolor1,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                        prefixIconConstraints:
                        const BoxConstraints(minWidth: 0, minHeight: 0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        fillColor: Colors.white,
                        filled: true,
                        hintText: '000-000-00-00',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                            const BorderSide(width: 1, color: Colors.black)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        shadowColor:
                        MaterialStateProperty.all(AppColor().buttoncolor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        backgroundColor:
                        MaterialStateProperty.all(AppColor().buttoncolor),
                      ),
                      onPressed: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mobileNumController.text.length == 10) {
                            // print('------------------demo111111');
                            Provider.of<LoginViewModel>(context, listen: false)
                                .loginUser(mobileNum: mobileNumController.text);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return const OtpVerify();
                                }));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("कृपया सही फ़ोन नंबर दर्ज करे ")));
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "लॉगिन",
                              style:
                              GoogleFonts.poppins(color: AppColor().textcolor2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ),
          //Column(
          //   children: [
          //     const SizedBox(
          //       height: 20,
          //     ),
          //     Container(
          //       height: Responsive.isSmallScreen(context) ? 300 : 500,
          //       child: Align(
          //         alignment: Responsive.isSmallScreen(context)
          //             ? Alignment.center
          //             : Alignment.centerLeft,
          //         child: Image.asset(
          //           'assets/frame.png',
          //           width: 258,
          //           height: 258,
          //         ),
          //       ),
          //     ),
          //     const SizedBox(
          //       height: 34,
          //     ),
          //     Align(
          //       alignment: Responsive.isSmallScreen(context)?Alignment.center:Alignment.topRight,
          //       child: Container(
          //         width: Responsive.isSmallScreen(context)?300:500,
          //         child: Column(
          //           children: [
          //             Text('लॉगिन करे',
          //                 style: GoogleFonts.poppins(
          //                     fontWeight: FontWeight.w600,
          //                     fontSize: 24,
          //                     color: AppColor().textcolor1)),
          //             const SizedBox(
          //               height: 8,
          //             ),
          //             Text(
          //               'अपना मोबाइल नंबर दर्ज करें, हम आपको बाद में सत्यापित करने के लिए ओटीपी भेजेंगे',
          //               style: GoogleFonts.poppins(
          //                   color: AppColor().textcolor1,
          //                   fontSize: Responsive.isSmallScreen(context) ? 14 : 20,
          //                   fontWeight: FontWeight.w400),
          //             ),
          //             const SizedBox(
          //               height: 30,
          //             ),
          //             TextFormField(
          //               maxLength: 10,
          //               controller: mobileNumController,
          //               keyboardType: TextInputType.number,
          //               textInputAction: TextInputAction.next,
          //               decoration: InputDecoration(
          //                 prefixIcon: Text(
          //                   '  +91  ',
          //                   style: GoogleFonts.poppins(
          //                       color: AppColor().textcolor1,
          //                       fontWeight: FontWeight.w500,
          //                       fontSize: 16),
          //                 ),
          //                 prefixIconConstraints:
          //                 const BoxConstraints(minWidth: 0, minHeight: 0),
          //                 floatingLabelBehavior: FloatingLabelBehavior.always,
          //                 fillColor: Colors.white,
          //                 filled: true,
          //                 hintText: '000-000-00-00',
          //                 border: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(8),
          //                     borderSide:
          //                     const BorderSide(width: 1, color: Colors.black)),
          //               ),
          //               validator: (value) {
          //                 if (value!.isEmpty) {
          //                   return 'Please enter password';
          //                 }
          //                 return null;
          //               },
          //             ),
          //             const SizedBox(
          //               height: 40,
          //             ),
          //             ElevatedButton(
          //               style: ButtonStyle(
          //                 shadowColor:
          //                 MaterialStateProperty.all(AppColor().buttoncolor),
          //                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //                     RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.circular(10),
          //                     )),
          //                 backgroundColor:
          //                 MaterialStateProperty.all(AppColor().buttoncolor),
          //               ),
          //               onPressed: () {
          //                 WidgetsBinding.instance.addPostFrameCallback((_) {
          //                   if (mobileNumController.text.length == 10) {
          //                     // print('------------------demo111111');
          //                     Provider.of<LoginViewModel>(context, listen: false)
          //                         .loginUser(mobileNum: mobileNumController.text);
          //                     Navigator.push(context,
          //                         MaterialPageRoute(builder: (context) {
          //                           return const OtpVerify();
          //                         }));
          //                   } else {
          //                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //                         content: Text("कृपया सही फ़ोन नंबर दर्ज करे ")));
          //                   }
          //                 });
          //               },
          //               child: Padding(
          //                 padding: const EdgeInsets.all(12),
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     Text(
          //                       "लॉगिन",
          //                       style:
          //                       GoogleFonts.poppins(color: AppColor().textcolor2),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     )
          //
          //   ],
          // ),
]
          ),
        ));
  }
}
