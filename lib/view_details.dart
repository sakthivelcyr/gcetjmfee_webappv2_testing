import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gcetjmfee_webappv2/stu_record.dart';
import 'package:gcetjmfee_webappv2/style.dart';
import 'package:gcetjmfee_webappv2/title.dart';

class StudentDetails extends StatefulWidget {
  DocumentSnapshot d;
  StudentDetails(this.d);
  //StudentDetails({Key key}) : super(key: key);

  @override
  _StudentDetailsState createState() => _StudentDetailsState(d);
}

class _StudentDetailsState extends State<StudentDetails> {
  DocumentSnapshot d;
  _StudentDetailsState(this.d);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => StudentRecord(),
        ),
      ),
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                title(size, d['sName'], context),
                Container(
                  height: size.height / 1.24,
                  width: size.width,
                  padding: EdgeInsets.all(20),
                  child: Card(
                    child: DataTable(
                      columns: [
                        DataColumn(
                            label: Text(d['rollNum'],
                                style:
                                    Style.columnStyle.copyWith(fontSize: 28))),
                        DataColumn(
                            label: Text(d['sName'],
                                style:
                                    Style.columnStyle.copyWith(fontSize: 28))),
                        DataColumn(
                            label: Text(d['regNum'],
                                style:
                                    Style.columnStyle.copyWith(fontSize: 28))),
                        DataColumn(label: Text(''))
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(
                            Text(
                              'Student Details',
                              style: Style.detailsHeadStyle,
                            ),
                          ),
                          DataCell(Text('')),
                          DataCell(
                            Text(
                              'College Details',
                              style: Style.detailsHeadStyle,
                            ),
                          ),
                          DataCell(Text('')),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            Text('Name', style: Style.cellStyle),
                          ),
                          DataCell(
                            d['sName'] == null
                                ? Text('No Data')
                                : Text(d['sName'], style: Style.cellStyle),
                          ),
                          DataCell(
                            Text('Register Number', style: Style.cellStyle),
                          ),
                          DataCell(
                            d['regNum'] == null
                                ? Text('No Data')
                                : Text(d['regNum'], style: Style.cellStyle),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            Text('Gender', style: Style.cellStyle),
                          ),
                          DataCell(
                            d['sGender'] == null
                                ? Text('No Data')
                                : Text(d['sGender'], style: Style.cellStyle),
                          ),
                          DataCell(
                            Text('Roll Number', style: Style.cellStyle),
                          ),
                          DataCell(
                            d['rollNum'] == null
                                ? Text('No Data')
                                : Text(d['rollNum'], style: Style.cellStyle),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            Text('DOB', style: Style.cellStyle),
                          ),
                          DataCell(
                            d['sDOB'] == null
                                ? Text('No Data')
                                : Text(d['sDOB'], style: Style.cellStyle),
                          ),
                          DataCell(
                            Text('Batch', style: Style.cellStyle),
                          ),
                          DataCell(
                            d['batch'] == null
                                ? Text('No Data')
                                : Text(d['batch'], style: Style.cellStyle),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            Text('Blood Group', style: Style.cellStyle),
                          ),
                          DataCell(
                            d['sBG'] == null
                                ? Text('No Data')
                                : Text(d['sBG'], style: Style.cellStyle),
                          ),
                          DataCell(
                            Text('Branch', style: Style.cellStyle),
                          ),
                          DataCell(
                            d['branch'] == null
                                ? Text('No Data')
                                : Text(d['branch'], style: Style.cellStyle),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            Text('Mail Id', style: Style.cellStyle),
                          ),
                          DataCell(
                            d['sMail'] == null
                                ? Text('No Data')
                                : Text(d['sMail'], style: Style.cellStyle),
                          ),
                          DataCell(Text('')),
                          DataCell(Text('')),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            Text('Mobile Number', style: Style.cellStyle),
                          ),
                          DataCell(
                            d['sMobNum'] == null
                                ? Text('No Data')
                                : Text(d['sMobNum'], style: Style.cellStyle),
                          ),
                          DataCell(
                            Text(
                              'Hostel Details',
                              style: Style.detailsHeadStyle,
                            ),
                          ),
                          DataCell(Text('')),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            Text('Address', style: Style.cellStyle),
                          ),
                          DataCell(
                            d['sAddress'] == null
                                ? Text('No Data')
                                : Text(d['sAddress'], style: Style.cellStyle),
                          ),
                          DataCell(
                            Text('Hostel Name', style: Style.cellStyle),
                          ),
                          DataCell(
                            d['hName'] == null
                                ? Text('No Data')
                                : Text(d['hName'], style: Style.cellStyle),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(
                            Text('Hostel Room Number', style: Style.cellStyle),
                          ),
                          DataCell(
                            d['hRoomNum'] == null
                                ? Text('No Data')
                                : Text(d['hRoomNum'], style: Style.cellStyle),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            Text(
                              'Guardian Details',
                              style: Style.detailsHeadStyle,
                            ),
                          ),
                          DataCell(Text('')),
                          DataCell(
                            Text('Hostel Joining Date', style: Style.cellStyle),
                          ),
                          DataCell(
                            d['hJoinDate'] == null
                                ? Text('No Data')
                                : Text(d['hJoinDate'], style: Style.cellStyle),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            Text('Guardian Name', style: Style.cellStyle),
                          ),
                          DataCell(
                            d['gName'] == null
                                ? Text('No Data')
                                : Text(d['gName'], style: Style.cellStyle),
                          ),
                          DataCell(Text('')),
                          DataCell(Text('')),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            Text('Guardian Mobile Number',
                                style: Style.cellStyle),
                          ),
                          DataCell(
                            d['gMobNum'] == null
                                ? Text('No Data')
                                : Text(d['gMobNum'], style: Style.cellStyle),
                          ),
                          DataCell(Text('')),
                          DataCell(Text('')),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            Text('Guardian Relationship',
                                style: Style.cellStyle),
                          ),
                          DataCell(
                            d['gRelation'] == null
                                ? Text('No Data')
                                : Text(d['gRelation'], style: Style.cellStyle),
                          ),
                          DataCell(Text('')),
                          DataCell(Text('')),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            Text('Guardian Address', style: Style.cellStyle),
                          ),
                          DataCell(
                            d['gAddress'] == null
                                ? Text('No Data')
                                : Text(d['gAddress'], style: Style.cellStyle),
                          ),
                          DataCell(Text('')),
                          DataCell(Text('')),
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
