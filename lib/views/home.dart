import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps/assets.dart';
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
              Assets.logoIfpi,
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
                    width: 180,
                    height: 180,
                     decoration: BoxDecoration(
                      color: Colors.amber,
                      border: Border.all(
                        width: 8, color: Colors.transparent
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Center(
                      child: Text(
                        'Mapa',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  //TODO: Aparentemente esse jeito de pegar os toques tá defasado
                  onTap: () => {GoRouter.of(context).push(Routes.contactsList)},
                  child: Container(
                    width: 180,
                    height: 180,
                     decoration: BoxDecoration(
                      color: Colors.amber,
                      border: Border.all(
                        width: 8, color: Colors.transparent
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
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
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => {GoRouter.of(context).push(Routes.login)},
                  child: Container(
                    width: 180,
                    height: 180,
                     decoration: BoxDecoration(
                      color: Colors.amber,
                      border: Border.all(
                        width: 8, color: Colors.transparent
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                 const SizedBox(width: 20),
                GestureDetector(
                  onTap: () =>
                      {GoRouter.of(context).push(Routes.createContact)},
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      border: Border.all(
                        width: 8, color: Colors.transparent
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Center(
                      child: Text(
                        'Criar contato',
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
