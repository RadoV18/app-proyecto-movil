class Token{
  static final Token _token = Token._internal();
  String tokenString = '';
  String username = '';
  String name = '';

  factory Token() {
    return _token;
  }

  Token._internal();

  getTokenString() {
    return tokenString;
  }

  setTokenString(String newToken) {
    tokenString = newToken;
  }

  getUsername() {
    return username;
  }

  setUsername(String username) {
    this.username = username;
  }

  getName() {
    return name;
  }

  setName(String name) {
    this.name = name;
  }

  String getAuthHeaderString() {
    return 'Bearer $tokenString';
  }

  void clear() {
    setUsername('');
    setName('');
    setTokenString('');
  }

  bool isAuthenticated() {
    return tokenString != '';
  }
}