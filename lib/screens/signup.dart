// newAccount.setName(value);

import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/account.dart';

import 'login.dart';




class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validated=false;
  late String name,password,email;

  bool validate(){
    if(formKey.currentState!.validate()){
      return true;
    }
     else {return false;}
  }

  Accounts newAccount =new Accounts();
  bool newEmail = true;
  bool ishiddenPassword= true;

  bool EmailValidation(value){
    newEmail = true;
    userList.forEach((element) {if (element.Email == value){newEmail = false ;}});
    if(newEmail == false) {
      return false;
      }
    else{

      return true;}
  }


  void _togglePasswordVisibility()
  {
    ishiddenPassword = !ishiddenPassword;
    setState(() {});
  }

  bool _termsAgreed = false;
  void _toggleTermsAgreed()
  {
    _termsAgreed = !_termsAgreed;
    if (_termsAgreed == true)
    print("Terms Agreed");
    else if (_termsAgreed == false)
      print("Terms not Agreed");
    setState(() {});
  }

  Widget buildName(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0,),
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          
        ),
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
          ],

          validator: RequiredValidator(errorText: "           Required*"),
          


          onChanged: (value){
            this.name= value;
          },
          decoration: InputDecoration(

              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person_pin,
                color: Colors.blue.shade800,
                size: 32.0,
              ),
              hintText: 'Name',
          ),
        ),
      ),
    );
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
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          // inputFormatters: <TextInputFormatter>[
          //   FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z@.]")),
          // ],
            validator: MultiValidator([
               EmailValidator(errorText: "          Enter Valid Email"),
                RequiredValidator(errorText: "          Required*")
              ]),
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
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.deny(RegExp("[ ]")),
          ],
          validator: MultiValidator([
            MinLengthValidator(6, errorText: "          Password should contain atleast 6 Characters"),
            RequiredValidator(errorText: "          Required*")
          ]),
          onChanged: (value){
            this.password = value;
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

  Widget buildSignUpButton(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: InkWell(
        onTap: () {
          validated =validate();
          setState(() {

            if(EmailValidation(this.email)==false)
              {
                showDialog(context: context, builder: (context) {
                  return Container(child: AlertDialog(
                    title: Text("An account already has this email",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    actions: [
                      TextButton(onPressed: () {
                        Navigator.pop(context);
                      }, child: Text("Ok"))
                    ],));});
            }
            else if(validated==true && EmailValidation(this.email)==true) {
              newAccount.setEmail(this.email);
              newAccount.setPassword(this.password);
              newAccount.setName(this.name);
              userList.add(newAccount);
              print(newEmail);
              Navigator.pop(context);
            }
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
            child: Text("CREATE ACCOUNT",
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

  Widget buildSignInButton(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Expanded(
          flex: 8,

          child: Container(
            alignment: Alignment.centerRight,
            child: Text("Already have an account ?",

              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),),

          ),
        ),
        Expanded(
          flex: 6,
          child: Container(
            alignment: Alignment.centerLeft,
            child: TextButton(onPressed: ()=> Navigator.pop(context),
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

  Widget buildTermsAgreement(){
    return Container(

      // alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(right: 0),
        child: TextButton(
          onPressed: ()=> print("Terms and Agreement Page"),
          child: Text("Terms & Agreements?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
              fontSize: 10,
            ),),
        ),
      ),

    );
  }

  Widget buildAgreementText() {
    return Container(

       alignment: Alignment.center,
      child: Text("I have read and agree to all?",
        style: TextStyle(
          fontSize: 10,
          color: Colors.white,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center ,
            children: [
              SizedBox(height: 120,),
              Text("Sign Up",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Neucha',
                  fontSize: 50,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),
              //Name
              Form(
                key: formKey,
                child: Column(
                  children:<Widget> [
                    buildName(),
                    SizedBox(height: 20),
                    //Email
                    buildEmail(),
                    SizedBox(height: 20),
                    //Password
                    buildPassword(),
                    SizedBox(height: 10),
                  ],
                ),
              ),

              //Terms&Agreement checkbox
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal:55 ),
              //   child:
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Expanded(
              //         flex: 17,
              //         child:
              //         IconButton(
              //             alignment: Alignment.centerRight,
              //             icon: _termsAgreed == true ?
              //         Icon(Icons.check_box, color: Colors.blue.shade700,)
              //             : Icon(Icons.check_box_outline_blank, color: Colors.blue.shade700,),
              //             onPressed: (){setState(() {_toggleTermsAgreed();});}
              //
              //         ),
              //       ),
              //
              //       Expanded(
              //           flex: 67,
              //           child: buildAgreementText()
              //       ),
              //
              //       Expanded(
              //           flex: 62,
              //           child: buildTermsAgreement()
              //       ),
              //
              //     ],
              //   ),
              // ),

              SizedBox (height: 25),
              //login button
              buildSignUpButton(),
              //sign up link
              buildSignInButton(),
            ],

          ),

        ),
      ),
    );
  }
}
