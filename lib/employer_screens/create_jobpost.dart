import 'package:capstone/default_screens/home.dart';
import 'package:capstone/dropdowns/types_of_jobs.dart';
import 'package:capstone/model/jobpost_model.dart';
import 'package:capstone/provider/jobpost_provider.dart';
import 'package:capstone/styles/custom_theme.dart';
import 'package:capstone/styles/responsive_utils.dart';
import 'package:capstone/styles/textstyle.dart';
import 'package:flutter/material.dart';

class CreateJobPostPage extends StatefulWidget {
  const CreateJobPostPage({super.key});

  @override
  State<CreateJobPostPage> createState() => _CreateJobPostPageState();
}

class _CreateJobPostPageState extends State<CreateJobPostPage> {
  // firestore storage access
  final JobPostProvider jobpostdetails = JobPostProvider();
  // text controllers
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _typeController = TextEditingController();
  final _locationController = TextEditingController();
  final _rateController = TextEditingController();

  //post job post
  void addJobPost() {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _typeController.text.isNotEmpty &&
        _locationController.text.isNotEmpty &&
        _rateController.text.isNotEmpty) {
      String title = _titleController.text;
      String description = _descriptionController.text;
      String type = _typeController.text;
      String location = _locationController.text;
      String rate = _rateController.text;
      // add the details
      var jobPost = JobPost(
        title: title,
        description: description,
        type: type,
        location: location,
        rate: rate,
      );

      // Now pass the JobPost object to the addDetail method
      jobpostdetails.addDetail(jobPost);
    }
  }

  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _typeFocusNode = FocusNode();
  final _locationFocusNode = FocusNode();
  final _rateFocusNode = FocusNode();

  final bool _isTitleFocused = false;
  final bool _isDescriptionFocused = false;
  final bool _isLocationFocused = false;
  final bool _isRateFocused = false;
  String? _typeSelection;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _typeController.dispose();
    _locationController.dispose();
    _rateController.dispose();
    _titleFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _typeFocusNode.dispose();
    _locationFocusNode.dispose();
    _rateFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Create Job Post',
              style: CustomTextStyle.semiBoldText.copyWith(
                color: Colors.black,
                fontSize: responsiveSize(context, 0.07),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _titleController,
              focusNode: _titleFocusNode,
              decoration: customInputDecoration('Title'),
            ),
            if (_isTitleFocused)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  'Enter the title of your post.',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            const SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              focusNode: _descriptionFocusNode,
              decoration: customInputDecoration('Description'),
            ),
            if (_isDescriptionFocused)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  'Provide a detailed description.',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            const SizedBox(height: 20),
            TextField(
              controller: _typeController,
              focusNode: _typeFocusNode,
              decoration: customInputDecoration('Type of Job'),
            ),
            if (_typeFocusNode.hasFocus)
              DropdownButton<String>(
                value: _typeSelection,
                onChanged: (String? newValue) {
                  setState(() {
                    _typeSelection = newValue;
                  });
                },
                items: TypesOfJobs.allJobTypes
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            const SizedBox(height: 20),

            // add leaflet for job location (mapping feature)
            TextField(
              controller: _locationController,
              focusNode: _locationFocusNode,
              decoration: customInputDecoration('Location'),
            ),
            if (_isLocationFocused)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  'Enter the location.',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            const SizedBox(height: 20),

            TextField(
              controller: _rateController,
              focusNode: _rateFocusNode,
              decoration: customInputDecoration('Rate'),
              // keyboardType: TextInputType.number,
            ),
            if (_isRateFocused)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  'Enter the rate. Ex. 300 per hour/day',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: addJobPost,
                  child: const Text('Post'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _titleController.clear();
                    _descriptionController.clear();
                    _typeController.clear();
                    _locationController.clear();
                    _rateController.clear();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const HomePage()));
                  },
                  child: const Text('Cancel'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
