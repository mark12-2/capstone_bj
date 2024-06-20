
import 'package:capstone/default_screens/home.dart';
import 'package:flutter/material.dart';
import 'package:capstone/styles/textstyle.dart';
import 'package:capstone/styles/responsive_utils.dart';
import 'package:capstone/styles/custom_theme.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:capstone/styles/custom_button.dart';
import 'package:confetti/confetti.dart';
import 'dart:async';
import 'package:capstone/styles/custom_inkwell_signup.dart';
// import 'package:capstone/screens/employer_form.dart';
import 'package:capstone/address/addresses.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        const SizedBox(
          height: 50,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Are you a Blue Collar Job Hunter or an Employer",
                  style: CustomTextStyle.semiBoldText
                      .copyWith(fontSize: responsiveSize(context, 0.05))),
            )),
        Padding(
          padding: EdgeInsets.all(10),
          child: ListBody(
            children: [
              const SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlueCollarJobHuntersForm()));
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width -
                          50, // Adjust the width to match the input fields
                      height: 55,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                5), // Set border radius to 5
                          ),
                          fillColor: const Color.fromARGB(255, 7, 30, 47),
                          filled: true,
                        ),
                        child: Center(
                          child: Text('I am a Blue Collar Job Hunter',
                              style: CustomTextStyle.regularText.copyWith(
                                color: Colors.white,
                              )),
                        ),
                      ))),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmployerForm()));
                  },
                  child: Container(
                      //padding: EdgeInsets.only(left: 10),
                      width: MediaQuery.of(context).size.width -
                          50, // Adjust the width to match the input fields
                      height: 55,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                5), // Set border radius to 5
                          ),
                          fillColor: const Color.fromARGB(
                              255, 7, 30, 47), // Set background color
                          filled:
                              true, // Use filled property to apply the background color
                        ),
                        child: Center(
                          child: Text('I am an Employer',
                              style: CustomTextStyle.regularText.copyWith(
                                color: Colors.white,
                              )),
                        ),
                      ))),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        )
      ]),
    );
  }
}

class BlueCollarJobHuntersForm extends StatefulWidget {
  const BlueCollarJobHuntersForm({super.key});

  @override
  State<BlueCollarJobHuntersForm> createState() =>
      _BlueCollarJobHuntersFormState();
}

class _BlueCollarJobHuntersFormState extends State<BlueCollarJobHuntersForm> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _fullNameFocusNode = FocusNode(); // Add a FocusNode
  final FocusNode _emailFocusNode = FocusNode();
  bool _isFullNameFocused = false;
  bool _isEmailFocused = false;

  @override
  void initState() {
    super.initState();
    _fullNameFocusNode.addListener(_onFocusChange); // Listen for focus changes
    _emailFocusNode.addListener(_onFocusChange); // Listen for focus changes
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFullNameFocused = _fullNameFocusNode.hasFocus;
      _isEmailFocused = _emailFocusNode.hasFocus;
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
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Let's set up your account!",
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
                      controller: _fullNameController,
                      focusNode: _fullNameFocusNode,
                      decoration: customInputDecoration('Full Name'),
                    ),
                    if (_isFullNameFocused)
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
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      decoration: customInputDecoration('Email'),
                    ),
                    if (_isEmailFocused)
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
                      initialCountryCode:
                          'PH', // Set the initial country code to Philippines
                      onChanged: (phone) {
                        print(phone
                            .completeNumber); // This will print the complete number with country code
                      },
                    ),
                    // CustomButton(
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) =>
                    //                   const ProfileUploadPage()));
                    //     },
                    //     buttonText: 'Next'),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

//profile pic
class ProfileUploadPage extends StatefulWidget {
  const ProfileUploadPage({super.key});

  @override
  State<ProfileUploadPage> createState() => _ProfileUploadPageState();
}

class _ProfileUploadPageState extends State<ProfileUploadPage> {
  //File? _imageFile;
  //bool _isImageSelected = false;
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
                        color: const Color.fromARGB(
                            255, 19, 52, 77), // Set the border color to blue
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
                const SizedBox(height: 20),
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
                        color: const Color.fromARGB(
                            255, 19, 52, 77), // Set the border color to blue
                        width: 1, // Set the border width
                      ),
                    ),
                    child: const Center(
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
                // CustomButton(
                //     onTap: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => const AddressPage()));
                //     },
                //     buttonText: 'Next'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//address
class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final TextEditingController _addressController = TextEditingController();
  final FocusNode _addressFocusNode = FocusNode();

  @override
  void dispose() {
    _addressController.dispose();
    _addressFocusNode.dispose();
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
              // address input
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
            //auto complete search addresses, but only in albay
            child: Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                }
                // fix input in adresses due to other syntaxes like a comma
                String normalizedInput =
                    textEditingValue.text.toLowerCase().replaceAll(',', '');
                return Addresses.allAddresses.where((String option) {
                  String normalizedOption =
                      option.toLowerCase().replaceAll(',', '');
                  return normalizedOption.contains(normalizedInput);
                }).toList();
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController fieldTextEditingController,
                  FocusNode fieldFocusNode,
                  VoidCallback onFieldSubmitted) {
                _addressController.text = fieldTextEditingController.text;
                return TextField(
                  controller: fieldTextEditingController,
                  focusNode: fieldFocusNode,
                  decoration: const InputDecoration(
                    labelText: 'Find your Address',
                    suffixIcon: Icon(Icons.search),
                  ),
                );
              },
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<String> onSelected,
                  Iterable<String> options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: options.map<Widget>((String option) {
                        return InkWell(
                          onTap: () => onSelected(option),
                          child: ListTile(
                            title: Text(option),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // CustomButton(
          //     onTap: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => const HomePage()));
          //     },
          //     buttonText: 'Next')
        ],
      ),
    );
  }
}

//done create that navigates to home
class DoneCreatePage extends StatefulWidget {
  const DoneCreatePage({super.key});

  @override
  State<DoneCreatePage> createState() => _DoneCreatePageState();
}

class _DoneCreatePageState extends State<DoneCreatePage> {
//final GlobalKey<ConfettiController> _confettiKey = GlobalKey<ConfettiController>();
//final GlobalKey _confettiKey = GlobalKey();
  final ConfettiController _confettiKey =
      ConfettiController(duration: Duration(seconds: 10));

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
        child: Scaffold(
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
                    // CustomButton(
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => const NavBarPage()));
                    //     },
                    //     buttonText: 'Get Started'),
                  ],
                ),
              )
            ])));
  }
}

//employer
class EmployerForm extends StatefulWidget {
  const EmployerForm({super.key});

  @override
  State<EmployerForm> createState() => _EmployerFormState();
}

class _EmployerFormState extends State<EmployerForm> {
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
            child: Text('Hmmm... Blue Collar Job Hunter or an Employer?',
                style: CustomTextStyle.semiBoldText
                    .copyWith(fontSize: responsiveSize(context, 0.05))),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: ListBody(
              children: [
                const SizedBox(
                  height: 20,
                ),
                CustomInkWellButton(
                  buttonText: 'Residential',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlueCollarJobHuntersForm()),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomInkWellButton(
                  buttonText: 'Small time Business Owner',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlueCollarJobHuntersForm()),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
