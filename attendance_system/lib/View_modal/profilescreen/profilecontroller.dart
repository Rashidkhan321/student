import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart ' as firebase_stroage;

import '../../resource/color.dart';
import '../../resource/component/input_textfield.dart';
import '../../services/session_controller.dart';
import '../../utils/utils.dart';


class profilecontroller with ChangeNotifier {
  final usernamecontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final emailfocus = FocusNode();
  final usernamefocus = FocusNode();
  final phonefocus = FocusNode();
  final addressfocus = FocusNode();

  bool _loading = false;
  bool get loading => _loading;

  setloading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final ref = FirebaseFirestore.instance.collection('user');
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
      notifyListeners();
      uploadprofileimage(context);
    }
  }

  Future pickcamera(BuildContext context) async {
    final cameraimage = await picker.pickImage(source: ImageSource.camera);
    if (cameraimage != null) {
      _image = XFile(cameraimage.path);
      notifyListeners();
      uploadprofileimage(context);
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
    firebase_stroage.Reference stroage = firebase_stroage.FirebaseStorage.instance
        .ref('profileimage' + secssion_controller().uerid.toString());
    firebase_stroage.UploadTask uploadTask =
        stroage.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);
    final url = await stroage.getDownloadURL();
    ref
        .doc(secssion_controller().uerid.toString())
        .update({'profile': url.toString()}).then((value) {
      utls.toast('updated');
      setloading(false);
      _image = null;
    }).onError((error, stackTrace) {
      setloading(false);
      utls.toast(error.toString());
    });
  }




    Future<void> editusername(BuildContext context, String name){
     usernamecontroller.text=name;
    return showDialog(context: context,
        builder: (context){
      return Container(
        margin: EdgeInsets.all(20),
        child: AlertDialog(
          title: Text('updated username ',),
          content: SingleChildScrollView(
            child: Column(

children: [
  textfield(
        mycontroller: usernamecontroller,
        focusNode: usernamefocus,
        fieldSetter: (value){

        },
        keyBoradtype: TextInputType.text,
        obscureText: false,
        hint: 'enter username',
        fieldValidator: (value){

        },
        icon: Icon(Icons.person), label: 'Username',)
],
              ),
            ),

          actions: [
           TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('Cancel')),
            TextButton(onPressed: (){
              ref.doc(secssion_controller().uerid.toString()).update({
                'username': usernamecontroller.text.toString()
              });
              Navigator.pop(context);
        }, child: Text('ok')),
          ],
        ),
      );
        });
    }
  Future<void> phonenumberupdate(BuildContext context, String phone){
    phonecontroller.text=phone;
    return showDialog(context: context,
        builder: (context){
          return Container(
            margin: EdgeInsets.all(20),
            child: AlertDialog(
              title: Text('Updaet Phone ',),
              content: SingleChildScrollView(
                child: Column(

                  children: [
                    textfield(
                        mycontroller: phonecontroller,
                        focusNode: phonefocus,
                        fieldSetter: (value){

                        },
                        keyBoradtype: TextInputType.number,
                        obscureText: false,
                        hint: 'enter phone',
                        fieldValidator: (value){

                        },
                        icon: Icon(Icons.phone), label: 'Phone',)
                  ],
                ),
              ),

              actions: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text('Cancel', style: TextStyle(color: AppColors.alertColor),)),
                TextButton(onPressed: (){
                  ref.doc(secssion_controller().uerid.toString()).update({
                    'phone_number': phonecontroller.text.toString()
                  });
                  Navigator.pop(context);
                }, child: Text('ok')),
              ],
            ),
          );
        });
  }
  Future<void> addressupdate(BuildContext context, String address){
    addresscontroller.text=address;
    return showDialog(context: context,
        builder: (context){
          return Container(
            margin: EdgeInsets.all(20),
            child: AlertDialog(
              title: Text('updated address ',),
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
                        hint: 'enter address',
                        fieldValidator: (value){

                        },
                        icon: Icon(Icons.maps_home_work_outlined), label: 'Address',)
                  ],
                ),
              ),

              actions: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text('Cancel',style: TextStyle(color: AppColors.alertColor),)),
                TextButton(onPressed: (){
                  ref.doc(secssion_controller().uerid.toString()).update({
                    'address': addresscontroller.text.toString()
                  });
                  Navigator.pop(context);
                }, child: Text('ok')),
              ],
            ),
          );
        });
  }

}
