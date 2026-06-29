import 'package:lms/features/auth/model/profile_model.dart';

class TrainerProfileModel {
  final String id;
  final String bio;
  final String expertise;
  final int experienceYears;
  final Review? review;
  final Suspension? suspension;
  final ProfileModel profile; 

  TrainerProfileModel({
    required this.id,
    required this.bio,
    required this.expertise,
    required this.experienceYears,
    this.review,
    this.suspension,
    required this.profile,
  });

  factory TrainerProfileModel.fromMap(Map<String, dynamic> map) {
    return TrainerProfileModel(
      id: map['id'] ?? '',
      bio: map['bio'] ?? '',
      expertise: map['expertise'] ?? '',
      experienceYears: map['experience_years'] ?? 0,
      review: map['review'] == null ? null : Review.fromMap(map["review"]),
      suspension: Suspension.fromMap(map['suspension'] ?? {}),
      profile: ProfileModel.fromMap(map['user']),
    );
  }
}

class Review {
  final String status;
  final String rejectionReason;
  final DateTime reviewedAt;

  Review({
    required this.status,
    required this.rejectionReason,
    required this.reviewedAt,
  });

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      status: map['status'] ?? '',
      rejectionReason: map['rejection_reason'] ?? '',
      reviewedAt: DateTime.tryParse(map['reviewed_at'] ?? '') ?? DateTime.now(),
    );
  }
}

class Suspension {
  final bool isSuspended;
  final String reason;
  final DateTime suspendedAt;

  Suspension({
    required this.isSuspended,
    required this.reason,
    required this.suspendedAt,
  });

  factory Suspension.fromMap(Map<String, dynamic> map) {
    return Suspension(
      isSuspended: map['is_suspended'] ?? false,
      reason: map['reason'] ?? '',
      suspendedAt:
          DateTime.tryParse(map['suspended_at'] ?? '') ?? DateTime.now(),
    );
  }
}
