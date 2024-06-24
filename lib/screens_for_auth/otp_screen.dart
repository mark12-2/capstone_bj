import 'package:capstone/navigation/employer_navigation.dart';
import 'package:capstone/navigation/jobhunter_navigation.dart';
import 'package:capstone/screens_for_auth/user_information.dart';
import 'package:capstone/testing_file/home_screen.dart';
import 'package:capstone/styles/custom_button.dart';
import 'package:capstone/styles/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:capstone/provider/auth_provider.dart';
import 'package:capstone/default_screens/home.dart';
// import 'package:capstone/screens/user_information_screen.dart';
import 'package:capstone/utils/utils.dart';
import 'package:pinput/pinput.dart';
// import 'package:capstone/widgets/custom_button.dart';
// import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 7, 30, 47),
      ),
      backgroundColor: const Color.fromARGB(255, 19, 52, 77),
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 233, 232, 233),
                ),
              )
            : Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Verification",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Enter the OTP send to your phone number",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Pinput(
                        length: 6,
                        showCursor: true,
                        defaultPinTheme: PinTheme(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.orange,
                            ),
                          ),
                          textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        onCompleted: (value) {
                          setState(() {
                            otpCode = value;
                          });
                        },
                      ),
                      const SizedBox(height: 25),
                      TextButton(
                          onPressed: () {
                            if (otpCode != null) {
                              verifyOtp(context, otpCode!);
                            } else {
                              showSnackBar(context, "Enter 6-Digit code");
                            }
                          },
                          child: Text(
                            "Verify",
                            style: CustomTextStyle.regularText.copyWith(
                              color: Colors.white,
                            ),
                          )
                          ),
                      const SizedBox(height: 20),
                      const Text(
                        "Didn't receive any code?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Resend New Code",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  // verify otp
  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        // Check if user exists in the database
        ap.checkExistingUser().then((value) async {
          if (value == true) {
            ap.getDataFromFirestore().then(
              (userData) async {
                await ap.saveUserDataToSP();
                await ap.setSignIn();

                // Fetch the user's role from the fetched data
                String role = ap.userModel.role;

                // Navigate to the designated page based on the role
                if (role == 'Employer') {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EmployerNavigation(),
                    ),
                    (route) => false,
                  );
                } else if (role == 'Job Hunter') {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const JobhunterNavigation(),
                    ),
                    (route) => false,
                  );
                }
              },
            );
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Welcome'),
                  content: const Text(
                      'It looks like you\'re new here. Please complete your profile to get started.'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Complete Profile'),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const UserInformation()));
                      },
                    ),
                  ],
                );
              },
            );
          }
        });
      },
    );
  }
}
