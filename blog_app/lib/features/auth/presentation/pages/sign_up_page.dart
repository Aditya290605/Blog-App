import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:blog_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:blog_app/features/auth/presentation/screens/home_screen.dart';
import 'package:blog_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:blog_app/features/auth/presentation/widgets/custom_textfeild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static route() => MaterialPageRoute(builder: (context) => const SignUpPage());

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppPallete.backgroundColor),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder:
                    (context) => HomeScreen(
                      userId: state.user.id,
                      name: state.user.name,
                    ),
              ),
              (route) => false,
            );
          }

          if (state is AuthFailure) {
            debugPrint(state.error);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Sign Up .',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextfeild(hintText: 'Name', controller: nameController),
                  const SizedBox(height: 20),
                  CustomTextfeild(
                    hintText: 'Email',
                    controller: emailController,
                  ),
                  const SizedBox(height: 20),
                  CustomTextfeild(
                    hintText: 'Password',
                    obscureText: true,
                    controller: passwordController,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Sign up',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthSignUp(
                            email: emailController.text,
                            name: nameController.text,
                            password: passwordController.text,
                          ),
                        );
                      }
                      debugPrint('Sign Up Button Pressed');
                    },
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(SignInPage.route()),
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: const TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
