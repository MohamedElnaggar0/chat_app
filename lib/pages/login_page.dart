import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constractor.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/register_page.dart';
import 'package:scholar_chat/widgets/custom_%20buttom.dart';
import 'package:scholar_chat/widgets/custom_text_form_field.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);
  static String id = 'LogInPage';

  @override
  State<LogInPage> createState() => _LogInPageState();
}

String? email;
String? passWord;
bool isloading = false;

GlobalKey<FormState> fromKay = GlobalKey();

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.all(5),
          child: Form(
            key: fromKay,
            child: ListView(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Image.asset(
                  'assets/images/scholar.png',
                  height: 100,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'pacifico'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 75,
                ),
                const Row(
                  children: [
                    Text(
                      'Log In',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustamTextFormField(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'Email',
                ),
                const SizedBox(
                  height: 15,
                ),
                CustamTextFormField(
                  onChanged: (data) {
                    passWord = data;
                  },
                  condition: true,
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomButtom(
                  ontap: () async {
                    if (fromKay.currentState!.validate()) {
                      isloading = true;
                      setState(() {});
                      try {
                        await loginUser();
                        showSnakeMessenger(context, 'Login Successfully');
                        Navigator.of(context).pushNamed(ChatPage.id);
                      } on FirebaseException catch (ex) {
                        if (ex.code == 'user-not-found') {
                          showSnakeMessenger(
                            context,
                            'No user found for that email.',
                          );
                        } else if (ex.code == 'wrong-password') {
                          showSnakeMessenger(
                            context,
                            'Wrong password provided for that user.',
                          );
                        }
                      } catch (ex) {
                        return showSnakeMessenger(
                            context, 'there was an error');
                      }
                      isloading = false;
                      setState(() {});
                    }
                  },
                  buttomText: 'Log In',
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'don\'t have an account?',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id,
                            arguments: email);
                      },
                      child: const Text(
                        '  register now',
                        style:
                            TextStyle(color: Color(0xffC7EDE6), fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSnakeMessenger(BuildContext context, String? messege) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(messege!),
    ));
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: passWord!,
    );
  }
}
