import 'package:flutter/material.dart';
import 'package:flareline/pages/layout.dart';
import 'package:flareline/themes/global_colors.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CalendarPage extends LayoutWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  String breakTabTitle(BuildContext context) {
    return AppLocalizations.of(context)!.calendarPageTitle;
  }

  @override
  Widget contentDesktopWidget(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 80),
      height: 800,
      child: SfCalendar(
        view: CalendarView.month,
        todayTextStyle: const TextStyle(color: primary),
        todayHighlightColor: Colors.white,
        headerStyle: const CalendarHeaderStyle(
          backgroundColor: Colors.transparent,
        ),
        monthViewSettings: const MonthViewSettings(
          showAgenda: true,
          dayFormat: 'EEEE',
          agendaViewHeight: 200,
          agendaStyle: AgendaStyle(
            backgroundColor: Colors.white,
            appointmentTextStyle: TextStyle(color: red),
          ),
        ),
        viewHeaderHeight: 60,
        headerHeight: 60,
        viewHeaderStyle: const ViewHeaderStyle(
          backgroundColor: primary,
          dayTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onTap: (calendarTapDetails) {
          // Show a dialog to add medication details and reminder
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Add Medication'),
                content: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(labelText: 'Medication Name'),
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Dosage'),
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Time'),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Add logic to save medication details and reminder
                      // For example, you can use a database to store the data
                      Navigator.of(context).pop();
                    },
                    child: Text('Save'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
