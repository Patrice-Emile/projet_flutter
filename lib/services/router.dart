import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';

class RouterService {
  static GoRouter getRoutes() {
    return GoRouter(
      routes: [
        GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => HomeScreen()
        ),
      ],
    );
  }
}
