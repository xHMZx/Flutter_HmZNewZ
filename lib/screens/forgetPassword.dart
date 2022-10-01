import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  Widget buildEmail(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0,),
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),

        ),
        child: TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email_rounded,
                color: Colors.blue.shade800,
              ),
              hintText: 'E-mail'
          ),
        ),
      ),
    );
  }

  Widget buildResetButton(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: InkWell(
        onTap: () {
          setState(() {
            print("Reset Link Pressed");
          });

        },
        child: Container(

          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.blue.shade900,
              borderRadius: BorderRadius.circular(22),
              
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text("SEND RESET LINK",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.white,

              ),
            ),
          ),

        ),
      ),
    );
  }

  Widget buildHomepageButton(){
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Expanded(
            flex: 16,

            child: Container(
              alignment: Alignment.centerRight,
              child: Text("Back to",

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                ),),

            ),
          ),
          Expanded(
            flex: 17,
            child: Container(
              alignment: Alignment.centerLeft,
              child: TextButton(onPressed: (){Navigator.pop(context);},
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,

                    ),
                  )

              ),

            ),
          ),

        ],
      );

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text('HMZ NewZ',
            style: TextStyle(
              fontFamily: 'Neucha',
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),),
          centerTitle: true,
          backgroundColor: Colors.black87,
        ) ,
              body: SafeArea(
              child: Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center ,
              children: [

              Center(
                child: Container(
                  padding: EdgeInsets.fromLTRB(36, 0, 20, 20),
                  child: Text("Forgot Password?",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nuecha',
                  fontSize: 35,
                    color: Colors.white,

                  ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              //Email
              buildEmail(),
              SizedBox(height: 25),
                //Reset Link
                buildResetButton(),
                SizedBox(height: 20),
                //Login Page Button
                buildHomepageButton(),


    ]
    )
    )
    )
    );
  }
}
