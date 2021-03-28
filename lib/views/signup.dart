import 'package:chatapp/helper/helperfunctions.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/chatrooms.dart';
import 'package:chatapp/widget/widget.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp(this.toggleView);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  TextEditingController usernameEditingController =
      new TextEditingController();

  AuthService authService = new AuthService();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  singUp() async {

    if(formKey.currentState.validate()){
      setState(() {

        isLoading = true;
      });

      await authService.signUpWithEmailAndPassword(emailEditingController.text,
          passwordEditingController.text).then((result){
            if(result != null){

              Map<String,String> userDataMap = {
                "userName" : usernameEditingController.text,
                "userEmail" : emailEditingController.text
              };

              databaseMethods.addUserInfo(userDataMap);

              HelperFunctions.saveUserLoggedInSharedPreference(true);
              HelperFunctions.saveUserNameSharedPreference(usernameEditingController.text);
              HelperFunctions.saveUserEmailSharedPreference(emailEditingController.text);

              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => ChatRoom()
              ));
            }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register",
          style: TextStyle(fontSize: 35,color: Colors.black),
        ),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      body: isLoading ? Container(child: Center(child: CircularProgressIndicator(),),) :  Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/a1.jpg"),
              fit: BoxFit.cover,
              ),
            ),
        child: Column(
          children: [
            Expanded(child: Image.network('https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/15589/cartoon-tiger-face-clipart-sm.png',	height: 200, width: 200,),),
            // Spacer(),
             SizedBox(
              height: 20,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                SizedBox(
                  height: 20,
                ),
                  TextFormField(
                    style: simpleTextStyle(),
                    controller: usernameEditingController,
                    validator: (val){
                      return val.isEmpty || val.length < 3 ? "Enter Username 3+ characters" : null;
                    },
                    decoration: inputDecoration.copyWith(
                      hintText: '     username',
                      hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 18.0,
                      ),
                      ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: emailEditingController,
                    style: simpleTextStyle(),
                    validator: (val){
                      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                          null : "Enter correct email";
                    },
                    decoration: inputDecoration.copyWith(
                      hintText: '     email',
                      hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 18.0,
                      ),
                      ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    obscureText: true,
                    style: simpleTextStyle(),
                    decoration: inputDecoration.copyWith(
                      hintText: '     password',
                      hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 18.0,
                      ),
                      ),
                    controller: passwordEditingController,
                    validator:  (val){
                      return val.length < 6 ? "Enter Password 6+ characters" : null;
                    },

                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: (){
                singUp();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [const Color(0xFFFFEB3B), const Color(0xFFFFEB3B)],
                    )),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Sign Up",
                  style: biggerTextStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

              SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.toggleView();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFFFFF176),
                              const Color(0xFFFFF176)
                            ],
                          )),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "SignIn Now",
                        style: biggerTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                                    SizedBox(
                    height: 60,
                  ),
          ],
        ),
      ),
    );
  }
}
