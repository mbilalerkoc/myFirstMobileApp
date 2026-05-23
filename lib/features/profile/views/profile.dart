import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myfirstapp/common/colors.dart';
import 'package:myfirstapp/common/size.dart';
import 'package:myfirstapp/features/profile/controller/profile_controller.dart';
import 'package:myfirstapp/models/user_model.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: scafoldPadding,
          child: FutureBuilder<UserModel>(
            future: ref.read(profileControllerProvider).getUser(),
            builder: (context, snapshot) {
              
              // 1. Durum: Yükleniyor
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } 
              
              // 2. Durum: Hata Var
              else if (snapshot.hasError) {
                return Center(child: Text("Hata: ${snapshot.error}"));
              } 
              
              // 3. Durum: Veri Başarıyla Geldi
              else if (snapshot.hasData) {
                final userModel = snapshot.data!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: profilePhotoCircleColor,
                      radius: 50,
                      child: CircleAvatar(
                        backgroundColor: profilePhotoCircleColor,
                        radius: 48,
                        backgroundImage: CachedNetworkImageProvider(
                          userModel.profilePhoto!,
                        ),
                      ),
                    ),
                  ],
                );
              }

              // 4. Durum: Derleyicinin "null döner" hatasını önleyen GÜVENLİK SİBOBU!
              // Eğer yukarıdaki if'lerin hiçbirine girmezse, ekrana boş bir kutu çiz.
              return const SizedBox(); 
            },
          ),
        ),
      ),
    );
  }
}