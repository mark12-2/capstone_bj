import 'package:capstone/default_screens/home.dart';
import 'package:capstone/dropdowns/types_of_jobs.dart';
import 'package:capstone/model/post_model.dart';
import 'package:capstone/provider/post_provider.dart';
import 'package:capstone/styles/custom_theme.dart';
import 'package:capstone/styles/responsive_utils.dart';
import 'package:capstone/styles/textstyle.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  // firestore storage access
  final PostProvider createdPost = PostProvider();
  // text controllers
  final _descriptionController = TextEditingController();
  final _typeController = TextEditingController();
  final _rateController = TextEditingController();

  //posting
  void addPost() {
    if (_descriptionController.text.isNotEmpty &&
        _typeController.text.isNotEmpty &&
        _rateController.text.isNotEmpty) {
      String description = _descriptionController.text;
      String type = _typeController.text;
      String rate = _rateController.text;
      // add the details
      var postDetails = Post(
        postDescription: description,
        typeOfJob: type,
        yourRate: rate,
      );
      
      createdPost.addPost(postDetails);
    }
  }

  final _descriptionFocusNode = FocusNode();
  final _typeFocusNode = FocusNode();
  final _rateFocusNode = FocusNode();

  final bool _isDescriptionFocused = false;
  final bool _isRateFocused = false;
  String? _typeSelection;

  @override
  void dispose() {
    _descriptionController.dispose();
    _typeController.dispose();
    _rateController.dispose();
    _descriptionFocusNode.dispose();
    _typeFocusNode.dispose();
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
              'Create a Post',
              style: CustomTextStyle.semiBoldText.copyWith(
                color: Colors.black,
                fontSize: responsiveSize(context, 0.07),
              ),
            ),
            const SizedBox(height: 30),
        
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
                  onPressed: addPost,
                  child: const Text('Post'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _descriptionController.clear();
                    _typeController.clear();
                    _rateController.clear();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
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
