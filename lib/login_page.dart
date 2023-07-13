import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:contact_message/shared_pref.dart';
import 'package:contact_message/home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  var baseUrl = "https://b517-103-17-77-3.ngrok-free.app/api";
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> login() async {
      var dio = Dio();
      try {
        var response = await dio.post(
          "$baseUrl/login",
          data: {
            "email": emailController.text,
            "password": passwordController.text
          },
        );
        SharedPref.pref?.setString("token", response.data["data"]["token"]);

        print(response);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } catch (e) {
        print("mohon maaf kesalahan email dan  password");
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const Text(
                "Welcome back! Glad to see you, Again!",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Container(
                height: 32,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Enter Your Email"),
              ),
              Container(
                height: 12,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Your Password",
                    suffixIcon: Icon(Icons.remove_red_eye)),
              ),
              Container(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    'Forgot Password',
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.black)),
                  onPressed: () {
                    print(emailController.text);
                    print(passwordController.text);
                    login();
                  },
                  child: const Text("Login"),
                ),
              ),
              Container(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.grey,
                    width: 120,
                    height: 2,
                  ),
                  const Text("Or Login With"),
                  Container(
                    color: Colors.grey,
                    width: 120,
                    height: 2,
                  )
                ],
              ),
              Container(
                height: 36,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 36,
                    child: Image.network(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1200px-Google_%22G%22_Logo.svg.png"),
                  ),
                  Container(
                    height: 36,
                    child: Image.network(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/2021_Facebook_icon.svg/2048px-2021_Facebook_icon.svg.png"),
                  ),
                  Container(
                    height: 36,
                    child: Image.network(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/625px-Apple_logo_black.svg.png"),
                  )
                ],
              ),
              Container(
                height: 120,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don’t have an account?"),
                  Container(width: 12),
                  const Text(
                    "Register Now",
                    style: TextStyle(color: Colors.cyan),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}