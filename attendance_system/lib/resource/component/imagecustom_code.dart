
import 'package:flutter/material.dart';
class setprofile_image extends StatelessWidget {

  final imageurl;

  const setprofile_image({Key? key,
    required this.imageurl,

  }) : super(key: key,

  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
      MediaQuery.of(context).size.height *
          0.3,
      width: MediaQuery.of(context).size.width *
          0.9,
      child: Image(
        fit: BoxFit.fill,
        image: NetworkImage(imageurl),
        loadingBuilder: ( BuildContext context, Widget child, ImageChunkEvent? loading ){

          if(loading==null)
            return child;
          return Container(
            height:
            MediaQuery.of(context).size.height *
                0.3,
            width: MediaQuery.of(context).size.width *
                0.9,
            decoration: BoxDecoration(
                color: Colors.green.shade200
            ),
            child: Center(


                child: CircularProgressIndicator(color: Colors.black,)),
          );
        },
        errorBuilder: (contex, exception, stack){
          return Container(
            decoration: BoxDecoration(
              //color: Colors.green.shade200
            ),

            height:
            MediaQuery.of(context).size.height *
                0.3,
            width: MediaQuery.of(context).size.width *
                0.9,
            child:
            Icon(Icons.person),
          );
        },

      ),
    );
  }
}

class Badge extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return   Stack(
      children: [
        Positioned(
          right: 0,
          top: 0,
          child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),

              ),
              constraints: BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child:
              Icon(Icons.home_outlined)
          ),
        ),



        Positioned(
          right: 0,
          top: 0,
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),

            ),
            constraints: BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child:
            Expanded(
              child: ListView.builder(
                //  physics: NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return  Column(
                      children: [
                        Text('2')
                      ],
                    );

                  }





              ),

            ),
          ),
        )
      ],
    );
  }
}