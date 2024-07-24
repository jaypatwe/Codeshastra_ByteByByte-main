import 'package:flareline/components/badge/anim_badge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

class ToolBarWidget extends StatelessWidget {
  const ToolBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _toolsBarWidget(context);
  }

  _toolsBarWidget(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Row(children: [
        ResponsiveBuilder(builder: (context, sizingInformation) {
          // Check the sizing information here and return your UI
          if (sizingInformation.deviceScreenType != DeviceScreenType.desktop) {
            return InkWell(
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200, width: 1)),
                alignment: Alignment.center,
                child: const Icon(Icons.more_vert),
              ),
              onTap: () {
                if (Scaffold.of(context).isDrawerOpen) {
                  Scaffold.of(context).closeDrawer();
                  return;
                }
                Scaffold.of(context).openDrawer();
              },
            );
          }

          return const SizedBox();
        }),
        ResponsiveBuilder(builder: (context, sizingInformation) {
          // Check the sizing information here and return your UI
          if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
            return const SizedBox(
              width: 200,
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.transparent,
                  prefixIcon: Icon(Icons.search_rounded),
                  // suffixIcon: Icon(Icons.clear),
                  hintStyle: TextStyle(fontSize: 10),
                  // labelText: 'Type to search...',
                  hintText: 'Type to search...',
                  // helperText: 'Type to search...',
                  filled: true,
                ),
              ),
            );
          }

          return const SizedBox();
        }),
        const Spacer(),
        InkWell(
          child: Container(
            margin: const EdgeInsets.only(left: 6),
            child: const Icon(Icons.notifications, color: Colors.blue,),
          ),
          onTap: () async {
            await showMenu(
                color: Colors.white,
                context: context,
                position: RelativeRect.fromLTRB(
                    MediaQuery.of(context).size.width - 100, 80, 250, 0),
                items:const [
                  PopupMenuItem(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            '8/5 Pumps Used',
                            style: TextStyle(
                              fontSize: 20, // Adjust size as needed
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 10), // Adjust spacing as needed
                        Card(
                          child: Row(
                            children: [
                              SizedBox(width: 5,),
                              Icon(Icons.add_alert, color: Colors.red,),
                              SizedBox(width: 15,),
                              Expanded(child: Text('Max number of daily allowed pumps used!'))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]);
          },
        ),

        const SizedBox(
          width: 35,
        ),
        InkWell(
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              InkWell(
                child: Container(
                  width: 34,
                  height: 34,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.blue, // You can set your desired color here
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/toolbar/alarm.png',
                    width: 38,
                    height: 28,
                  ),
                ),
                onTap: () async{
                  const snackBar = SnackBar(
                    content: Text('SOS Contacted!'),
                    backgroundColor: Colors.red,
                  );

                  if(kIsWeb){
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }else{
                    Uri phoneno = Uri.parse('tel:+97798345348734');
                    if (await launchUrl(phoneno)) {
                    }else{
                      print('error opening dialer');
                    }
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
              ),
              const Align(
                child: AnimBadge(),
              )
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const SizedBox(
          width: 20,
        ),
        const Column(
          children: [
            Text('Ruchika'),
            Text('Suryawanshi'),
          ],
        ),
        const SizedBox(
          width: 5,
        ),
        const CircleAvatar(
          backgroundImage: AssetImage('assets/user/user-10.png'),
          radius: 22,
        ),
      ]),
    );
  }

// Widget _languagesWidget(BuildContext context) {
//   return Wrap(
//     spacing: 8,
//     runSpacing: 8,
//     children: AppLocalizations.supportedLocales.map((e) {
//       return SizedBox(
//         width: 50,
//         height: 20,
//         child:
//         Consumer<LocalizationProvider>(builder: (ctx, provider, child) {
//           return ButtonWidget(
//             btnText: e.languageCode,
//             isPrimary: e.languageCode == provider.languageCode,
//             onTap: () {
//               context.read<LocalizationProvider>().locale = e;
//             },
//           );
//         }),
//       );
//     }).toList(),
//   );
// }
}