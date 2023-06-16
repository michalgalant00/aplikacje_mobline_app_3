class Person {
  String fullName;
  String city;
  String phoneNumber;
  String avatarImage;

  Person({
    required this.fullName,
    required this.city,
    required this.phoneNumber,
    required this.avatarImage,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      fullName: json['fullName'],
      city: json['city'],
      phoneNumber: json['phoneNumber'],
      avatarImage: json['avatarImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'city': city,
      'phoneNumber': phoneNumber,
      'avatarImage': avatarImage,
    };
  }
}
