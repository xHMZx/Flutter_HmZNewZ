

class Accounts
{
 late String Name;
 late String Email;
 late String Password;

 Accounts(){}

 void setName(String name){
   this.Name = name;
 }
 void setEmail(String email){
   this.Email = email;
 }
 void setPassword(String pass){
   this.Password = pass;
 }


 String getName(){
   return this.Name;
 }
 String getEmail(){
   return this.Email;
 }
 String getPassword(){
   return this.Password;
 }
}