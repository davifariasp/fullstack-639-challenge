import 'package:app/Model/user.dart';

abstract class IUserRepository {
  Future<User> getUser();
  Future<void> saveUser(User user);
}