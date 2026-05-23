import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myfirstapp/features/profile/repository/profile_repository.dart';
import 'package:myfirstapp/models/user_model.dart';

final profileControllerProvider = Provider(
  (ref) => ProfileController(
    profileRepository: ref.watch(profileRepositoryProvider),
  ),
);

class ProfileController{
  final ProfileRepository profileRepository;

  ProfileController({required this.profileRepository});

  Future<UserModel> getUser() async {
    return await profileRepository.getUser();
  }
}