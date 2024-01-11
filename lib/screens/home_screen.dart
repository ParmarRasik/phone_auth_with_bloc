import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_with_bloc/cubits/auth_state.dart';
import 'package:phone_auth_with_bloc/screens/sign_in_screen.dart';

import '../cubits/auth_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home", style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Center(
            child: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
              if (state is AuthLogOutState) {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => SignInScreen()));
              }
            }, builder: (context, state) {
              return SizedBox(
                width: width / 2,
                height: 55,
                child: CupertinoButton(
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(context).logout();
                    },
                    color: Colors.blue,
                    child: const Text("Log out")),
              );
            }),
          ),
        ));
  }
}
