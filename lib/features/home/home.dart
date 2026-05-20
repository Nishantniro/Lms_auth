import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/core/bloc/profile/profile_bloc.dart';
import 'package:lms/features/trainer/pages/apply_trainer.dart';
import 'package:lms/features/trainer/pages/trainer_profile.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ProfileBloc>().add(GetProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoaded) {
                  bool hasTrainerProfile = state.profileModel.hastrainerprofile;

                  return FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => hasTrainerProfile
                              ? TrainerProfile()
                              : ApplyTrainer(),
                        ),
                      );
                    },
                    child: hasTrainerProfile
                        ? Text("Trainer Profile")
                        : Text("Apply"),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(title: Text("welcome home")),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(
              child: LoadingAnimationWidget.newtonCradle(
                color: Colors.black,
                size: 45,
              ),
            );
          }
          if (state is ProfileLoaded) {
            return Center(
              child: Column(
                children: [
                  Text(state.profileModel.name, style: TextStyle(fontSize: 30)),
                  Text(
                    state.profileModel.email,
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            );
          }
          if (state is ProfileFaliure) {
            return Text(state.msg);
          }
          return SizedBox();
        },
      ),
    );
  }
}
