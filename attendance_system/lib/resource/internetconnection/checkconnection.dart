//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
//
// class connectioncheck extends StatelessWidget {
//   const connectioncheck({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Connectivity connectivity  = Connectivity();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('CHECK CONNECTION'),
//       ),
//       body: StreamBuilder<ConnectivityResult>(
//         stream:  connectivity.onConnectivityChanged,
//         builder: (_, snapshot){
//         return internnt(widget: Text('CONNECTED'), snapshot: snapshot);
//       },),
//     );
//   }
// }
// class internnt extends StatelessWidget {
//   final AsyncSnapshot<ConnectivityResult> snapshot;
//   final Widget widget;
//   const internnt({Key? key,
//   required this.widget,
//     required this.snapshot
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     switch(snapshot.connectionState){
//       case ConnectionState.active:
//         final state = snapshot.data!;
//         switch(state){
//           case ConnectivityResult.none:
//             return Center(child: Text('not connected'),);
//           default:
//             return widget;
//
//         }
//
//
//         default:
//           return Text('');
//
//     }
//     ;
//   }
// }
//
