
import 'package:attendance_system/services/session_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:http/http.dart' as http;

import '../../resource/component/round_button.dart';
class AttendanceHistory extends StatefulWidget {
  // final userid, username;

  const AttendanceHistory({super.key,});

  @override
  State<AttendanceHistory> createState() => _AttendanceHistoryState();
}

class _AttendanceHistoryState extends State<AttendanceHistory> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final postdata = FirebaseFirestore.instance.collection(secssion_controller().uerid.toString()).snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('Attendance History',),
      automaticallyImplyLeading: false,

      ),
      body:  StreamBuilder<QuerySnapshot>(
          stream: postdata,
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
                    Card(
                      child: ListTile(

                        title: Text(snapshot.data!.docs[index]['status'].toString()),
                        subtitle: Text(snapshot.data!.docs[index]['timestamp'].toString()),
                        leading: status =='Present'?
                        Icon(Icons.check,color:  Colors.green):Icon(Icons.cancel_rounded, color: Colors.red,),
                      ),
                    );
                },);
            }

          })
    );
  }
}


class onestudent extends StatefulWidget {
  final userid, username ;




  const onestudent({Key? key,
    required  this.userid,
    required this.username

  }) : super(key: key);

  @override
  State<onestudent> createState() => _onestudentState();
}

class _onestudentState extends State<onestudent> {
  bool _loading = false;
  final String text='2023-07-17 ';


  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body:
      Column(

        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Container(height: 50,
              width: double.infinity,
              child: Center(child: Text(widget.username)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red
              ),),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection(widget.userid).snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              else{
                return
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (

                          BuildContext context, int index) {


                        return   Column(
                          children: [

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Table(
                                border: TableBorder.all(), // Add border styling if desired
                                children: [



                                  TableRow(
                                    children: [

                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('Status'),
                                        ),

                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(snapshot.data!.docs[index]['status'].toString()),
                                        ),

                                      ),



                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('DATE'),
                                        ),

                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(snapshot.data!.docs[index]['timestamp'].toString()),
                                        ),

                                      ),


                                    ],
                                  ),






                                ],
                              ),
                            ),

                            SizedBox( height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child:  Roundbutton(
                                loading: _loading,

                                onpress: ()async{
                                  setState(() {
                                    _loading = true;
                                  });

                                  Future<void> savePdfToFile(pw.Document pdf) async {
                                    final pdfBytes = await pdf.save();

                                    Printing.layoutPdf(
                                      onLayout: (PdfPageFormat format) async => pdfBytes,
                                    );
                                  }
                                  Future<void> generatePdf(PdfPageFormat pageFormat,) async {
                                    final pdf = pw.Document();
                                    // Uint8List imageData = Uint8List.fromList([snapshot.data!.docs[index]['productimage']]);


                                    pdf.addPage(
                                      pw.Page(
                                        build: (pw.Context context) {
                                          return pw.Center(

                                              child: pw.Column(
                                                  children: [
                                                    pw.Table.fromTextArray(
                                                      headers: ['Attributes', 'Details', ],
                                                      data: [
                                                        ['Status', snapshot.data!.docs[index]['status'] ],
                                                        ['Date', snapshot.data!.docs[index]['timestamp']],


                                                      ],
                                                    ),
                                                    // pw.Column(
                                                    //     mainAxisAlignment: pw.MainAxisAlignment.start,
                                                    //     crossAxisAlignment:pw. CrossAxisAlignment.start,
                                                    //     children: [
                                                    //       pw.SizedBox(height: 40),
                                                    //       pw.Text('Student Name'),
                                                    //       pw.Text(snapshot.data!.docs[index]['username'].toString() ),
                                                    //       pw.SizedBox(height: 40),
                                                    //       pw.Text('Student Address'),
                                                    //       pw.Text( snapshot.data!.docs[index]['address'].toString()),
                                                    //       pw.SizedBox(height: 40),
                                                    //       pw.Text('Student Email'),
                                                    //       pw.Text(snapshot.data!.docs[index]['email'].toString() ),
                                                    //       pw.SizedBox(height: 40),
                                                    //       pw.Text('Total_attendence',),
                                                    //       pw.Text( snapshot.data!.docs[index]['total_attendence'].toString()),
                                                    //       pw.SizedBox(height: 40),
                                                    //       pw.Text('Total_absents',),
                                                    //       pw.Text(snapshot.data!.docs[index]['total_absents'].toString(),),
                                                    //       pw.SizedBox(height: 40),
                                                    //       pw.Text('Total_leave'),
                                                    //
                                                    //       pw.Text(snapshot.data!.docs[index]['total_leave'].toString(),
                                                    //           ),
                                                    //
                                                    //
                                                    //     ]
                                                    // ),


                                                  ]
                                              )
                                          );
                                        },
                                      ),
                                    );

                                    await savePdfToFile(pdf).then((value) => {

                                      setState(() {
                                        _loading = false;
                                      })
                                    });
                                  }
                                  // final pdf = pw.Document();
                                  await generatePdf(PdfPageFormat.a4,);



                                }, title: 'Download',),
                            )
                          ],
                        );




                      },

                    ),
                  );
              }









            },

          ),




        ],
      ),
    );
  }
}

