
import 'package:attendance_system/resource/component/round_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../resource/component/input_textfield.dart';
import '../../services/session_controller.dart';
import '../Attendance/Attendence_History.dart';
class studentDetail extends StatefulWidget {
  final userid, username;
  const studentDetail({super.key, required this.userid, required this.username});

  @override
  State<studentDetail> createState() => _studentDetailState();
}

class _studentDetailState extends State<studentDetail> {
  final FirebaseAuth _auth = FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(title: Text('Attendance History'),
          automaticallyImplyLeading: false,
          actions: [

            Roundbutton(title: 'Record', onpress: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>onestudent(userid: widget.userid , username: widget.username)));

            })
          ],
        ),
        body:  StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection(widget.userid.toString()).snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              else if (snapshot.hasError) {
                return Text('ERROR');
              }
              else if (!snapshot.hasData) {
                return Text('ERROR no data');
              }
              else {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ( context,  index) {
                    final status = snapshot.data!.docs[index]['status'].toString();
                    return
                      InkWell(
                        onTap: (){
                          updateStatus(context,snapshot.data!.docs[index]['status'],snapshot.data!.docs[index]['timestamp']);
                        },
                        child: Card(
                          child: ListTile(

                            title: Text(snapshot.data!.docs[index]['status'].toString()),
                            subtitle: Text(snapshot.data!.docs[index]['timestamp'].toString()),
                            leading: status =='Present'?
                            Icon(Icons.check,color:  Colors.green):Icon(Icons.cancel_rounded, color: Colors.red,),
                          ),
                        ),
                      );
                  },);
              }

            })
    );
  }

  final statuscontroller = TextEditingController();
  final statusfocus = FocusNode();
  Future<void> updateStatus(BuildContext context, String status, String date){
    CollectionReference updataststus = FirebaseFirestore.instance.collection(widget.userid.toString());
    statuscontroller.text=status;
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
                      mycontroller: statuscontroller,
                      focusNode: statusfocus,
                      fieldSetter: (value){

                      },
                      keyBoradtype: TextInputType.text,
                      obscureText: false,
                      hint: 'enter status',
                      fieldValidator: (value){
                      },
                      icon: Icon(Icons.app_registration), label: 'Status',)
                  ],
                ),
              ),

              actions: [
                TextButton(onPressed: (){

                  updataststus.doc(date.toString()).delete();
                  Navigator.pop(context);
                }, child: Text('Delete', style:  TextStyle(color: Colors.red),)),

                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text('Cancel')),
                TextButton(onPressed: (){
                  updataststus.doc(date.toString()).update({
                    'status': statuscontroller.text.toString()
                  });
                  Navigator.pop(context);
                }, child: Text('Ok')),
                 ],
            ),
          );
        });
  }
}
