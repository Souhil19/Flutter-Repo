import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image(
                    image: AssetImage('assets/images/gdg_medea.jpg'),
                  ),
                ),
                Text(
                    'Login',
                  style: TextStyle(
                    fontSize:40.0,
                    fontWeight: FontWeight.bold
                  ),

                ),
                SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (String value){
                    print(value);
                  },
                  onChanged: (String value){
                    print(value);
                  },
                  decoration: InputDecoration(

                    labelText: 'Email',
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                    border: OutlineInputBorder(


                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  onFieldSubmitted: (String value){
                    print(value);
                  },
                  onChanged: (String value){
                    print(value);
                  },
                  decoration: InputDecoration(

                    labelText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                    suffixIcon: Icon(
                      Icons.remove_red_eye
                    ),
                    border: OutlineInputBorder(


                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: double.infinity,
                  color: Colors.blue,
                  height: 40,
                  child: MaterialButton(onPressed: (){
                    print(emailController);
                    print(passwordController);
                  },
                    child: Text('Login',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?'
                    ),
                    TextButton(onPressed: (){}, child: Text(
                      ' Register Now',
                    ),),
                  ],
                ),

              ],

            ),
          ),
        ),
      ),


    );
  }
}
