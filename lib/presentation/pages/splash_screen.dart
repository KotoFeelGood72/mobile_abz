// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 3), () {
//       Navigator.pushReplacementNamed(context, '/home');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           // Фоновое изображение
//           Image.asset(
//             "assets/splash_bg.jpg",
//             fit: BoxFit.cover,
//           ),
//           // Затемнённый слой
//           Container(color: Colors.black.withOpacity(0.6)),
//           // Контент
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Добро пожаловать 👋",
//                 ).animate().fade(duration: 600.ms).slideY(begin: 0.2),
//                 const SizedBox(height: 10),
//                 Text(
//                   "АвтоБезЗабот",
//                 ).animate().fade(duration: 800.ms).slideY(begin: 0.2),
//                 const SizedBox(height: 15),
//                 Text(
//                   "Твой карманный автопарк.\nНезаменимый помощник для отслеживания состояния твоего автомобиля.",
//                 ).animate().fade(duration: 1000.ms).slideY(begin: 0.2),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
