import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUp(){
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    if(name.isNotEmpty && email.isNotEmpty && password.isNotEmpty){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(userName: name),  
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('please fill out all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}