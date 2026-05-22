import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/features/trainer/bloc/bloc/trainer_profile_bloc.dart';
import 'package:lms/features/trainer/model/trainer_profile_model.dart';

class TrainerProfile extends StatefulWidget {
  const TrainerProfile({super.key});
    static const String routeName = "/trainer-profile";


  @override
  State<TrainerProfile> createState() => _TrainerProfileState();
}

class _TrainerProfileState extends State<TrainerProfile> {
  @override
  void didChangeDependencies() {
    context.read<TrainerProfileBloc>().add(TrainerProfileEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Trainer Profile")),

      body: BlocBuilder<TrainerProfileBloc, TrainerProfileState>(
        builder: (context, state) {
          if (state is TrainerProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TrainerProfileLoaded) {
            // FIX: assign model from state
            final TrainerProfileModel trainerProfileModel = state.profileModel;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          child: Icon(Icons.person, size: 50),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          trainerProfileModel.profile.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          "@${trainerProfileModel.profile.username}",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "Basic Information",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // FIX: email
                          _buildInfoRow(
                            "Email",
                            trainerProfileModel.profile.email,
                          ),

                          // FIX: roles
                          _buildInfoRow(
                            "Roles",
                            trainerProfileModel.profile.roles.join(", "),
                          ),

                          // FIX: has trainer profile
                          _buildInfoRow(
                            "Has Profile",
                            trainerProfileModel.profile.hastrainerprofile
                                ? "Yes"
                                : "No",
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Trainer Details",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // FIX: expertise
                          _buildInfoRow(
                            "Expertise",
                            trainerProfileModel.expertise,
                          ),

                          // FIX: experience years
                          _buildInfoRow(
                            "Experience",
                            "${trainerProfileModel.experienceYears} Years",
                          ),

                          // FIX: bio
                          _buildInfoRow("Bio", trainerProfileModel.bio),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Review Information",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // FIX: review status
                          _buildInfoRow(
                            "Status",
                            trainerProfileModel.review!.status,
                          ),

                          // FIX: rejection reason
                          _buildInfoRow(
                            "Rejection Reason",
                            trainerProfileModel.review!.rejectionReason.isEmpty
                                ? "N/A"
                                : trainerProfileModel.review!.rejectionReason,
                          ),

                          // FIX: reviewed at
                          _buildInfoRow(
                            "Reviewed At",
                            trainerProfileModel.review!.reviewedAt.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Suspension Information",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // FIX: suspended
                          _buildInfoRow(
                            "Suspended",
                            trainerProfileModel.suspension!.isSuspended
                                ? "Yes"
                                : "No",
                          ),

                          // FIX: suspension reason
                          _buildInfoRow(
                            "Reason",
                            trainerProfileModel.suspension!.reason.isEmpty
                                ? "N/A"
                                : trainerProfileModel.suspension!.reason,
                          ),

                          // FIX: suspended at
                          _buildInfoRow(
                            "Suspended At",
                            trainerProfileModel.suspension!.suspendedAt
                                .toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is TrainerProfileFailure) {
            return Center(child: Text(state.msg));
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(flex: 5, child: Text(value)),
        ],
      ),
    );
  }
}
