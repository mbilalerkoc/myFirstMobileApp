import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myfirstapp/common/colors.dart';
import 'package:myfirstapp/common/path.dart';
import 'package:myfirstapp/common/size.dart';
import 'package:myfirstapp/features/profile/controller/profile_controller.dart';
import 'package:myfirstapp/models/user_model.dart';

class More extends ConsumerWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: FutureBuilder<UserModel>(
        future: ref.read(profileControllerProvider).getUser(),
        builder: (context, snapshot) {
          // 1. Durum: Veri Başarıyla Geldi
          if (snapshot.hasData) {
            final userModel = snapshot.data!;
            return SafeArea(
              child: Padding(
                padding: scafoldPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "More",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: vertical10,
                          child: CircleAvatar(
                            backgroundColor: profilePhotoCircleColor,
                            radius: 20,
                            backgroundImage: CachedNetworkImageProvider(
                              userModel.profilePhoto!,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: vertical10,
                      child: Text(
                        "Create Content",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: TitleColor,
                        ),
                      ),
                    ),
                    MenuItem(),
                  ],
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text("Hata: ${snapshot.error}"));
          }
        },
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { },
      child: Padding(
        padding: vertical5,
        child: Card(
          color: activeColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 5, // Gölgelendirme ekleyerek kartın daha belirgin görünmesini sağlar
          child: ListTile(
            leading: SvgPicture.asset(articleSvg),
            title: const Text(
              "Write an Article",
              style: TextStyle(
                color: whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: whiteColor,
              size: 16,
            ),
            onTap: () {
              // Create Post işlemi burada yapılacak
            },
          ),
        ),
      ),
    );
  }
}
