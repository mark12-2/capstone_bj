import 'dart:async';
import 'dart:io';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:capstone/styles/custom_button.dart';
import 'package:capstone/styles/custom_theme.dart';
import 'package:capstone/styles/textstyle.dart';
import 'package:capstone/styles/responsive_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:capstone/nav/nav.bar.dart';

class ResidentialEmployerPage extends StatefulWidget {
 const ResidentialEmployerPage({super.key});

 @override
 State<ResidentialEmployerPage> createState() => _ResidentialEmployerPageState();
}

class _ResidentialEmployerPageState extends State<ResidentialEmployerPage> {
 final TextEditingController _fullNameEmployerController = TextEditingController();
 final TextEditingController _emailEmployerController = TextEditingController();
 final FocusNode _fullNameEmployerFocusNode = FocusNode(); // Add a FocusNode
 final FocusNode _emailEmployerFocusNode = FocusNode();
 bool _isFullNameEmployerFocused = false;
 bool _isEmailEmployerFocused = false;

 @override
 void initState() {
    super.initState(); 
    _fullNameEmployerFocusNode.addListener(_onFocusChange); // Listen for focus changes
    _emailEmployerFocusNode.addListener(_onFocusChange); // Listen for focus changes
 }

 @override
 void dispose() {
    _fullNameEmployerController.dispose();
    _emailEmployerController.dispose();
    super.dispose();
 }

 void _onFocusChange() {
    setState(() {
      _isFullNameEmployerFocused = _fullNameEmployerFocusNode.hasFocus;
      _isEmailEmployerFocused = _emailEmployerFocusNode.hasFocus;
    });
 }

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Let's set up your account!",
                    style: CustomTextStyle.semiBoldText
                        .copyWith(fontSize: responsiveSize(context, 0.05))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: ListBody(
                children: [
                 TextField(
                    controller: _fullNameEmployerController,
                    focusNode: _fullNameEmployerFocusNode,
                    decoration: customInputDecoration('Full Name'),
                 ),
                 if (_isFullNameEmployerFocused)
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Enter your full name. Ex. Juan A. Dela CRUZ',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                 const SizedBox(
                    height: 20,
                 ),
                 TextField(
                    controller: _emailEmployerController,
                    focusNode: _emailEmployerFocusNode,
                    decoration: customInputDecoration('Email'),
                 ),
                 if (_isEmailEmployerFocused)
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Use an active email',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                 const SizedBox(
                    height: 20,
                 ),
                 IntlPhoneField(
                    decoration: customInputDecoration('Phone Number'),
                    initialCountryCode: 'PH', // Set the initial country code to Philippines
                    onChanged: (phone) {
                      print(phone.completeNumber); // This will print the complete number with country code
                    },
                 ),
                 CustomButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileUploadPageEmployer(),
                        ),
                      );
                    },
                    buttonText: 'Next',
                 ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
 }
}

class ProfileUploadPageEmployer extends StatefulWidget {
 const ProfileUploadPageEmployer({super.key});

 @override
 State<ProfileUploadPageEmployer> createState() => _ProfileUploadPageEmployerState();
}

class _ProfileUploadPageEmployerState extends State<ProfileUploadPageEmployer> {

  XFile? _imageFile;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        _imageFile = image;
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (image != null) {
        _imageFile = image;
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Upload your picture!",
                    style: CustomTextStyle.semiBoldText
                        .copyWith(fontSize: responsiveSize(context, 0.05))),
              )),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: ListBody(
              children: [
                InkWell(
                  onTap: _pickImage,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white, // Set the background color to white
                      borderRadius: BorderRadius.circular(
                          5), // This removes the rounded corners
                      border: Border.all(
                        color: Color.fromARGB(255, 19, 52, 77), // Set the border color to blue
                        width: 1, // Set the border width
                      ),
                    ),
                    child: const Center(
                      child: Text('Pick Image',
                          style: TextStyle(
                              color:
                                  Colors.black)), // Set the text color to black
                    ),
                  ),
                ),
                const SizedBox(height:20),
                InkWell(
                  onTap: _takePicture,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white, // Set the background color to white
                      borderRadius: BorderRadius.circular(
                          5), // This removes the rounded corners
                      border: Border.all(
                        color: Color.fromARGB(255, 19, 52, 77), // Set the border color to blue
                        width: 1, // Set the border width
                      ),
                    ),
                    child: Center(
                      child: Text('Take Picture',
                          style: TextStyle(
                              color:
                                  Colors.black)), // Set the text color to black
                    ),
                  ),
                ),
                if (_imageFile != null) Image.file(File(_imageFile!.path)),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EmployerAddressPage()));
                    },
                    buttonText: 'Next'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//employer address
class EmployerAddressPage extends StatefulWidget {
  const EmployerAddressPage({super.key});

  @override
  State<EmployerAddressPage> createState() => _EmployerAddressPageState();
}


class _EmployerAddressPageState extends State<EmployerAddressPage> {
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Input your Address Here!",
                    style: CustomTextStyle.semiBoldText
                        .copyWith(fontSize: responsiveSize(context, 0.05))),
              )),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ListBody(
              children: [
                TextField(
                  controller: _addressController,
                  decoration:
                      customInputDecoration('Find your Address').copyWith(
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EmployerUsernamePage()));
                    },
                    buttonText: 'Next')
              ],
            ),
          )
        ],
      ),
    );
  }
}

//username of employer
class EmployerUsernamePage extends StatefulWidget {
 const EmployerUsernamePage({super.key});

 @override
 State<EmployerUsernamePage> createState() => _EmployerUsernamePageState();
}

class _EmployerUsernamePageState extends State<EmployerUsernamePage> {
 final TextEditingController _userNameController = TextEditingController();
 final FocusNode _employerUserNameFocusNode = FocusNode(); // Add a FocusNode
 bool _isEmployerUserNameFocused = false;

 @override
 void initState() {
    super.initState();
    _employerUserNameFocusNode.addListener(_onUserNameFocusChange); // Listen for focus changes
 }

 @override
 void dispose() {
    _userNameController.dispose();
    _employerUserNameFocusNode.dispose();
    super.dispose();
 }

 void _onUserNameFocusChange() {
    setState(() {
      _isEmployerUserNameFocused = _employerUserNameFocusNode.hasFocus;
    });
 }

 @override
 Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Set up your username!",
                    style: CustomTextStyle.semiBoldText
                        .copyWith(fontSize: responsiveSize(context, 0.05))),
              )),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ListBody(
              children: [
                TextField(
                 controller: _userNameController,
                 focusNode: _employerUserNameFocusNode,
                 decoration: customInputDecoration('Username'),
                ),
                if (_isEmployerUserNameFocused)
                 Padding(
                     padding: const EdgeInsets.only(top: 8.0),
                     child: Text(
                       'This will be your identifier. Make it YOU-nique!',
                       style: TextStyle(color: Colors.grey, fontSize: 12),
                     ),
                 ),
                const SizedBox(
                 height: 20,
                ),
                CustomButton(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EmployerCodePage()));
                    },
                    buttonText: 'Next'),
              ],
            ),
          )
        ]));
 }
}
//end username

//code for employer
class EmployerCodePage extends StatefulWidget {
 const EmployerCodePage({super.key});

 @override
 State<EmployerCodePage> createState() => _EmployerCodePageState();
}

class _EmployerCodePageState extends State<EmployerCodePage> {
 final TextEditingController _codeController = TextEditingController();
 final FocusNode _codeFocusNode = FocusNode();
 bool _isCodeFocused = false;
 StreamController<int>? _streamController;
 int _start = 120; // 2 minutes in seconds

 @override
 void initState() {
    super.initState();
    _codeFocusNode.addListener(_onFocusChange);
    _startTimer();
 }

 void _startTimer() {
    _streamController = StreamController<int>();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
        _streamController?.close();
      } else {
        _start--;
        _streamController?.add(_start);
      }
    });
 }

 @override
 void dispose() {
    _codeController.dispose();
    _codeFocusNode.dispose();
    _streamController?.close();
    super.dispose();
 }

 void _onFocusChange() {
    setState(() {
      _isCodeFocused = _codeFocusNode.hasFocus;
    });
 }

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text("A code was sent to your account!",
                style: CustomTextStyle.semiBoldText
                    .copyWith(fontSize: responsiveSize(context, 0.05))),
        )),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ListBody(children: [
            TextField(
              controller: _codeController,
              focusNode: _codeFocusNode,
              decoration: customInputDecoration('Code here'),
            ),
            if (_isCodeFocused)
              const Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                 'Go to your email and enter the code sent to you.',
                 style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            const SizedBox(height: 20),
            StreamBuilder<int>(
              stream: _streamController?.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                 final minutes = snapshot.data! ~/ 60;
                 final seconds = snapshot.data! % 60;
                 return Text(
                      'Resend the code in: ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}');
                } else {
                 return ElevatedButton(
                    onPressed: () {
                      // Implement your logic to resend the code here
                      print('Resend the code');
                      _start = 120; // Reset the timer
                      _startTimer();
                    },
                    child: Text('Resend the code'),
                 );
                }
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EmployerPasswordPage()));
              },
              buttonText: 'Next'),
          ]),
        )
      ]));
 }
}
//end employer code

//start password
class EmployerPasswordPage extends StatefulWidget {
  const EmployerPasswordPage({super.key});

  @override
  State<EmployerPasswordPage> createState() => _EmployerPasswordPageState();
}

class _EmployerPasswordPageState extends State<EmployerPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =TextEditingController();
 

  @override
  void dispose() {
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }
 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Set up your password!",
                style: CustomTextStyle.semiBoldText.copyWith(
                 fontSize: responsiveSize(context, 0.05),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ListBody(
              children: [
                Text(
                 'Create a password with the combination of letters, numbers, and special characters.',
                 style: CustomTextStyle.LightText.copyWith(
                    fontSize: responsiveSize(context, 0.03),
                 ),
                ),
                const SizedBox(height: 20),
                TextField(
                 controller: _passwordController,
                 decoration: customInputDecoration('Password',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                 controller: _repeatPasswordController,
                 decoration: customInputDecoration('Retype your Password'),
                ),
                const SizedBox(height: 20),
                CustomButton(
                 onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EmployerDoneCreatePage(),
                      ),
                    );
                 },
                 buttonText: 'Next',
                ),
               // ),
              ],
            ),
          ),
        ],
      ),
    );
 }
}
//end for password of employer

//start done create for employer
class EmployerDoneCreatePage extends StatefulWidget {
  const EmployerDoneCreatePage({super.key});

  @override
  State<EmployerDoneCreatePage> createState() => _EmployerDoneCreatePageState();
}

class _EmployerDoneCreatePageState extends State<EmployerDoneCreatePage> {
//final GlobalKey<ConfettiController> _confettiKey = GlobalKey<ConfettiController>();
//final GlobalKey _confettiKey = GlobalKey();
 final ConfettiController _confettiKey = ConfettiController(duration: Duration(seconds: 10));


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _confettiKey.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: _confettiKey,
      blastDirectionality: BlastDirectionality.explosive, // Explosive blast
      colors: const [
        Colors.orange,
        Color.fromARGB(255, 7, 30, 47),
        Colors.white,
      ], 
    child:  Scaffold(
        appBar: AppBar(),
        body: Column(children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Welcome to BlueJobs!",
                    style: CustomTextStyle.titleText
                        .copyWith(fontSize: responsiveSize(context, 0.05))),
              )),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ListBody(
              children: [
                CustomButton(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EmployerNavBarPage()));
                    },
                    buttonText: 'Get Started'),
              ],
            ),
          )
        ]
      )
    )
    );
  }
}





