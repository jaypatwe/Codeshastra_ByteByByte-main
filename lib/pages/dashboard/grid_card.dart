import 'package:flutter/material.dart';
import 'package:flareline/components/card/white_card.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GridCard extends StatelessWidget {
  const GridCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: contentDesktopWidget,
      mobile: contentMobileWidget,
      tablet: contentMobileWidget,
    );
  }

  Widget contentDesktopWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: _itemCardWidget(
                Icons.check_box, 'No of Correct Pumps', '43', '80.00%', true)),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            child: _itemCardWidget(
                Icons.highlight_remove, 'No of Incorrect Pumps', '11', '20.37%', false)),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            child: _itemCardWidget(
                Icons.text_rotation_angleup, 'Perfect orientation', '22', '~50.0%', true)),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            child: _itemCardWidget(Icons.vibration, 'No. of Shakes',
                'Mean', '~6', true)),
      ],
    );
  }

  Widget contentMobileWidget(BuildContext context) {
    return Column(
      children: [
        _itemCardWidget(
            Icons.data_object, '\$3.456K', AppLocalizations.of(context)!.totalViews, '0.43%', true),
        const SizedBox(
          height: 16,
        ),
        _itemCardWidget(
            Icons.shopping_cart, '\$45.2K', AppLocalizations.of(context)!.totalProfit, '0.43%', true),
        const SizedBox(
          height: 16,
        ),
        _itemCardWidget(Icons.group, '2.450', AppLocalizations.of(context)!.totalProduct, '0.43%', true),
        const SizedBox(
          height: 16,
        ),
        _itemCardWidget(
            Icons.security_rounded, '3.456', AppLocalizations.of(context)!.totalUsers, '0.43%', false),
      ],
    );
  }

  _itemCardWidget(IconData icons, String text, String subTitle,
      String percentText, bool isGrow) {
    return WhiteCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                child: Icon(icons),
                color: Colors.grey.shade200,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                Text(
                  subTitle,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
                const Spacer(),
                Text(
                  percentText,
                  style: TextStyle(
                      fontSize: 10,
                      color: isGrow ? Colors.green : Colors.lightBlue),
                ),
                const SizedBox(
                  width: 3,
                ),
                Icon(
                  isGrow ? Icons.arrow_upward : Icons.arrow_downward,
                  color: isGrow ? Colors.green : Colors.lightBlue,
                  size: 12,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
