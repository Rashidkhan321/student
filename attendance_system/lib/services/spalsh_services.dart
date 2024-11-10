//
// import 'dart:async';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebasenotification/services/session_controller.dart';
// import 'package:firebasenotification/view/announcment/announcemnet.dart';
// import 'package:firebasenotification/view/dashborad/dashborad_screeen.dart';
// import 'package:flutter/material.dart';
//
//
// import '../utils/routes/route_name.dart';
// import '../view/signup/emailcerfication.dart';
// class splashservices{
//
//   final auth = FirebaseAuth.instance;
//   Future<void> islogin(BuildContext context) async {
//     final user = auth.currentUser;
//     if(user!=null){
//
//       if(user!.emailVerified){
//
//
//         secssion_controller().uerid =user.uid.toString();
//         // Get a reference to the Firestore instance
//         FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//         // Get the reference to the collection you want to check
//         final reff = FirebaseFirestore.instance.collection('announc');
//
//
//         // Use the get() method to retrieve data from the collection
//         var collectionSnapshot = await reff.limit(1).get();
//
//         // Check if the collectionSnapshot has any documents
//         if (collectionSnapshot.docs.isNotEmpty) {
//           Timer(
//
//
//               Duration(seconds: 2 ), ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>announce()))
//
//           );
//         } else {
//           Timer(
//
//
//               Duration(seconds: 2 ), ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
//               dashborad()
//           ))
//           );
//         }
//
//       }
//       else{
//
//
//         // Get the reference to the collection you want to check
//         final reff = FirebaseFirestore.instance.collection('announc');
//
//
//         // Use the get() method to retrieve data from the collection
//         var collectionSnapshot = await reff.limit(1).get();
//
//         // Check if the collectionSnapshot has any documents
//         if (collectionSnapshot.docs.isNotEmpty) {
//           Timer(
//               Duration(seconds: 2 ), ()=> Navigator.
//         pushReplacement(context, MaterialPageRoute(builder: (context)=>announce())) );
//         } else {
//           Timer(
//               Duration(seconds: 2 ), ()=> Navigator.pushReplacementNamed(context,
//               RouteName.loginview) );
//         }
//
//       }
//
//
//     }
//     else{
//       final reff = FirebaseFirestore.instance.collection('announc');
//
//
//       // Use the get() method to retrieve data from the collection
//       var collectionSnapshot = await reff.limit(1).get();
//
//       // Check if the collectionSnapshot has any documents
//       if (collectionSnapshot.docs.isNotEmpty) {
//         Timer(
//             Duration(seconds: 2 ), ()=> Navigator.
//         pushReplacement(context, MaterialPageRoute(builder: (context)=>announce())) );
//       } else {
//         Timer(
//             Duration(seconds: 2 ), ()=> Navigator.pushReplacementNamed(context,
//             RouteName.loginview) );
//       }
//     }
//
//   }
//
// }