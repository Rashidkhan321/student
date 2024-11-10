import 'package:attendance_system/View_modal/admin%20section/AdminDashborad.dart';
import 'package:attendance_system/View_modal/signup/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../resource/component/input_textfield.dart';
import '../../resource/component/round_button.dart';
import 'logincontroller.dart';


class loginscreen extends StatefulWidget {
  const loginscreen({Key? key}) : super(key: key);

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  final form = GlobalKey<FormState>();
  final emaicontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  final emailfocus = FocusNode();
  final passwordf = FocusNode();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height*1;
    return Scaffold(
      body: SafeArea(

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              Text('Welcome to the app',
                style: TextStyle(fontWeight:
                FontWeight.w800, fontSize: 20),),

              SizedBox(height: height* .1,),
              Form( key:  form,
                  child: Column(
                    children: [

                      textfield(
                          icon: Icon(Icons.email_outlined, color: Colors.black,),

                          mycontroller: emaicontroller,
                          focusNode: emailfocus,
                          fieldSetter: (value){

                          },
                          keyBoradtype: TextInputType.emailAddress,
                          obscureText: false,
                          hint: "Email",
                          fieldValidator: (value){
                            return value.isEmpty ? 'enter email': null;
                          }, label: 'Email',

                      ),
                      SizedBox(height: height*.010,),

                      textfield(
                          icon: Icon(Icons.lock_open, color: Colors.black,),

                          mycontroller: passwordcontroller,
                         // focusNode:passwordf,
                          fieldSetter: (value){

                          },
                          keyBoradtype: TextInputType.visiblePassword,
                          obscureText: true,
                          hint: "Password",
                          fieldValidator: (value){
                            return value.isEmpty ? 'enter password': null;
                          }, focusNode: passwordf, label: 'Password',

                      ),
                    ],
                  )
              ),

              SizedBox(height: 20,),
   Column(
     children: [
       Padding(
         padding: const EdgeInsets.symmetric(horizontal: 8.0),
         child: Align(
           alignment: Alignment.bottomRight,
           child: TextButton(onPressed: (){
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>forgotpasswprd ()));
           }, child: const Text('Forgot Password',style: TextStyle(
               color: Colors.black
           ),)),
         ),
       ),
       ChangeNotifierProvider(create: (_)=> LoginController(),
         child:  Consumer< LoginController>(builder: (context, provider, child)
             {
               return              Roundbutton(title: 'Login', onpress: () {
                 if(form.currentState!.validate()){
                   if((emaicontroller.text=='admin')&&(passwordcontroller.text=='123456')){
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Admindashborad()));
                   }
                   else{
                     provider.login(context,  emaicontroller.text.toString(), passwordcontroller.text.toString());
                   }

                 }
               },
                 loading: provider.loading,);
             }
         ),
       ),
     ],
   ),



                 Row( mainAxisAlignment:  MainAxisAlignment.center,
                  children: [ Text('Create new account'),
                    TextButton(onPressed: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>signupscreen()));
                    }, child: const Text('SignUp')),
                  ],
                ),




            ],
          ),
        ),
      ),
    );
  }

}


