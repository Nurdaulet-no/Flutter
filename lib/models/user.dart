import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User{
  @HiveField(0)
  String id;

  @HiveField(1)
  String username;
  
  @HiveField(2)
  String password;
  
  @HiveField(3)
  String? phoneNumber;
  
  @HiveField(4)
  String? firstName;
  
  @HiveField(5)
  String? lastName;
  
  @HiveField(6)
  String? email;
  
  @HiveField(7)
  bool isAdmin;

  User ({
    required this.id,
    required this.username,
    required this.password,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.email,
    this.isAdmin = false
  });

  // method for getting only username and password
  // and I also add here id because every user have own id
  factory User.login({required String id, required String username, required String password}) {
    return User(
      id: id,
      username: username,
      password: password,
      isAdmin: false,
    );
  }
}