import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testrefrashtoken/cubit/auth_cubit.dart';
import 'package:testrefrashtoken/view/home_screen.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Login successful! Token: ${state.authResponse}')),  
           );
                  Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
          //  print('ccessful! Token: ${state.authResponse.accessToken}');
          //  print('ccessful! Token: ${state.authResponse.accessToken}');
           print('ccessful! Token: ${state.authResponse.username}');
           print('ccessful! Token: ${state.authResponse.email}');
           print('ccessful! Token: ${state.authResponse.firstName}');
           print('ccessful! Token: ${state.authResponse.lastName}');
           print('ccessful! Token: ${state.authResponse.gender}');
            // Navigate to the home page or show success message
          } else if (state is AuthError) {
            // Show error message
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
                  controller: usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final username = usernameController.text;
                    final password = passwordController.text;
                    context.read<AuthCubit>().login(username, password);
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