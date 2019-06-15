class UserDataClass {
  final int userId;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  UserDataClass(
      {this.userId, this.email, this.firstName, this.lastName, this.avatar});

  factory UserDataClass.fromJson(Map<String, dynamic> json) {
    return UserDataClass(
      userId: json['data'][
          'id'], //for read simple & without array data structure use as json['id'],
      email: json['data']['email'],
      firstName: json['data']['first_name'],
      lastName: json['data']['last_name'],
      avatar: json['data']['avatar'],
    );
  }
}
