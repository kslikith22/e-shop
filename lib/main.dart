import 'package:e_shop/core/routes.dart';
import 'package:e_shop/firebase_options.dart';
import 'package:e_shop/providers/product_provider.dart';
import 'package:e_shop/providers/user_provider.dart';
import 'package:e_shop/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.onGenerate,
        initialRoute: '/',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: "Poppins",
        ),
        home: SplashScreen(),
      ),
    );
  }
}
