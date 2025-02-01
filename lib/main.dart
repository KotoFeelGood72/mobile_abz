import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_abz/app/router/app_router.dart';
import 'package:mobile_abz/app/themes/app_colors.dart';
import 'package:mobile_abz/app/themes/text_themes.dart';
import 'firebase_options.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton<AppRouter>(AppRouter());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: 'assets/.env');
  runApp(
    const ProviderScope(observers: [], child: ABZAuto()),
  );
}

class ABZAuto extends StatelessWidget {
  const ABZAuto({super.key});
  @override
  Widget build(BuildContext context) {
    final appRouter = getIt<AppRouter>();
    return MaterialApp.router(
      theme: ThemeData(
        textTheme: buildTextTheme(),
        scaffoldBackgroundColor: AppColors.black,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.config(
        navigatorObservers: () => [],
      ),
    );
  }
}
