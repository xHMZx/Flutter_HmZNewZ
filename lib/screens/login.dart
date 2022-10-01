import 'package:flutter/material.dart';
import 'package:untitled/screens/forgetPassword.dart';
import 'package:untitled/screens/homescreen.dart';
import 'package:untitled/screens/signup.dart';

import '../account.dart';

List<Accounts> userList = [];
Accounts admin = new Accounts();


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

//Password Visibility



  late String email;
  late String pass;
  bool usernotfound = true;
  bool ishiddenPassword= true;

  void _togglePasswordVisibility()
  {
    ishiddenPassword = !ishiddenPassword;
    setState(() {});
  }
  //Remember Me
  bool _rememberMe = false;
  void _toggleRememberMe()
  {
    _rememberMe = !_rememberMe;
    print("Remember Me Pressed");
    setState(() {});
  }


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
                onChanged: (value){
                  this.email = value;
                },
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

  Widget buildPassword(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),

        ),
        child: TextField(
          onChanged: (value){
            this.pass = value;
          },
          obscureText: ishiddenPassword,
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),

              suffixIcon: (
                  IconButton(icon: ishiddenPassword == true ?
                  Icon(Icons.visibility_off , color: Colors.blue.shade800,)
                      : Icon(Icons.visibility, color: Colors.blue.shade800,),
                  onPressed: (){setState(() {_togglePasswordVisibility();});}


              )
    ),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.blue.shade800,
              ),
              hintText: 'Password'
          ),
        ),
      ),
    );
  }

  Widget buildForgotPassword(){
    return Container(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(right: 0),
        child: TextButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgetPasswordScreen())),
          child: Text("Forgot Password ?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
              fontSize: 11,
            ),),
        ),
      ),

    );
  }

  Widget buildRemeberMe() {
    return Container(
     // alignment: Alignment.centerRight,
        child: Text("Remember Me?",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade700,
            fontSize: 11,
          ),
        ),
    );
  }

  Widget buildLoginButton(){
   return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: InkWell(
        onTap: () {
          userList.forEach((element) {
            print(element.Email);
            if(email == element.Email && pass == element.Password){
            setState(() {
              usernotfound = false;
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> DashBoard()));
            }); }
          }
            );

          if(usernotfound ==true){
            print("Error");
            showDialog(context: context, builder: (context){
            return Container(child: AlertDialog(
              title: Text("Wrong Email or Password",
            style: TextStyle(
              fontSize: 17,
            ),
              ),
            actions: [
              TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Ok"))
            ],));});
          }


        },
        child: Container(

          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blue.shade900,
              borderRadius: BorderRadius.circular(22),

          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text("LOG IN",
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

  Widget buildCreateButton(){
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          Expanded(
            flex: 7,

            child: Container(
              alignment: Alignment.centerRight,
              child: Text("Don't have an account ?",

                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),),

            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              alignment: Alignment.centerLeft,
              child: TextButton(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpScreen())),
                  child: Text(
                    "Create",
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
    admin.setName("Hamza");
    admin.setEmail("hmz@gmail.com");
    admin.setPassword("admin123");
    userList.add(admin);

    return Scaffold(
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
              Text("Sign In",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Neucha',
                fontSize: 50,
                color: Colors.white,
              ),
              ),
              SizedBox(height: 70),
              //Email
              buildEmail(),
              SizedBox(height: 20),
              //Password
              buildPassword(),
              SizedBox(height: 5),
              //remember me checkbox
            //   Padding(
            //     padding: EdgeInsets.symmetric(horizontal:30 ),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         flex: 1,
            //         child: IconButton(icon: _rememberMe == true ?
            //         Icon(Icons.check_box, color: Colors.blue.shade700,)
            //             : Icon(Icons.check_box_outline_blank, color: Colors.blue.shade700,),
            //             onPressed: (){setState(() {_toggleRememberMe();});}
            //
            //         ),
            //       ),
            //
            //       Expanded(
            //         flex: 4,
            //           child: buildRemeberMe()
            //       ),
            //
            //       Expanded(
            //         flex: 4,
            //         child: buildForgotPassword()
            //         ),
            //
            //     ],
            //   ),
            // ),
              SizedBox (height: 25),
              //login button
              buildLoginButton(),
              //sign up link
              buildCreateButton(),
            ],

          ),
        ),
      ),
    );
  }
}
