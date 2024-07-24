import 'package:flareline/components/tags/tag_widget.dart';
import 'package:flutter/material.dart';

import 'package:flareline/components/card/white_card.dart';
import 'package:flareline/themes/global_colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopChannelWidget extends StatelessWidget {
  const TopChannelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return WhiteCard(
        child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SOS Contacts',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
              child: ChangeNotifierProvider(
            create: (context) => _DataProvider(),
            builder: (ctx, child) => _buildWidget(ctx),
          )),
        ],
      ),
    ));
  }

  _buildWidget(BuildContext context) {
    return FutureBuilder<List<Channel>>(
        future: context.read<_DataProvider>().loadData(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null) {
            return Text(AppLocalizations.of(context)!.loading);
          }

          return ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.infinity),
              child:DataTable(
          headingRowColor: MaterialStateProperty.resolveWith((states) => lightGray),
          horizontalMargin: 12,
          showBottomBorder: true,
          showCheckboxColumn: false,
          headingTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          ),
          dividerThickness: 0.5,
          columns: [
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Phoneno')),
          DataColumn(label: Text('Relation')),
          DataColumn(label: Text('City')),
          DataColumn(label: Text('Age')),
          DataColumn(label: Text('Actions')), // New DataColumn for edit/delete buttons
          ],
          rows: context.watch<_DataProvider>().channels.map((e) {
          return DataRow(
          onSelectChanged: (selected) {},
          cells: [
          DataCell(Text(e.Name)),
          DataCell(Text(e.Phoneno)),
          DataCell(TagWidget(text: e.Relation)),
          DataCell(Text(e.City)),
          DataCell(TagWidget(text: e.Age, tagType: TagType.Secondary)),
          DataCell(
          Row( // Row for edit/delete buttons
          children: [
          IconButton(
          icon: Icon(Icons.edit, color: Colors.green,),
          onPressed: () {
          // Handle edit action
          // You can use e to get the data of the current row
          // For example: Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(data: e)));
          },
          ),
          IconButton(
          icon: Icon(Icons.delete, color: Colors.red,),
          onPressed: () {
          // Handle delete action
          // You can use e to get the data of the current row
          // For example: _dataProvider.deleteData(e);
          },
          ),
          ],
          ),
          ),
          ],
          );
          }).toList(),
          ),);

        }));
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Channel {
  /// Creates the employee class with required details.
  Channel(this.Name, this.Phoneno, this.Relation, this.City,
      this.Age);

  /// Id of an employee.
  final String Name;

  /// Name of an employee.
  final String Phoneno;

  /// Designation of an employee.
  final String Relation;

  /// Salary of an employee.
  final String City;

  final String Age;
}

class _DataProvider extends ChangeNotifier {
  List<Channel> channels = <Channel>[];

  List<Channel> getEmployeeData() {
    return [
      Channel('Karishma Suryawanshi', '9197293732', 'Sister', 'Pune', '30'),
      Channel('Nita Suryawanshi', '91263972911`', 'Mother', 'Nashik', '52'),
      Channel('Chetan Patil', '62786382984', 'Dad', 'Nashik', '58'),
      Channel('Shreyas Jadhav', '376246193974', 'Friend', 'Nashik', '22'),
      Channel('Abhay Rajput', '253651638747', 'friend', 'Pune', '21'),
      Channel('Madhura Patil', '3416522718', 'Friend', 'Pune', '21'),
    ];
  }

  Future<List<Channel>> loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    channels = getEmployeeData();
    return channels;
  }
}
