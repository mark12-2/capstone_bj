import 'package:capstone/provider/auth_provider.dart';
import 'package:capstone/styles/custom_button.dart';
import 'package:capstone/styles/textstyle.dart';
import 'package:capstone/utils/utils.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:capstone/styles/responsive_utils.dart';
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
              // svg asset
              // Image.asset(
              //   'assets/images/bluejobs.png',
              //   width: 250,
              //   height: 250,
              // ),
              // const SizedBox(height: 20),
              Text(
                'Connecting Blue Collars. One Tap at a time!',
                style: CustomTextStyle.semiBoldText.copyWith(
                  color: Colors.white,
                  fontSize: responsiveSize(context, 0.03),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Enter your Phone Number',
                style: CustomTextStyle.semiBoldText.copyWith(
                  color: Colors.white,
                  fontSize: responsiveSize(context, 0.03),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    phoneController.text = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  hintStyle: CustomTextStyle.regularText,
                  fillColor: Colors.white,
                  filled: true,
                  border: const OutlineInputBorder(),
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(10.0),
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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                          style: const TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  ),
                ),
                // maxLength: 10,
              ),
              const SizedBox(height: 20),
              SizedBox(
                child: CustomButton(
                  onPressed: () => sendPhoneNumber(),
                  buttonText: "Submit",
                ),
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
        ap.signInWithPhone(
            context, "+${selectedCountry.phoneCode}$phoneNumber");
      } catch (e) {
        showSnackBar(context, "Failed to sign in: ${e.toString()}");
      }
    } else {
      showSnackBar(context, "Please enter a valid phone number.");
    }
  }
}
