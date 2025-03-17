import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobile_abz/app/router/app_router.dart';
import 'package:mobile_abz/app/themes/app_colors.dart';
import 'package:mobile_abz/app/themes/text_themes.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton<AppRouter>(AppRouter());
  await initializeDateFormatting('ru', null);
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
        fontFamily: 'EuclidCircularA',
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
