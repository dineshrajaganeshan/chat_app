import 'package:chat_app/Screens/chat_screen/chat_screen.dart';
import 'package:chat_app/Screens/home_screen/home_screen.dart';
import 'package:chat_app/routes/app_routes.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../Screens/contact_screen/contact_screen.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.HOMESCREEN, page: () => HomeScreen()),
    GetPage(name: AppRoutes.CONTACTSCREEN, page: () => ContactScreen()),
    GetPage(name: AppRoutes.CHATSCREEN, page: () => ChatScreen()),
  ];
}
