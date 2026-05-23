import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myfirstapp/common/path.dart';
import 'package:myfirstapp/features/auth/contorller/auth_controller.dart';
import 'package:myfirstapp/features/auth/views/sing_up_info.dart';

import '../../../common/colors.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(signUpImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          AspectRatio(
            aspectRatio: 1,
            child: //sing in ekranı
            Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: ContainerColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: SingleChildScrollView(
                  // ekranın kaydırılabilir olması için
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: TitleColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        // email textformfield
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            // email alanının boş olup olmadığını kontrol eder
                            if (value == null || value.isEmpty) {
                              return "Email is required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: BorderColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        // password textformfield
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true, 
                          validator: (value) {
                            // password alanının boş olup olmadığını kontrol eder
                            if (value == null || value.isEmpty) {
                              return "Password is required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: BorderColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          return Padding(
                            // sign in butonu
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: MaterialButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // 1. Firebase/Auth işlemini bekle (await)
                                  await ref
                                      .read(authControllerProvider)
                                      .signUpWithEmailAndPassword(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      );

                                  // 2. İşlem bittikten sonra sayfa hala açık mı kontrol et (Çok önemli!)
                                  if (!context.mounted) return;

                                  // 3. Geçmişi tamamen silmek yerine sadece mevcut kayıt sayfasını Info sayfasıyla değiştir
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignUpInfo(email: _emailController.text),
                                    ),
                                  );
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: continueButtonColor,
                              minWidth: double.infinity, // butonun genisligi
                              child: Padding(
                                // butonun icindeki yazinin paddingi
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: const Text(
                                  "Continue",
                                  style: TextStyle(
                                    color: ContainerColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Container(
                        // sign up butonu
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          // sign up butonu icindeki yazilarin yan yana durmasi icin row kullandik
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              // buton değil
                              "Do you have an account? ",
                              style: TextStyle(
                                color: TextButtonTextColor,
                                fontSize: 14,
                              ),
                            ),
                            InkWell(
                              // buton gibi davranan text
                              onTap: () {},
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                  color: TitleColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
