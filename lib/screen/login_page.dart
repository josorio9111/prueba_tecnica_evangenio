import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica_evangenio/provider/auth_provider.dart';
import 'package:prueba_tecnica_evangenio/provider/login_provider.dart';
import 'package:prueba_tecnica_evangenio/widgets/text_field.dart';

// email: john@mail.com
// password: changeme

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (_) => LoginProvider(),
      builder: (context, __) {
        final TextTheme textTheme = Theme.of(context).textTheme;
        final controller = Provider.of<LoginProvider>(context, listen: true);

        // Valores por defecto para hacer el login
        controller.setEmail('john@mail.com');
        controller.setPassword('changeme');

        return Scaffold(
          backgroundColor: const Color(0xfff2f2f2),
          body: SafeArea(
              child: Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Container(
                // color: Colors.blue,
                constraints: const BoxConstraints(maxWidth: 500),
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Icon(Icons.person_pin_circle_outlined,
                            size: 100, color: Colors.blue[300]),
                        Text(
                          'Login',
                          style: textTheme.headline4,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Column(
                      children: [
                        FieldText(
                          controller: TextEditingController()
                            ..text = controller.email,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: controller.setEmail,
                          hintText: 'Email',
                          icon: Icons.email_outlined,
                        ),
                        FieldText(
                          controller: TextEditingController()
                            ..text = controller.email,
                          textInputAction: TextInputAction.go,
                          onChanged: controller.setPassword,
                          hintText: 'Password',
                          icon: Icons.lock_outline,
                          obscureText: true,
                          onSubmitted: (_) {},
                        ),
                        const SizedBox(height: 10),
                        Selector<AuthProvider, bool>(
                            selector: (_, p1) => p1.loadding,
                            builder: (_, value, __) {
                              if (value) {
                                return const SizedBox(
                                    width: 200,
                                    child: LinearProgressIndicator());
                              }
                              return const SizedBox.shrink();
                            }),
                        const SizedBox(height: 10),
                        CupertinoButton(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.blue,
                          onPressed: () async {
                            final provider = Provider.of<AuthProvider>(context,
                                listen: false);
                            final result = await provider.login(
                                controller.email, controller.password);
                            if (!mounted) return;
                            if (!result) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(provider.message,
                                          style: textTheme.headline5?.copyWith(
                                              color: Colors.white))));
                            } else {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, 'home', (_) => false);
                            }
                          },
                          child: Text(
                            'Ingresar',
                            style: textTheme.headline6
                                ?.copyWith(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
        );
      },
    );
  }
}
