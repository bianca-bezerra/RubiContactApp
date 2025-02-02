import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps/routing/routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'App de contatos',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/ifpilogo.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => {GoRouter.of(context).push(Routes.map)},
                  child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.orangeAccent,
                    child: const Center(
                      child: Text(
                        'Mapa',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(//TODO: Aparentemente esse jeito de pegar os toques tá defasado
                  onTap: () => {GoRouter.of(context).push(Routes.contactsList)},
                  child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.orangeAccent,
                    child: const Center(
                      child: Text(
                        'Contatos',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
