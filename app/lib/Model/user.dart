class User {
  final int _id;
  final String _name;
  final String _email;
  final String _token;

  User({required int id, required String name, required String email, required String token}):_id = id, _name = name, _email = email, _token = token;

  int get id => _id;
  String get name => _name;
  String get email => _email;
  String get token => _token;
}
