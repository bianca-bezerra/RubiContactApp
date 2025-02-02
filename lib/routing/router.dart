import 'package:go_router/go_router.dart';
import 'package:google_maps/controllers/contacts_controller.dart';
import 'package:google_maps/controllers/home_controller.dart';
import 'package:google_maps/controllers/login_controller.dart';
import 'package:google_maps/controllers/map_controller.dart';
import 'package:google_maps/routing/routes.dart';
import 'package:google_maps/views/contact_create.dart';

final router = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
        path: Routes.login,
        builder: (context, state) => const LoginController()),
    GoRoute(
        path: Routes.map,
        builder: (context, state) => const MapPageController()),
    GoRoute(
        path: Routes.contactsList,
        builder: (context, state) => const ContactListController()),
    GoRoute(
        path: Routes.home, builder: (context, state) => const HomeController()),
    GoRoute(
        path: Routes.createContact,
        builder: (context, state) => ContactCreateView()),
  ],
);
