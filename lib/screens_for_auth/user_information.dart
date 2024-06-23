import 'dart:io';
import 'package:capstone/dropdowns/addresses.dart';
import 'package:capstone/model/user_model.dart';
import 'package:capstone/navigation/employer_navigation.dart';
import 'package:capstone/navigation/jobhunter_navigation.dart';
import 'package:capstone/provider/auth_provider.dart';
import 'package:capstone/styles/custom_button.dart';
import 'package:capstone/styles/custom_theme.dart';
import 'package:capstone/styles/responsive_utils.dart';
import 'package:capstone/styles/textstyle.dart';
import 'package:capstone/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  File? image;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String? _roleSelection;
  final _birthdayController = TextEditingController();
  String? _address;
  // focus node - name and email
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  // birthdate
  final FocusNode _birthdayFocusNode = FocusNode();
  DateTime? _selectedDate;

  bool _isNameFocused = false;
  bool _isEmailFocused = false;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _birthdayController.dispose();
    _birthdayFocusNode.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Listen for focus changes
    _nameFocusNode.addListener(_onFocusChange);
    _emailFocusNode.addListener(_onFocusChange);
    _roleSelection = null;
    _address = null;
  }

  void _onFocusChange() {
    setState(() {
      _isNameFocused = _nameFocusNode.hasFocus;
      _isEmailFocused = _emailFocusNode.hasFocus;
    });
  }

// birthdate input
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _birthdayController.text =
            DateFormat('yyyy-MM-dd').format(_selectedDate!);
      });
    }
  }

  // for selecting image
  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Hi New User! Let's set up your account.",
                              style: CustomTextStyle.semiBoldText.copyWith(
                                  fontSize: responsiveSize(context, 0.05))),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    // circle avatar
                    InkWell(
                      onTap: () => selectImage(),
                      child: image == null
                          ? const CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 50,
                              child: Icon(
                                Icons.account_circle,
                                size: 50,
                                color: Colors.white,
                              ),
                            )
                          : CircleAvatar(
                              backgroundImage: FileImage(image!),
                              radius: 50,
                            ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListBody(children: [
                        TextField(
                          // name input
                          controller: _nameController,
                          focusNode: _nameFocusNode,
                          decoration: customInputDecoration('Full Name'),
                        ),
                        if (_isNameFocused)
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Enter your full name. Ex. Juan A. Dela CRUZ',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                        const SizedBox(
                          height: 20,
                        ),

                        TextField(
                          //email input
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          decoration: customInputDecoration('Email'),
                        ),
                        if (_isEmailFocused)
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Use an active email',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                        const SizedBox(
                          height: 15,
                        ),

                        // birthdate input
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: GestureDetector(
                            onTap: () => _selectDate(context),
                            child: AbsorbPointer(
                              child: TextField(
                                controller: _birthdayController,
                                focusNode: _birthdayFocusNode,
                                decoration: const InputDecoration(
                                    labelText: 'Birthday',
                                    suffixIcon: Icon(Icons.calendar_today),
                                    hintText: 'Select your birthday',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        // address input
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          //auto complete search addresses, but only in albay
                          child: Autocomplete<String>(
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              if (textEditingValue.text.isEmpty) {
                                return const Iterable<String>.empty();
                              }
                              // fix input in adress because of other syntaxes like comma
                              String normalizedInput = textEditingValue.text
                                  .toLowerCase()
                                  .replaceAll(',', '');
                              return Addresses.allAddresses
                                  .where((String option) {
                                String normalizedOption =
                                    option.toLowerCase().replaceAll(',', '');
                                return normalizedOption
                                    .contains(normalizedInput);
                              }).toList();
                            },
                            fieldViewBuilder: (BuildContext context,
                                TextEditingController
                                    fieldTextEditingController,
                                FocusNode fieldFocusNode,
                                VoidCallback onFieldSubmitted) {
                              return TextField(
                                controller: fieldTextEditingController,
                                focusNode: fieldFocusNode,
                                decoration: const InputDecoration(
                                  labelText: 'Find your Address',
                                  suffixIcon: Icon(Icons.search),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
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
                                    children:
                                        options.map<Widget>((String option) {
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
                            onSelected: (String selection) {
                              setState(
                                () {
                                  _address = selection;
                                },
                              );
                            },
                          ),
                        ),
                          const SizedBox(
                          height: 15),
                        // user type or role input
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: DropdownButton<String>(
                            value: _roleSelection,
                            onChanged: (String? newValue) {
                              setState(() {
                                _roleSelection = newValue;
                              });
                            },
                            items: <String>['Job Hunter', 'Employer']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        // button for submition
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.90,
                          child: CustomButton(
                            buttonText: "Continue",
                            onPressed: () => storeData(),
                          ),
                        ),
                        const SizedBox(
                          height: 400,
                        ),
                      ]),
                    ),
                  ]),
                ),
        ));
  }

  // storing data function
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      role: _roleSelection?.trim() ?? "",
      birthdate: _birthdayController.text.trim(),
      address: _address?.trim() ?? "",
      profilePic: "",
      createdAt: "",
      phoneNumber: "",
      uid: "",
    );

    if (image != null) {
      ap.saveUserDataToFirebase(
        context: context,
        userModel: userModel,
        profilePic: image!,
        onSuccess: () {
          ap.saveUserDataToSP().then((value) {
            ap.setSignIn();
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
          });
        },
      );
    } else {
      showSnackBar(context, "Please upload your profile photo");
    }
  }
}
