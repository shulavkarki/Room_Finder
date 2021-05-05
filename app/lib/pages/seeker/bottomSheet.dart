// import 'package:app/shared/globals.dart';
// import 'package:flutter/material.dart';
// import 'package:bottom_sheet/bottom_sheet.dart';

// void _bottomSheet(BuildContext context, maproom) {
//  Future<void> future = showStickyFlexibleBottomSheet<void>(
//       minHeight: 0,
//       initHeight: 0.5,
//       maxHeight: 1,
//       headerHeight: 200,
//       context: context,
//       headerBuilder: (context, offset) {
//         return AnimatedContainer(
//             duration: const Duration(milliseconds: 300),
//             width: double.infinity,
//             height: 200,
//             decoration: BoxDecoration(
//               color: Global.theme1,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(offset == 0.8 ? 0 : 40),
//                 topRight: Radius.circular(offset == 0.8 ? 0 : 40),
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Center(
//                     // child: NetworkImage(
//                     //   "${maproom['img'][0]}",
//                     // ),
//                     child: Hero(
//                       tag: "${maproom['roomId']}",
//                       child: FadeInImage(
//                         fit: BoxFit.fill,
//                         placeholder: AssetImage('assets/load.jpg'),
//                         image: NetworkImage(
//                           "${maproom['img'][0]}",
//                         ),
//                       ),
//                       //   child: ExtendedNetworkImageProvider(
//                       //       roommap['img'][0].tostring()),
//                       // ),
//                       // style: Theme.of(context).textTheme.headline4,
//                     ),
//                   ),
//                   // ),
//                 )
//               ],
//             ));
//       },
//       builder: (BuildContext context, double offset) {
//         return SliverChildListDelegate(
//           <Widget>[
//             Text('something'),
//           ],
//         );
//       },
//       anchors: [0, 0.5, 1],
//     );
// }
