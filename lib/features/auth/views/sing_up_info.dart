import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myfirstapp/features/auth/contorller/auth_controller.dart';
import 'package:myfirstapp/features/home/views/home.dart';
import 'package:myfirstapp/models/user_model.dart';

import '../../../common/colors.dart';

class SignUpInfo extends StatefulWidget {
  const SignUpInfo({super.key, required this.email});
  final String email;

  @override
  State<SignUpInfo> createState() => _SignUpInfoState();
}

class _SignUpInfoState extends State<SignUpInfo> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _usernameController.dispose();
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
                image: AssetImage("assets/images/sign_up.jpg"),
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
                          controller: _nameController,
                          validator: (value) {
                            // name alanının boş olup olmadığını kontrol eder
                            if (value == null || value.isEmpty) {
                              return "Name is required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Name",
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
                          controller: _surnameController,
                          validator: (value) {
                            // surname alanının boş olup olmadığını kontrol eder
                            if (value == null || value.isEmpty) {
                              return "Surname is required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Surname",
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
                          controller: _usernameController,
                          validator: (value) {
                            // username alanının boş olup olmadığını kontrol eder
                            if (value == null || value.isEmpty) {
                              return "Username is required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Username",
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
                                  try {
                                    // 1. Modeli oluştur
                                    UserModel userModel = UserModel(
                                      name: _nameController.text,
                                      surname: _surnameController.text,
                                      username: _usernameController.text,
                                      email: widget.email,
                                    );

                                    // 2. Firebase'e kaydetme işlemini bekle (await)
                                    await ref
                                        .read(authControllerProvider)
                                        .storeUserInfoToFirebase(userModel);

                                    // 3. İşlem başarılı olursa sayfayı değiştir
                                    if (!context.mounted) return;
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Home(),
                                      ),
                                      (route) => false,
                                    );
                                  } catch (e) {
                                    // 4. EĞER HATA VARSA BURAYA DÜŞECEK!
                                    print("FIRESTORE KAYIT HATASI: $e");
                                  }
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
                                  "Sign Up",
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
