class UserModel {
  final String userId;
  final String userName;
  final String email;
  final String? phoneNumber;
  final String? gender;
  final String? skinType;
  final String role;
  final String profilePicture;
  final String? dateOfBirth;
  final List<String>? skinAnalysisHistoryIds;
  final List<String>? savedProductIds;
  final List<String>? reviewIds;

  UserModel({
    required this.userId,
    required this.userName,
    required this.email,
    this.phoneNumber,
    this.gender,
    this.skinType,
    required this.role,
    required this.profilePicture,
    this.dateOfBirth,
    this.skinAnalysisHistoryIds,
    this.savedProductIds,
    this.reviewIds,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['id'],
      userName: json['username'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      gender: json['gender'],
      skinType: json['skinType'],
      role: json['role'],
      profilePicture: json['profilePicture'],
      dateOfBirth: json['dateOfBirth'],
      skinAnalysisHistoryIds: json['skinAnalysisHistoryIds'] != null
          ? List<String>.from(json['skinAnalysisHistoryIds'])
          : null,
      savedProductIds: json['savedProductIds'] != null
          ? List<String>.from(json['savedProductIds'])
          : null,
      reviewIds: json['reviewIds'] != null
          ? List<String>.from(json['reviewIds'])
          : null,
    );
  }
}