import 'package:flutter/material.dart';
import 'package:flutter_project1/auth/auth_service.dart';
import 'package:flutter_project1/pages/profile_page.dart';
import 'package:flutter_project1/pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final authService = AuthService();

  void login()async{
    final email = _emailController.text;
    final password = _passwordController.text;

    try{
      await authService.signInWithEmailPassword(email, password);
      if(mounted){
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Login Successful")));
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),);
    }catch(e){
      if(mounted){
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset("image/ff.jpg",fit: BoxFit.cover,)
          ),
          Positioned(
              top: 40,
              left:10,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_new, color:Colors.white ,)
              )
          ),
          Center(
            child: Column(
              children: [
                Expanded(
                  flex:1,
                  child: SizedBox(
                    height:100,

                  ),
                ),
                Expanded(
                  flex:4,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height : height*0.025,
                        ),
                        Text("Welcome",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.purple),
                        ),
                        SizedBox(
                          height : height*0.05,
                        ),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )
                          ),
                        ),
                        SizedBox(
                          height : height*0.025,
                        ),
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                              labelText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )
                          ),
                        ),
                        SizedBox(
                          height : height*0.05,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              foregroundColor: Colors.white,
                              minimumSize: Size(200, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context)=>ProfilePage()),);
                            }, child: Text("Sign In")),
                        SizedBox(
                          height : height*0.015,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?"),
                            TextButton(onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context)=>SignupPage()),
                              );
                            },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.purple,
                                ),
                                child:Text("Sign Up"))
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}