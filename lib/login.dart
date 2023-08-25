import 'package:sample_pbo/home.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> { 
  String? _name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Login"),
      // ),
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background.jpg"),
              fit: BoxFit.fill
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.all(0.0),
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 220.0),
                        ),
                      Container(
                        width:600.0,
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children:   [
                              TextField(
                              decoration: const InputDecoration(
                                icon:Icon(Icons.person_outline, color: Colors.white,),
                                hintText:"User Name", 
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  _name = value;
                                });
                              },
                              style: const TextStyle(color: Colors.white),
                            ),
                            const TextField(
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                icon:Icon(Icons.lock, color: Colors.white,),
                                hintText:"Password",
                              ),
                                style: TextStyle(color: Colors.white),
                            ),
                            Padding(
                              padding:const EdgeInsets.only(top: 30.0, bottom: 5.0),
                              child: OutlinedButton( 
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red),), 
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return Home(useraname:_name!);
                                  }));
                                },
                                child: const Text("Sig In", style:TextStyle(color:Colors.white, fontWeight: FontWeight.w300))
                                ),
                            ), 
                            const Padding(
                              padding:EdgeInsets.only(bottom: 30.0),
                              child: TextButton( 
                              onPressed:null,
                                child: Text("Don't have an acount? Sign Up Here", style:TextStyle(color:Colors.white, fontWeight: FontWeight.w300))
                                ),
                            )
                          ]
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
    );
  }


  @override
  void dispose() { 
    super.dispose();
  }
}