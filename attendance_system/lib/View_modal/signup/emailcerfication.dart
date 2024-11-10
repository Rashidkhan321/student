import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
 class homescreen extends StatefulWidget {
   const homescreen({super.key});

   @override
   State<homescreen> createState() => _homescreenState();
 }

 class _homescreenState extends State<homescreen> {
   Future<void> addUser(String name, int age) async {
     try {
       CollectionReference users = FirebaseFirestore.instance.collection('users');
       await users.add({
         'name': name,
         'age': age,
       });
       print("User Added");
     } catch (e) {
       print("Failed to add user: $e");
     }
   }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(title: Text("Firestore Example")),
       body: Center(
         child: ElevatedButton(
           onPressed: () {
             addUser("John Doe", 25);
           },
           child: Text("Add User to Firestore"),
         ),
       ),

     );
   }
 }





// import 'dart:async';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebasenotification/res/component/round_button.dart';
// import 'package:firebasenotification/utils/utils.dart';
// import 'package:firebasenotification/view/dashborad/dashborad_screeen.dart';
// import 'package:firebasenotification/view/login/login_screen.dart';
// import 'package:firebasenotification/view/signup/sign_up_screen.dart';
// import 'package:firebasenotification/view/signup/signup_controller/signup_controller.dart';
// import 'package:flutter/material.dart';
//
// import '../../services/session_controller.dart';
// import '../../utils/routes/route_name.dart';
// class emaivefication extends StatefulWidget {
//
//   const emaivefication({Key? key,
//
//   }) : super(key: key);
//
//   @override
//   State<emaivefication> createState() => _emaiveficationState();
// }
//
// class _emaiveficationState extends State<emaivefication> {
//
//   final auth = FirebaseAuth.instance;
//   late Timer timer;
//   late User user;
//   void initState(){
//     user = auth.currentUser!;
//     user.sendEmailVerification();
//     timer= Timer.periodic(Duration(seconds: 10), (timer) {
//       emailverfied();
//
//     });
//     super.initState();
//
//
//   }
//   void dispose(){
//
//     timer.cancel();
//     super.dispose();
// }
//   Future<void> emailverfied() async{
//     user = auth.currentUser!;
//     await user.reload();
//     if(user.emailVerified){
//       timer.cancel();
//
//       //rashhidkhan321@gmail.com
//     }
//     else{
//       timer.cancel();
//       utls.toast('click on resend email');
//     }
//
//   }
//
//   Future<void> delette()async{
//     user = auth.currentUser!;
//     if (user != null) {
//
//       try {
//         await user!.delete();
//         print('COUNT DEleded');
//         // Account deletion successful
//         // Navigate to a different screen or perform any other action
//       } catch (e) {
//         // Handle errors while deleting the account
//         print('Error: $e');
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return
//
//
//       Scaffold(
//
//           body:
//               WillPopScope(
//                 onWillPop:  () async {
//
//
//                   CollectionReference delet = FirebaseFirestore.instance.collection('user');
//                   delet.doc(secssion_controller().uerid.toString()).delete().then((value) => {
//                     delette()
//                   });
//
//                   return true;
//                   // Handle the back button press here
//                   // Return true to allow the back navigation, or false to block it
//                   // For example, you can show a confirmation dialog and return false to block the back navigation.
//
//                 },
//               child:
//           SingleChildScrollView(
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(28.0),
//                 child: Column(
//
//
//                   children: [
//                     SizedBox(height: 90,),
//                     Icon(Icons.email_outlined,size: 100,),
//                     Text('Verify your email address', style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold
//                     ), ),
//                     SizedBox(height: 20,),
//                     Align(
//                       alignment: Alignment.topCenter,
//                       child: Text('We have just send email verification link on your email.'
//                           ' please check email and click on that link to verify your Email address',textAlign: TextAlign.center, ),
//                     ) ,
//                     SizedBox(height: 20,),
//
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Center(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text('If email not recive',
//                             ),
//                             TextButton(
//                                 onPressed: (){
//
//                                   final    user = auth.currentUser;
//                                   user?.sendEmailVerification();
//                                   timer= Timer.periodic(Duration(seconds: 10), (timer) {
//                                     timer.cancel();
//                                     utls.toast('vefied');
//
//                                     emailverfied();
//
//                                   });
//                                   print(user?.email);
//
//                                 }, child: Text('Resend Email', style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.blue
//
//
//                             ),)),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 10,),
//
//                     SizedBox(height: 10,),
//                     Row(
//                       children: [
//                         Roundbutton(
//                           title: 'Go Back to SignUP', onpress: (){
//                           CollectionReference delet = FirebaseFirestore.instance.collection('user');
//                           delet.doc(secssion_controller().uerid.toString()).delete().then((value) => {
//                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>signupscreen()))
//
//                           }).then((value) => {
//                             delette()
//                           });
//
//
//
//                         },),
//                         Container(width: MediaQuery.of(context).size.width*0.3,
//                           child: Roundbutton(title: 'Login', onpress: (){
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>loginscreen()));
//                           }),
//                         )
//
//                       ],
//                     )
//
//                   ],
//                 ),
//               ),
//             ),
//           )
//       ),);
//
//
//
//   }
// }
