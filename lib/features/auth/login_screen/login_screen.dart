import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddity/core/common/loader.dart';
import 'package:reddity/core/common/sign_in_button.dart';
import 'package:reddity/core/constants/constants.dart';
import 'package:reddity/features/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  //WidgetRef will allow us to interact with other providers
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            Constants.logoPath,
            height: 40,
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text(
                'Skip',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        body: isLoading
            ? const Loader()
            : Column(
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Text(
                    'Dive into anything',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      Constants.logoEmotePath,
                      height: 400,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const SignInButton()
                ],
              ));
  }
}
