import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica_evangenio/provider/auth_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final controller = Provider.of<AuthProvider>(context, listen: false);
    controller.auth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('HomePage'),
        actions: [
          IconButton(
              onPressed: () async {
                final provider =
                    Provider.of<AuthProvider>(context, listen: false);
                await provider.logout();
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(provider.message,
                        style: textTheme.headline5
                            ?.copyWith(color: Colors.white))));
                Navigator.pushReplacementNamed(context, 'login');
                provider.nitify();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Consumer<AuthProvider>(
          builder: (_, value, __) {
            TextTheme textTheme = Theme.of(context).textTheme;
            return Column(
              children: [
                if (value.usuario != null) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            NetworkImage(value.usuario!.avatar.toString()),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value.usuario!.name.toString(),
                            style: textTheme.headline5,
                          ),
                          Text(
                            value.usuario!.email.toString(),
                            style: textTheme.bodyText1,
                          ),
                          Text(
                            value.usuario!.role.toString(),
                            style: textTheme.caption,
                          )
                        ],
                      )
                    ],
                  )
                ]
              ],
            );
          },
        ),
      ),
    );
  }
}
