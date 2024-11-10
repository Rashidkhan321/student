import 'package:attendance_system/View_modal/admin%20section/studentDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../resource/color.dart';
import '../../resource/component/imagecustom_code.dart';
import '../../resource/component/round_button.dart';
import '../../services/session_controller.dart';
import '../record/allRwcord.dart';
class Admindashborad extends StatefulWidget {
  const Admindashborad({super.key});

  @override
  State<Admindashborad> createState() => _AdmindashboradState();
}

class _AdmindashboradState extends State<Admindashborad> {
  final refer = FirebaseFirestore.instance.collection('user').snapshots();
  CollectionReference updateuser = FirebaseFirestore.instance.collection('user');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text('All Students'),
  automaticallyImplyLeading: false,
  actions: [
  Roundbutton(title: 'Record', onpress: (){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>allStudent()));

  })

],),
      body:     StreamBuilder<QuerySnapshot>(
        stream: refer,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {

            return Center(child: CircularProgressIndicator());
          }
          else{
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index){
                  {
                    final student = snapshot.data!.docs[index]['userid'].toString();
                    final notification =snapshot.data!.docs[index]['notification'].toString();
                    final message = snapshot.data!.docs[index]['application'].toString();
                    final username = snapshot.data!.docs[index]['username'].toString();

                    return  Card(

                      child: ListTile(

                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>studentDetail(userid: student, username: username,)));
                        },

                        leading:

                        InkWell(

                          child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(),

                              ),
                              child: snapshot.data!.docs[index]['profile'] == "" ? Icon(Icons.person):
                              ClipRRect(
                                  borderRadius:  BorderRadius.circular(50),
                                  child: setprofile_image(imageurl: snapshot.data!.docs[index]['profile'],)
                              )
                          ),
                        ),
                        title:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(snapshot.data!.docs[index]['email'].toString()),
                            notification=='recived'? InkWell(
                                onTap: (){
                                  applicationMessage(context, message,student);
                                },
                                child: Icon(Icons.notification_add_outlined)):Container()
                            // snapshot.data!.docs[index]
                            // [
                            // 'status'] ==
                            //     'online'
                            //     ? Padding(
                            //   padding:
                            //   const EdgeInsets.only(bottom: 18.0),
                            //   child:
                            //   Container(
                            //     height:
                            //     10,
                            //     width:
                            //     10,
                            //     decoration:
                            //     BoxDecoration(
                            //       shape:
                            //       BoxShape.circle,
                            //       color:
                            //       Colors.green,
                            //     ),
                            //   ),
                            // )
                            //     : Container()
                          ],
                        ),
                        subtitle:
                        Text(snapshot.data!.docs[index]['username'].toString())
                      ),


                    );
                  }

                    // CollectionReference updateuser = FirebaseFirestore.instance.collection('user');
                    // updateuser.doc(secssion_controller().uerid.toString()).update({
                    //
                    //   'number':0 ,
                    // });




                    return Container();
                  }




          );
          }


    }
  )

    );
  }
  
  Future<void> applicationMessage(BuildContext context, String message, String id, ){
    CollectionReference updatedata = FirebaseFirestore.instance.collection(
        'user');
    
    return showDialog(context: context,
        builder: (context){
          return Container(
            margin: EdgeInsets.all(20),
            child: AlertDialog(
              title: Center(child: Text('Leave Application ',)),
              content: SingleChildScrollView(
                child: Column(

              children: [
                Container(
                  child: Text(message.toString()),
                )
              ],
                ),
              ),

              actions: [
                TextButton(onPressed: (){
                  updatedata.doc(id).update({

                    'notification':'Rejected',

                  });
                  Navigator.pop(context);
                }, child: Text('Reject',style: TextStyle(color: AppColors.alertColor),)),
                TextButton(onPressed: (){
                  updatedata.doc(id).update({

                    'notification':'Accepted',
                    ' total_leave':FieldValue.increment(1),


                  });
                  Navigator.pop(context);
                }, child: Text('Accept')),
              ],
            ),
          );
        });
  }
}
