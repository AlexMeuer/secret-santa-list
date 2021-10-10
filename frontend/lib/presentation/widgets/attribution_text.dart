import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AttributionText extends StatelessWidget {
  const AttributionText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: const TextStyle(
          color: Colors.white,
        ),
        children: [
          TextSpan(
            children: [
              WidgetSpan(
                alignment: PlaceholderAlignment.top,
                child: FaIcon(
                  FontAwesomeIcons.github,
                  size: Theme.of(context).textTheme.bodyText1?.fontSize,
                  color: Colors.white,
                ),
              ),
              TextSpan(
                text: " Made by AlexMeuer",
                mouseCursor: SystemMouseCursors.click,
                recognizer: TapGestureRecognizer()..onTap = launchSourceUrl,
              ),
            ],
          ),
          const TextSpan(text: "  |  "),
          TextSpan(
            mouseCursor: SystemMouseCursors.click,
            recognizer: TapGestureRecognizer()..onTap = launchLicenseUrl,
            text: "Licensed under AGPLv3",
          ),
        ],
      ),
    );
  }

  static void launchSourceUrl() =>
      launch("https://github.com/alexmeuer/secret-santa-list");

  static void launchLicenseUrl() =>
      launch("https://www.gnu.org/licenses/agpl-3.0.en.html");
}
