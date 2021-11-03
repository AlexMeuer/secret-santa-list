import 'package:flutter/material.dart';
import 'package:secret_santa_list/application/sign_in/sign_in_bloc.dart';
import 'package:secret_santa_list/presentation/pages/sign_in/widgets/sign_in_page_content.dart';
import 'package:secret_santa_list/presentation/widgets/get_it_bloc_provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xFFDE4DAA),
              Color(0xFFF6D327),
            ],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: SingleChildScrollView(
              child: GetItBlocProvider<SignInBloc>(
                child: const SignInPageContent(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
