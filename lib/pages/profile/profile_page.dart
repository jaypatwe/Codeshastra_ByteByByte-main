import 'package:flutter/material.dart';

import 'package:flareline/pages/layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends LayoutWidget {
  const ProfilePage({super.key});

  @override
  String breakTabTitle(BuildContext context) {
    // TODO: implement title
    return AppLocalizations.of(context)!.profile;
  }

  @override
  Widget contentDesktopWidget(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(children: [
        SizedBox(
          height: 180,
          child: Stack(children: [
            Image.asset(
              'assets/cover/cover-01.png',
              height: 180,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
          ]),
        ),
        Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 130,
              ),
              Stack(children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.black54,
                  child: Image.asset('assets/user/user-10.png'),
                ),
              ]),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Ruchika Suryawanshi',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'City: Pune, Maharashtra',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Age: 21',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Weight: 46kg',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'BMI: 18',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 16,
              ),

            ],
          ),
        )
      ]),
    );
  }
}