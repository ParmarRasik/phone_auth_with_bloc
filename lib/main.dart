import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_with_bloc/cubits/auth_cubit.dart';
import 'package:phone_auth_with_bloc/cubits/auth_state.dart';
import 'package:phone_auth_with_bloc/screens/home_screen.dart';
import 'package:phone_auth_with_bloc/screens/sign_in_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(apiKey: "AIzaSyAPnnwOhjTKujiQ2XwEccRUsQkas9jSom0",
      appId: "1:541876959126:android:91965a4a8b9018632a0fb7",
      messagingSenderId: "541876959126", projectId: "news-app-621ff"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
      child: MaterialApp(
          title: 'Phone Auth',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            appBarTheme: const AppBarTheme(color: Colors.blue),
            useMaterial3: true,
          ),
          home: BlocBuilder<AuthCubit,AuthState>(
            buildWhen: (previous, current) => previous is AuthInitialState,
            builder: (context,state) {
              if(state is AuthLogedInState){
                return const HomeScreen();
              }
              return SignInScreen();
            }
          ),
        )
    );
  }
}
