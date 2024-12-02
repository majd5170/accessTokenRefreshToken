class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.username, 
    required this.email, 
    required this.firstName, 
    required this.lastName, 
    required this.gender, 


      });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      username: json['username'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
    );
  }
}