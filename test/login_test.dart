import 'package:prueba_tecnica_evangenio/models/user_model.dart';
import 'package:test/test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prueba_tecnica_evangenio/provider/auth_provider.dart';

main() {
  group('Login test', () {
    test('Login fail', () async {
      final auth = AuthProvider();
      final result = await auth.login('email', 'password');
      expect(result, isFalse);
      expect(auth.message, 'Unauthorized');
    });

    test('Login sucess', () async {
      final auth = AuthProvider();

      // Inicializo el SharedPreferences
      final Map<String, Object> values = <String, Object>{'token': ''};
      SharedPreferences.setMockInitialValues(values);

      // Login
      final result = await auth.login('john@mail.com', 'changeme');
      expect(result, isTrue);

      // Verifico si tiene token
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token')!;
      expect(token, isNotEmpty);

      // Verifico el Token
      final res = await auth.auth();
      expect(res, isTrue);

      // Verifico el usuario
      expect(auth.usuario, isA<ResponseUsuario>());
      expect(auth.usuario!.email!, 'john@mail.com');

      // Verifico info del usuario en shared_preference
      expect(prefs.getString('email'), 'john@mail.com');

      // Logout y reviso que no quede información
      await auth.logout();
      expect(prefs.getString('email'), isNull);
      expect(prefs.getString('name'), isNull);
      expect(prefs.getString('role'), isNull);
      expect(prefs.getString('token'), isNull);
      expect(auth.usuario, isNull);
      expect(auth.message, 'Logout');
    });
  });
}
