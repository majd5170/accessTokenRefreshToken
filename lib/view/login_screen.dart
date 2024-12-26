import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testrefrashtoken/cubit/auth_cubit.dart';
import 'package:testrefrashtoken/view/home_screen.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Login successful! Token: ${state.authResponse.token}')),  
           );
                  Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>  UserListPage(),
            ),
          );
           print(' ${state.authResponse.trustDevice}');
           print(' ${state.authResponse.token}');
           print(' ${state.authResponse.refreshToken}');
           print(' ${state.authResponse.password}');
           print(' ${state.authResponse.mobileNumber}');
           print(' ${state.authResponse.fcmToken}');
           print(' ${state.authResponse.email}');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'email'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final email = emailController.text;
                    final password = passwordController.text;
                    context.read<AuthCubit>().login(email, password);
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}