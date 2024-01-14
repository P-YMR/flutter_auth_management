part of 'controllers.dart';

abstract class AuthController<T extends Auth> {
  static AuthController<T> getInstance<T extends Auth>({
    AuthDataSource? auth,
    BackupDataSource<T>? backup,
    AuthMessages? messages,
  }) {
    return Singleton.instanceOf(() {
      return AuthControllerImpl<T>(
        auth: auth,
        backup: backup,
        messages: messages,
      );
    });
  }

  static AuthController<T> getInstanceOf<T extends Auth>({
    AuthHandler? authHandler,
    BackupHandler<T>? backupHandler,
    AuthMessages? messages,
  }) {
    return Singleton.instanceOf(() {
      return AuthControllerImpl<T>.fromHandler(
        authHandler: authHandler,
        backupHandler: backupHandler,
        messages: messages,
      );
    });
  }

  Future<T?> get auth {
    throw UnimplementedError('auth is not implemented');
  }

  Stream<T?> get liveAuth {
    throw UnimplementedError('liveAuth is not implemented');
  }

  Stream<AuthResponse<T>> get liveResponse {
    throw UnimplementedError('liveResponse is not implemented');
  }

  Future<bool> get isBiometricEnabled {
    throw UnimplementedError('isBiometricEnabled is not implemented');
  }

  Future<bool> get isLoggedIn {
    throw UnimplementedError('isLoggedIn is not implemented');
  }

  Future<AuthResponse<T>> emit(AuthResponse<T> data) {
    throw UnimplementedError('emit() is not implemented');
  }

  void close() {
    throw UnimplementedError('close() is not implemented');
  }

  Future<T?> update(Map<String, dynamic> data) {
    throw UnimplementedError('update() is not implemented');
  }

  Future<AuthResponse<T>> delete() {
    throw UnimplementedError('delete() is not implemented');
  }

  Future<bool> addBiometric(
    bool enabled, {
    BiometricConfig? config,
  }) {
    throw UnimplementedError('addBiometric() is not implemented');
  }

  Future<bool> biometricEnable(bool enabled) {
    throw UnimplementedError('biometricEnable() is not implemented');
  }

  Future<AuthResponse<T>> isSignIn([
    AuthProviders? provider,
  ]) {
    throw UnimplementedError('isSignIn() is not implemented');
  }

  Future<AuthResponse<T>> signInByApple({
    String? id,
    Authenticator? authenticator,
    SignByBiometricCallback? onBiometric,
    bool storeToken = false,
  }) {
    throw UnimplementedError('signInByApple() is not implemented');
  }

  Future<AuthResponse<T>> signInByBiometric({
    BiometricConfig? config,
  }) {
    throw UnimplementedError('signInByBiometric() is not implemented');
  }

  Future<AuthResponse<T>> signInByEmail(
    EmailAuthenticator authenticator, {
    SignByBiometricCallback? onBiometric,
  }) {
    throw UnimplementedError('signInByEmail() is not implemented');
  }

  Future<AuthResponse<T>> signInByFacebook({
    OAuthAuthenticator? authenticator,
    SignByBiometricCallback? onBiometric,
    bool storeToken = false,
  }) {
    throw UnimplementedError('signInByFacebook() is not implemented');
  }

  Future<AuthResponse<T>> signInByGithub({
    OAuthAuthenticator? authenticator,
    SignByBiometricCallback? onBiometric,
    bool storeToken = false,
  }) {
    throw UnimplementedError('signInByGithub() is not implemented');
  }

  Future<AuthResponse<T>> signInByGoogle({
    OAuthAuthenticator? authenticator,
    SignByBiometricCallback? onBiometric,
    bool storeToken = false,
  }) {
    throw UnimplementedError('signInByGoogle() is not implemented');
  }

  Future<AuthResponse<T>> signInByPhone(
    PhoneAuthenticator authenticator, {
    SignByBiometricCallback? onBiometric,
    bool storeToken = false,
  }) {
    throw UnimplementedError('signInByPhone() is not implemented');
  }

  Future<AuthResponse<T>> signInByUsername(
    UsernameAuthenticator authenticator, {
    SignByBiometricCallback? onBiometric,
  }) {
    throw UnimplementedError('signInByUsername() is not implemented');
  }

  Future<AuthResponse<T>> signUpByEmail(
    EmailAuthenticator authenticator, {
    SignByBiometricCallback? onBiometric,
  }) {
    throw UnimplementedError('signUpByEmail() is not implemented');
  }

  Future<AuthResponse<T>> signUpByUsername(
    UsernameAuthenticator authenticator, {
    SignByBiometricCallback? onBiometric,
  }) {
    throw UnimplementedError('signUpByUsername() is not implemented');
  }

  Future<AuthResponse<T>> signOut([
    AuthProviders provider = AuthProviders.none,
  ]) {
    throw UnimplementedError('signOut() is not implemented');
  }

  Future<Response<void>> verifyPhoneNumber(
    String phoneNumber, {
    int? forceResendingToken,
    PhoneMultiFactorInfo? multiFactorInfo,
    MultiFactorSession? multiFactorSession,
    Duration timeout = const Duration(minutes: 2),
    void Function(PhoneAuthCredential credential)? onComplete,
    void Function(FirebaseAuthException exception)? onFailed,
    void Function(String verId, int? forceResendingToken)? onCodeSent,
    void Function(String verId)? onCodeAutoRetrievalTimeout,
  }) {
    throw UnimplementedError('verifyPhoneNumber() is not implemented');
  }
}
