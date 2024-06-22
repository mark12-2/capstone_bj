// import 'package:flutter/material.dart';
// import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

// class Mapping extends StatefulWidget {
//   const Mapping({super.key});

//   @override
//   State<Mapping> createState() => _MappingState();
// }

// class _MappingState extends State<Mapping> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sample map'),
//       ),
//       body: Container(
//         child: InkWell(
//           child: Text('Location Address'),
//           onTap: () {
//             _showModal(context);
//           },
//         ),
//       ),
//     );
//   }
// }

// void _showModal(BuildContext context) {
//   showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Container(
//           height: 200,
//           child: OpenStreetMapSearchAndPick(
//         buttonColor: Colors.blue,
//         buttonText: 'Set Current Location',
//         onPicked: (pickedData) {
//         }),
//         );
//       });
// }



// // child: OpenStreetMapSearchAndPick(
// //           buttonColor: Colors.blue,
// //           buttonText: 'Set Location',
// //            onPicked: (pickedData) {},
// //           ),