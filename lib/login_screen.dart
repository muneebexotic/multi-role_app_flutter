import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_practice/home_screen.dart';
import 'package:shared_preferences_practice/student_screen.dart';
import 'package:shared_preferences_practice/teacher_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ageController = TextEditingController();
  String? selectedRole;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Age'),
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownMenu(
                initialSelection: selectedRole,
                hintText: 'Select Role',
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: 'teacher', label: 'teacher'),
                  DropdownMenuEntry(value: 'student', label: 'student'),
                ],
            onSelected: (String? newValue){
                  setState(() {
                    selectedRole = newValue;
                  });
            }),

            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.setString('email', emailController.text.toString());
                sp.setString('age', ageController.text.toString());
                sp.setBool('isLogin', true);
                sp.setString('userType', selectedRole.toString());
                if (sp.getString('userType') == 'teacher') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TeacherScreen()));
                } else if (sp.getString('userType') == 'student') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => StudentScreen()));
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                }
              },
              child: Container(
                height: 50,
                width: double.infinity,
                color: Colors.teal,
                child: const Center(child: Text('Sign up')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
