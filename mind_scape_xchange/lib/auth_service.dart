class AuthService {
  static const String temporaryPassword = '123';

  Future<bool> login(String username, String password) async {
    // Simulate authentication (replace with actual authentication logic)
    await Future.delayed(Duration(seconds: 2));

    // Check if the username exists and the password matches the temporary password
    if (username == 'test' && password == temporaryPassword) {
      return true; // Login successful
    } else {
      return false; // Login failed
    }
  }
}
