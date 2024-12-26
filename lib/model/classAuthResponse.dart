
class AuthResponse {
    String? email;
    dynamic mobileNumber;
    String? password;
    String? token;
    String? refreshToken;
    dynamic fcmToken;
    bool? trustDevice;

    AuthResponse({
        this.email,
        this.mobileNumber,
        this.password,
        this.token,
        this.refreshToken,
        this.fcmToken,
        this.trustDevice,
    });

    factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        email: json["email"],
        mobileNumber: json["mobileNumber"],
        password: json["password"],
        token: json["token"],
        refreshToken: json["refreshToken"],
        fcmToken: json["fcmToken"],
        trustDevice: json["trustDevice"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "mobileNumber": mobileNumber,
        "password": password,
        "token": token,
        "refreshToken": refreshToken,
        "fcmToken": fcmToken,
        "trustDevice": trustDevice,
    };
}
