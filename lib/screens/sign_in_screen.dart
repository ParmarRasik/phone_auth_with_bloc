import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_with_bloc/cubits/auth_cubit.dart';
import 'package:phone_auth_with_bloc/cubits/auth_state.dart';
import 'package:phone_auth_with_bloc/screens/verify_phone_number.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in with phone", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Phone number", border: OutlineInputBorder(), counterText: ""),
            ),
            const SizedBox(
              height: 25,
            ),
            BlocConsumer<AuthCubit,AuthState>(
              listener: (context, state) {
                if(state is AuthCodeSentState){
                  Navigator.push(context, CupertinoPageRoute(builder: (context)=> VerifyPhoneScreen()));
                }
              },
              builder: (context, state) {
                if(state is AuthLoadingState){
                  return const Center(child: CircularProgressIndicator(),);
                }
                return SizedBox(
                  width: width,
                  height: 55,
                  child: CupertinoButton(onPressed: () {
                    BlocProvider.of<AuthCubit>(context).sendOTP("+91${phoneController.text}");
                  }, color: Colors.blue, child: const Text("Sign In")),
                );
              }
            )
          ],
        ),
      )),
    );
  }
}
