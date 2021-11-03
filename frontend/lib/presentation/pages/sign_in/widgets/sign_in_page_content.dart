import 'package:flutter/material.dart';
import 'package:secret_santa_list/presentation/pages/sign_in/widgets/name_input.dart';

class SignInPageContent extends StatelessWidget {
  const SignInPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.all(8),
              child: NameInput(),
            ),
          ],
        ),
      ),
    );
  }
}
