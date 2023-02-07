import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        DataTable(
            showBottomBorder: true,
            dataRowColor: MaterialStateProperty.resolveWith(
                (states) => const Color.fromARGB(170, 255, 255, 255)),
            border: TableBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            headingRowColor: MaterialStateProperty.resolveWith(
              (states) => const Color(0xFF224480),
            ),
            columns: const [
              DataColumn(
                  label: Text(
                'ลำดับ',
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
              DataColumn(
                  label: Text(
                'ประเภทฐานความผิด',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              )),
              DataColumn(
                  label: Text(
                'วันที่พบเบาแส',
                style: TextStyle(color: Colors.white),
              )),
              DataColumn(
                  label: Text(
                'ผู้แจ้งเบาะแส',
                style: TextStyle(color: Colors.white),
              )),
              DataColumn(
                  label: Text(
                'การทำงาน',
                style: TextStyle(color: Colors.white),
              )),
            ],
            rows: [
              DataRow.byIndex(cells: [
                const DataCell(Text('0')),
                const DataCell(Text(
                    'คดีความผิดตามกฎหมายว่าด้วยการกู้ยืมเงินที่เป็นการฉ้อโกงประชาชน')),
                DataCell(Text("${DateTime.now()}")),
                const DataCell(Text('อรอนงค์ คงดำ')),
                DataCell(Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.visibility_rounded),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.print_rounded),
                    ),
                  ],
                )),
              ]),
              DataRow(cells: [
                const DataCell(Text('1')),
                const DataCell(Text(
                    'คดีความผิดตามกฎหมายว่าด้วยการควบคุมการแลกเปลี่ยนเงิน')),
                DataCell(Text('${DateTime.now()}')),
                const DataCell(Text('')),
                DataCell(Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.visibility_rounded,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.print_rounded),
                    ),
                  ],
                )),
              ]),
              DataRow(cells: [
                const DataCell(Text('2')),
                const DataCell(Text(
                    'คดีความผิดตามกฎหมายว่าด้วยการป้องกันและปราบปรามการฟอกเงิน')),
                DataCell(Text('${DateTime.now()}')),
                const DataCell(
                  Text('กรรภิรมย์ เหล็มนุ่ย'),
                ),
                DataCell(Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.visibility_rounded),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.print_rounded),
                    ),
                  ],
                )),
              ]),
            ])
      ]),
    );
  }
}
