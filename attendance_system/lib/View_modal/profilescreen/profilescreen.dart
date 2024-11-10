

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../resource/color.dart';
import '../../resource/component/imagecustom_code.dart';
import '../../resource/component/input_textfield.dart';
import '../../resource/component/round_button.dart';
import '../../services/session_controller.dart';
import '../../utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart ' as firebase_stroage;

import '../Attendance/Attendence_History.dart';



class profilescreen extends StatefulWidget {
  const profilescreen({Key? key}) : super(key: key);

  @override

  State<profilescreen> createState() => _profilescreenState();
}

class _profilescreenState extends State<profilescreen> {
  final serachcontroller = TextEditingController();
  final ref = FirebaseFirestore.instance.collection('user').snapshots();
  CollectionReference updatedata = FirebaseFirestore.instance.collection(
      'user');
  CollectionReference profileinproduct = FirebaseFirestore.instance.collection(
      'itemss');
  final usernamecontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final emailfocus = FocusNode();
  final usernamefocus = FocusNode();
  final phonefocus = FocusNode();
  final addressfocus = FocusNode();

  String serach = "";
  final postdata = FirebaseFirestore.instance.collection('itemss').snapshots();
  final attendence = FirebaseFirestore.instance.collection(secssion_controller().uerid.toString());
  final String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _loading = false;

  bool get loading => _loading;

  setloading(bool value) {
    _loading = value;
  }


  firebase_stroage.FirebaseStorage storage =
      firebase_stroage.FirebaseStorage.instance;
  final picker = ImagePicker();

  XFile? _image;

  XFile? get image => _image;

  Future pickGalleryImage(BuildContext context) async {
    final file =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (file != null) {
      _image = XFile(file.path);
      //  notifyListeners();
      updateUserProfilePicture();
    }
  }

  Future pickcamera(BuildContext context) async {
    final cameraimage = await picker.pickImage(source: ImageSource.camera);
    if (cameraimage != null) {
      _image = XFile(cameraimage.path);
      // notifyListeners();
      updateUserProfilePicture();
    }
  }

  void pickimage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 120,
              width: 80,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      pickcamera(context);
                    },
                    leading: Icon(Icons.camera_alt),
                    title: Text('Camera'),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      pickGalleryImage(context);
                    },
                    leading: Icon(Icons.image),
                    title: Text('Gallrey'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  uploadprofileimage(BuildContext context) async {
    setloading(true);
    //  Reference ref = FirebaseStorage.instance.ref().child('profilepicture').child(FirebaseAuth.instance.currentUser!.uid.toString());
    firebase_stroage.Reference stroage = firebase_stroage.FirebaseStorage
        .instance
        .ref('profileimage' + secssion_controller().uerid.toString());
    firebase_stroage.UploadTask uploadTask =
    stroage.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);
    final url = await stroage.getDownloadURL();
    updatedata
        .doc(secssion_controller().uerid.toString())
        .update({'profile': url.toString()}).then((value) =>
    {
    })
        .
    then((value) {
      utls.toast('updated');
      setloading(false);
      _image = null;
    }).onError((error, stackTrace) {
      setloading(false);
      utls.toast(error.toString());
    });
  }



  Future<void> updateUserProfilePicture() async {
    try {
      setloading(true);
      //  Reference ref = FirebaseStorage.instance.ref().child('profilepicture').child(FirebaseAuth.instance.currentUser!.uid.toString());
      firebase_stroage.Reference stroage = firebase_stroage.FirebaseStorage
          .instance
          .ref('profileimage' + secssion_controller().uerid.toString());
      firebase_stroage.UploadTask uploadTask =
      stroage.putFile(File(image!.path).absolute);

      await Future.value(uploadTask);
      final url = await stroage.getDownloadURL();
      final userReference = FirebaseFirestore.instance.collection('user')
          .doc(secssion_controller().uerid.toString());
      await userReference.update({'profile': url.toString()});


      final userPostsQuerySnapshot = await FirebaseFirestore.instance
          .collection('itemss')
          .where('userid', isEqualTo: secssion_controller().uerid.toString())
          .get();

      // Step 2: Update the profile picture in each of the user's posts
      final userPosts = userPostsQuerySnapshot.docs;
      final batch = FirebaseFirestore.instance.batch();

      for (var post in userPosts) {
        final postReference = FirebaseFirestore.instance.collection('itemss').doc(post.id);
        batch.update(postReference, {'providerimage': url.toString()});
       }


      await batch.commit();

      print('Profile picture propagated to all user posts!');
    } catch (e) {
      print('Error updating profile picture: $e');
    }
  }

  // final datreff = FirebaseDatabase.instance.ref('items').child('product');

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50,),
         StreamBuilder<QuerySnapshot>(
          stream: ref,
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text('ERROR');
            } else {
              return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final user =
                    snapshot.data!.docs[index]['userid'].toString();
                    if(user==secssion_controller().uerid.toString()){
                      return Column(
                        children: [

                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Center(
                                  child: Container(
                                    height: 130,
                                    width: 130,
                                    decoration: BoxDecoration(

                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.black,
                                        )
                                    ),

                                    child: ClipRRect(
                                        borderRadius: BorderRadius
                                            .circular(100),
                                        child: image == null ?

                                        snapshot.data!
                                            .docs[index]['profile'] ==
                                            "" ? Icon(Icons.person) :
                                        setprofile_image(
                                          imageurl: snapshot.data
                                          !.docs[index]['profile'],) :
                                        Image.file(
                                            fit: BoxFit.fill,
                                            File(image!.path).absolute)
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              InkWell(
                                onTap: () {
                                  pickimage(context);
                                },
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.black,
                                  child: Icon(
                                    Icons.add, color: Colors.white,
                                    size: 10,),
                                ),
                              )
                            ],
                          ),





                        ],
                      );
                    }
                    else{
                      return Container();
                    }

                    //final id =snapshot.data!.docs[index]['id'].toString();


                  });
            }
          }


      ),
          SizedBox(height: 50,),




          Roundbutton(title: 'Mark Attendance', onpress: ()async{
            DocumentSnapshot attendanceDoc
            = await _firestore.collection(secssion_controller().uerid.toString()).doc(formattedDate).get();

            if (attendanceDoc.exists) {
            utls.toast('Attendance already marked for today');
              return;
            }
            attendence.doc(formattedDate).set({
              'status': 'Present', 'timestamp': formattedDate
            }).then((value) {
              utls.toast('Attendance Marked Successfully');
              updatedata.doc(secssion_controller().uerid.toString()).update({
                'total_attendence': FieldValue.increment(1)

              });
            });

          }),
          SizedBox(height: 50,),
        Roundbutton(title: 'View Attendance History', onpress: (){
          Navigator.push(context, MaterialPageRoute(builder: (_) => AttendanceHistory()));


        }),
          SizedBox(height: 50,),
          Roundbutton(title: 'Leave Application', onpress: (){

          //  Navigator.push(context, MaterialPageRoute(builder: (_) => AttendanceHistory()));
            addressupdate(context,'');
           // updatedata.doc(secssion_controller().uerid.toString()).update({
           //    'notification': 'recive',
           //
           //  });


          }),




        ],
      ),


    );

  }
  Future<void> addressupdate(BuildContext context, String address){
    addresscontroller.text=address;
    return showDialog(context: context,
        builder: (context){
          return Container(
            margin: EdgeInsets.all(20),
            child: AlertDialog(
              title: Center(child: Text('Leave Application',)),
              content: SingleChildScrollView(
                child: Column(

                  children: [
                    textfield(
                      mycontroller: addresscontroller,
                      focusNode: addressfocus,
                      fieldSetter: (value){

                      },
                      keyBoradtype: TextInputType.text,
                      obscureText: false,
                      hint: 'Application',
                      fieldValidator: (value){

                      },
                      icon: Icon(Icons.maps_home_work_outlined), label: 'application',)
                  ],
                ),
              ),

              actions: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text('Cancel',style: TextStyle(color: AppColors.alertColor),)),
                TextButton(onPressed: (){
                  updatedata.doc(secssion_controller().uerid.toString()).update({
                    'application': addresscontroller.text.toString(),
                    'notification':'recived',

                  });
                  Navigator.pop(context);
                }, child: Text('ok')),

              ],
            ),
          );
        });
  }



// to update the user personal data
}



