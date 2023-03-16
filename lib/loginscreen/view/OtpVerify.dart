import 'package:barcode/loginscreen/view/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import '../../values/AppColors.dart';
import '../view model/UserViewModel.dart';
import '../../dashboardscreen/view/DashBoard.dart';

class OtpVerify extends StatefulWidget {
  const OtpVerify({Key? key}) : super(key: key);

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  String otpText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColor().buttoncolor),
      ),

        body: Padding(
      padding: const EdgeInsets.all(23),
      child: ResponsiveRowColumn(
        layout: ResponsiveWrapper.of(context).isLargerThan(MOBILE)
            ? ResponsiveRowColumnType.ROW
            : ResponsiveRowColumnType.COLUMN,
        children: [
          // const ResponsiveRowColumnItem(
          //   rowFlex: 1,
          //   columnFlex: 1,
          //   child: SizedBox(
          //     height: 20,
          //   ),
          // ),
          const ResponsiveRowColumnItem(
            rowFlex: 1,
            columnFlex: 1,
            child: SizedBox(
              width: 100,
            ),
          ),

          ResponsiveRowColumnItem(
            rowFlex: 3,
            columnFlex: 3,
            child: Center(
              child: Image.asset(
                'assets/frame.png',
              ),
            ),
          ),
          const ResponsiveRowColumnItem(
            rowFlex: 1,
            columnFlex: 0,
            child: SizedBox(
              width: 200,
            ),
          ),
          ResponsiveRowColumnItem(
              rowFlex: 3,
              columnFlex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 34,
                  ),
                  Text('ओटीपी दर्ज करें',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: AppColor().textcolor1)),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'एक 4 अंकों का कोड भेजा गया है',
                    style: GoogleFonts.poppins(
                        color: AppColor().textcolor1,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '+91 9995380399',
                    style: GoogleFonts.poppins(
                        color: AppColor().textcolor1,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  OTPTextField(
                      length: 6,
                      width: 350,
                      fieldWidth: 35,
                      inputFormatter: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                      onCompleted: (value) {
                        otpText = value;
                      },
                      onChanged: (value) {
                        otpText = value;
                      }),
                  const SizedBox(
                    height: 40,
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
                      if (otpText.isNotEmpty && otpText.length == 6) {
                        Provider.of<LoginViewModel>(context, listen: false)
                            .verifyUser(otp: otpText.toString());
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const DashBoard();
                        }));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("कृपया सही ओटीपी भरे")));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "सत्यापित करना",
                            style: GoogleFonts.poppins(
                                color: AppColor().textcolor2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      '0:30 में ओटीपी कोड दोबारा भेजें',
                      style: GoogleFonts.poppins(
                          color: AppColor().buttoncolor,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                  )
                ],
              ))
        ],
      ),
    ));
  }
}
