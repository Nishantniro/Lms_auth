class ApplyTrainerModel {
  final String bio;
  final String expertise;
  final int experienceYears;

  ApplyTrainerModel({
    required this.bio,
    required this.expertise,
    required this.experienceYears,
  });

  Map<String, dynamic> toMap() {
    return {
      "bio": bio,
      "expertise": expertise,
      "experience_years": experienceYears,
    };
  }
}
