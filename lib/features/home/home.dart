import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/core/bloc/profile/profile_bloc.dart';
import 'package:lms/features/auth/model/profile_model.dart';
import 'package:lms/features/trainer/pages/apply_trainer.dart';
import 'package:lms/features/trainer/pages/trainer_profile.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  static const String routeName = "/home";

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ProfileBloc>().add(ProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return Center(
                      child: LoadingAnimationWidget.newtonCradle(
                        color: Colors.black,
                        size: 60,
                      ),
                    );
                  }
                  if (state is ProfileLoaded) {
                    bool hasTrainerProfile =
                        state.profileModel.hastrainerprofile;

                    final ProfileModel profileModel = state.profileModel;
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            child: Icon(Icons.person, size: 50),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            profileModel.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),

                          Text(
                            "@${profileModel.username}",
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          const SizedBox(height: 4),

                          Text(
                            profileModel.email,
                            style: TextStyle(color: Colors.black),
                          ),
                          ListTile(
                            tileColor: const Color(0xFFEDE7F6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),

                            leading: const Icon(Icons.person),

                            title: Text(
                              hasTrainerProfile ? "Trainer Profile" : "Apply",
                            ),

                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            ),

                            onTap: () {
                              Navigator.of(context).pushNamed(
                                hasTrainerProfile
                                    ? TrainerProfile.routeName
                                    : ApplyTrainer.routeName,
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is ProfileFaliure) {
                    return Center(child: Text(state.msg));
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(title: Text("welcome home")),
      body: Center(
        child: LoadingAnimationWidget.flickr(
          leftDotColor: const Color.fromARGB(255, 207, 68, 58),
          rightDotColor: const Color.fromARGB(255, 36, 17, 17),
          size: 60,
        ),
      ),
    );
  }
}
