import 'package:flutter/material.dart';

class ListsPage extends StatelessWidget {
  const ListsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lists & Data'),
          bottom: const TabBar(
            tabs: [Tab(text: 'List'), Tab(text: 'Grid'), Tab(text: 'Table')],
          ),
        ),
        body: TabBarView(
          children: [
            // List tab
            ListView.builder(
              itemCount: 15,
              itemBuilder: (_, i) => ListTile(
                leading: CircleAvatar(child: Text('${i + 1}')),
                title: Text('Item ${i + 1}', style: textTheme.titleSmall),
                subtitle: Text('Subtitle for item ${i + 1}', style: textTheme.bodySmall),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
            // Grid tab
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: 24,
              itemBuilder: (_, i) => Container(
                color: i.isEven ? colorScheme.surfaceContainerHighest : colorScheme.surfaceContainer,
                child: Center(child: Text('${i + 1}', style: textTheme.labelSmall)),
              ),
            ),
            // Table tab
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Role')),
                    DataColumn(label: Text('Dept')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Since')),
                  ],
                  rows: const [
                    DataRow(cells: [DataCell(Text('Alice')), DataCell(Text('Designer')), DataCell(Text('UX')), DataCell(Text('Active')), DataCell(Text('2022'))]),
                    DataRow(cells: [DataCell(Text('Bob')), DataCell(Text('Engineer')), DataCell(Text('Mobile')), DataCell(Text('Active')), DataCell(Text('2021'))]),
                    DataRow(cells: [DataCell(Text('Carol')), DataCell(Text('PM')), DataCell(Text('Product')), DataCell(Text('Active')), DataCell(Text('2020'))]),
                    DataRow(cells: [DataCell(Text('Dave')), DataCell(Text('Engineer')), DataCell(Text('Web')), DataCell(Text('Away')), DataCell(Text('2023'))]),
                    DataRow(cells: [DataCell(Text('Eve')), DataCell(Text('Designer')), DataCell(Text('Brand')), DataCell(Text('Active')), DataCell(Text('2022'))]),
                    DataRow(cells: [DataCell(Text('Frank')), DataCell(Text('QA')), DataCell(Text('Quality')), DataCell(Text('Active')), DataCell(Text('2021'))]),
                    DataRow(cells: [DataCell(Text('Grace')), DataCell(Text('Lead')), DataCell(Text('Mobile')), DataCell(Text('Active')), DataCell(Text('2019'))]),
                    DataRow(cells: [DataCell(Text('Hank')), DataCell(Text('DevOps')), DataCell(Text('Infra')), DataCell(Text('Away')), DataCell(Text('2020'))]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
