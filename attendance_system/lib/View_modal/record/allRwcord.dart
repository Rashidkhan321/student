

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:http/http.dart' as http;

import '../../resource/component/round_button.dart';

class allStudent extends StatefulWidget {




  const allStudent({Key? key,
  }) : super(key: key);

  @override
  State<allStudent> createState() => _allStudentState();
}

class _allStudentState extends State<allStudent> {
  bool _loading = false;

  final userr=FirebaseFirestore.instance.collection('user').snapshots();

  Widget build(BuildContext context) {
    final String transport= 'Self transport';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body:
      Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: userr,
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
                        String grade='';
             final total =           snapshot.data!.docs[index]['total_attendence'];
             if(total>=26){
               grade ='A';


             }
             else if((total>=18)&&(total<=15))
               {
                 grade ='B';
               }
             else if((total>=10)&&(total<=17))
             {
               grade ='C';
             } else if((total>=0)&&(total<=9))
             {
               grade ='D';
             }


                        return   Column(
                          children: [
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 18.0),
  child: Container(height: 50,
  width: double.infinity,
  child: Center(child: Text(snapshot.data!.docs[index]['username'].toString())),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.red
  ),),
),
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
                                          child: Text('Student Email'),
                                        ),

                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(snapshot.data!.docs[index]['email'].toString()),
                                        ),

                                      ),


                                    ],
                                  ),
                                  TableRow(
                                    children: [

                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('Student Address'),
                                        ),

                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(snapshot.data!.docs[index]['address'].toString()),
                                        ),

                                      ),



                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('total_attendence'),
                                        ),

                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(total.toString()),
                                        ),

                                      ),


                                    ],
                                  ),

                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('total_absents'),
                                        ),

                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(snapshot.data!.docs[index]['total_absents'].toString()),
                                        ),

                                      ),


                                    ],
                                  ),

                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('total_leave'),
                                        ),

                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(snapshot.data!.docs[index]['total_leave'].toString()),
                                        ),

                                      ),


                                    ],
                                  ),

                                  TableRow(
                                    children: [

                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('Attendence Grade'),
                                        ),

                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(grade.toString()),
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
                                                        ['Name', snapshot.data!.docs[index]['username'] ],
                                                        ['Email', snapshot.data!.docs[index]['email']],
                                                        ['Address', snapshot.data!.docs[index]['address']],
                                                        ['total_attendence',  snapshot.data!.docs[index]['total_attendence'] ],
                                                        ['total_absents',  snapshot.data!.docs[index]['total_absents'] ],
                                                        ['total_leave',  snapshot.data!.docs[index]['total_leave'] ],
                                                       [ 'Attendence Grade',  grade]

                                                      ],
                                                    ),

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



                                }, title: 'print',),
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

