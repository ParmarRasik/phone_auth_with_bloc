import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_with_bloc/cubits/auth_cubit.dart';
import 'package:phone_auth_with_bloc/cubits/auth_state.dart';
import 'package:phone_auth_with_bloc/screens/home_screen.dart';

class VerifyPhoneScreen extends StatelessWidget {
  VerifyPhoneScreen({super.key});
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Phone Number", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: ListView(
              children: [
                TextField(
                  controller: otpController,
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "6 Digit OTP", border: OutlineInputBorder(), counterText: ""),
                ),
                const SizedBox(
                  height: 25,
                ),
                BlocConsumer<AuthCubit,AuthState>(
                  listener: (context, state) {
                    if(state is AuthLogedInState){
                      Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => const HomeScreen(),));
                    }else if(state is AuthErrorState){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error),backgroundColor: Colors.red,
                      ));
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
                        BlocProvider.of<AuthCubit>(context).verifyOTP(otpController.text);
                      }, color: Colors.blue, child: const Text("Verify")),
                    );
                  }
                )
              ],
            ),
          )),
    );
  }
}