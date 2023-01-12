import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisata_jogja/providers/favorite_provider.dart';
import 'package:wisata_jogja/providers/objek_provider.dart';
import 'package:wisata_jogja/providers/page_provider.dart';
import 'package:wisata_jogja/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ObjekProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
