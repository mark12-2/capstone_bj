// import 'package:flutter/material.dart';

// class CustomSliverAppBar extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//     return SliverAppBar(
//      // title: Text('hahahha'),
//       floating: true,
//       pinned: true,
//       expandedHeight: 200.0,
//       flexibleSpace: FlexibleSpaceBar(),
//       leading: GestureDetector(
//         onTap: () {
//           // Scroll to the top of the content
//           final ScrollableState scrollableState = Scrollable.of(context);
//           scrollableState.position.animateTo(
//             0.0,
//             duration: Duration(milliseconds: 500),
//             curve: Curves.easeOut,
//           );
//         },
//         child: Padding(
//           padding: EdgeInsets.only(left: 3),
//           child: Image.asset(
//             'assets/images/bluejobs.png',
//             width: 100,
//             height: 100,
//           ),
//         ),
//       ),
//     );

//  }
// }

import 'package:flutter/material.dart';
import 'package:capstone/screensforhome/notification.dart';

class CustomSliverAppBar extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
    return SliverAppBar(
      //title: Text('hahahha'),
      floating: true,
      pinned: true,
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(),
      leading: GestureDetector(
        onTap: () {
          // Scroll to the top of the content
          final ScrollableState scrollableState = Scrollable.of(context);
          scrollableState.position.animateTo(
            0.0,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        },
        child: Padding(
          padding: EdgeInsets.only(left: 3),
          child: Image.asset(
            'assets/images/bluejobs.png',
            width: 100,
            height: 100,
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.notifications), // Use the notifications icon
          onPressed: () {
            // Navigate to the notifications page
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => NotificationsPage()),
            );
          },
        ),
      ],
    );
 }
}