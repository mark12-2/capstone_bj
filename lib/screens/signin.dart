import 'package:capstone/provider/auth_provider.dart';
import 'package:capstone/screens/otp_screen.dart';
import 'package:capstone/screens/signup.dart';
import 'package:capstone/screens/user_information.dart';
import 'package:capstone/styles/custom_button.dart';
import 'package:capstone/styles/textstyle.dart';
import 'package:capstone/utils/utils.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:capstone/styles/custom_button.dart';
import 'package:capstone/styles/responsive_utils.dart';
// import 'package:capstone/nav/nav.bar.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController phoneController = TextEditingController();

  Country selectedCountry = Country(
      phoneCode: "63",
      countryCode: "PH",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "Philippines",
      example: "9171234567",
      displayName: "Philippines (PH) [+63]",
      displayNameNoCountryCode: "Philippines",
      e164Key: "63-PH-0");

  @override
  Widget build(BuildContext context) {
    // final ap = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 7, 30, 47),
      ),
      backgroundColor: const Color.fromARGB(255, 19, 52, 77),
      //backgroundColor: Color(0xFF0A5BF5),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SvgPicture.asset(
              //   'assets/images/bluejobs.svg',
              //   width: 100,
              //   height: 100,
              // ),
              const SizedBox(height: 20),
              // Text(
              //   'Connecting Blue Collars. One Tap at a time!',
              //   style: CustomTextStyle.semiBoldText.copyWith(
              //     color: Colors.white,
              //     fontSize: responsiveSize(context, 0.03),
              //   ),
              // ),
              const Text(
                'Log In Account',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Enter your Phone Number to Login your Account',
                style: CustomTextStyle.semiBoldText.copyWith(
                  color: Colors.white,
                  fontSize: responsiveSize(context, 0.03),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    phoneController.text = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter Phone Number',
                  labelStyle: CustomTextStyle.semiBoldText,
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                  prefixIcon: Container(
                    padding: EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        showCountryPicker(
                            context: context,
                            countryListTheme: const CountryListThemeData(
                              bottomSheetHeight: 600,
                            ),
                            onSelect: (value) {
                              setState(() {
                                selectedCountry = value;
                              });
                            });
                      },
                      child: Text(
                        "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  // suffixIcon: phoneController.text.length > 9
                  //     ? Container(
                  //         height: 20,
                  //         width: 20,
                  //         margin: const EdgeInsets.all(10.0),
                  //         decoration: const BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           color: Colors.green,
                  //         ),
                  //         child: const Icon(
                  //           Icons.done,
                  //           color: Colors.white,
                  //           size: 20,
                  //         ),
                  //       )
                  //     : null,
                ),
                // maxLength: 10,
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () => sendPhoneNumber(),
                child: Text(
                  "Sign in",
                  style: CustomTextStyle.regularText.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // Navigate to the registration page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserInformation()),
                      );
                    },
                    child: Text(
                      "Register here",
                      style: CustomTextStyle.regularText.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // function upon signing in with phone number
  void sendPhoneNumber() {
  final ap = Provider.of<AuthProvider>(context, listen: false);
  String phoneNumber = phoneController.text.trim();
  if (phoneNumber.isNotEmpty) {
    try {
      ap.signInWithPhone(context, "+${selectedCountry.phoneCode}$phoneNumber");
    } catch (e) {
      showSnackBar(context, "Failed to sign in: ${e.toString()}");
    }
  } else {
    showSnackBar(context, "Please enter a valid phone number.");
  }
}
}
