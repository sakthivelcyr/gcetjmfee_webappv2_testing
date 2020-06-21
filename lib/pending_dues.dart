import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gcetjmfee_webappv2/title.dart';
import './style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PendingDues extends StatefulWidget {
  @override
  _PendingDues createState() => _PendingDues();
}

bool rollNumCheck = false;

class _PendingDues extends State<PendingDues> {
  String monthValue;
  String yearValue;
  String branchValue;
  String rollNum;
  final rollNumController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final monthDrop = DropdownButton<String>(
      hint: Text(
        'Select Month',
        textAlign: TextAlign.center,
      ),
      value: monthValue,
      style: TextStyle(
        color: Colors.black,
        fontSize: MediaQuery.of(context).size.width / 130,
        fontWeight: FontWeight.bold,
      ),
      items: <DropdownMenuItem<String>>[
        getDropDownMenuItem('ALL', 'ALL'),
        getDropDownMenuItem('JAN', 'JAN'),
        getDropDownMenuItem('FEB', 'FEB'),
        getDropDownMenuItem('MAR', 'MAR'),
        getDropDownMenuItem('APR', 'APR'),
        getDropDownMenuItem('MAY', 'MAY'),
        getDropDownMenuItem('JUNE', 'JUNE'),
        getDropDownMenuItem('JULY', 'JULY'),
        getDropDownMenuItem('AUG', 'AUG'),
        getDropDownMenuItem('SEP', 'SEP'),
        getDropDownMenuItem('OCT', 'OCT'),
        getDropDownMenuItem('NOV', 'NOV'),
        getDropDownMenuItem('DEC', 'DEC'),
      ],
      onChanged: (String value) {
        setState(() {
          monthValue = value;
        });
      },
    );

    final yearDrop = DropdownButton<String>(
      hint: Text(
        'Select Year',
        textAlign: TextAlign.center,
      ),
      value: yearValue,
      style: TextStyle(
        color: Colors.black,
        fontSize: MediaQuery.of(context).size.width / 130,
        fontWeight: FontWeight.bold,
      ),
      items: <DropdownMenuItem<String>>[
        getDropDownMenuItem('ALL', 'ALL'),
        getDropDownMenuItem('2017', '2017'),
        getDropDownMenuItem('2018', '2018'),
        getDropDownMenuItem('2019', '2019'),
        getDropDownMenuItem('2020', '2020'),
        getDropDownMenuItem('2021', '2021'),
      ],
      onChanged: (String value) {
        setState(() {
          yearValue = value;
        });
      },
    );

    final branchDrop = DropdownButton<String>(
      hint: Text(
        'Select Branch',
        textAlign: TextAlign.center,
      ),
      value: branchValue,
      style: TextStyle(
        color: Colors.black,
        fontSize: MediaQuery.of(context).size.width / 130,
        fontWeight: FontWeight.bold,
      ),
      items: <DropdownMenuItem<String>>[
        getDropDownMenuItem('ALL', 'ALL'),
        getDropDownMenuItem('CSE', 'CSE'),
        getDropDownMenuItem('ECE', 'ECE'),
        getDropDownMenuItem('EEE', 'EEE'),
        getDropDownMenuItem('CIVIL', 'CIVIL'),
        getDropDownMenuItem('MECH', 'MECH'),
      ],
      onChanged: (String value) {
        setState(() {
          branchValue = value;
        });
      },
    );

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              title(size, 'Pending Dues', context),
              Container(
                width: size.width,
                height: size.height - size.height / 10,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width / 130),
                          width: MediaQuery.of(context).size.width / 8,
                          height: MediaQuery.of(context).size.width / 40,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              border:
                                  Border.all(color: Colors.black87, width: 2)),
                          child: yearDrop,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width / 130),
                          width: MediaQuery.of(context).size.width / 8,
                          height: MediaQuery.of(context).size.width / 40,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              border:
                                  Border.all(color: Colors.black87, width: 2)),
                          child: monthDrop,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width / 130),
                          width: MediaQuery.of(context).size.width / 8,
                          height: MediaQuery.of(context).size.width / 40,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              border:
                                  Border.all(color: Colors.black87, width: 2)),
                          child: branchDrop,
                        ),
                        inputBox(
                            'Search Reg.no.',
                            TextInputType.number,
                            Icon(Icons.search,
                                size: 28, color: Colors.black87)),
                      ],
                    ),
                    Container(
                      height: size.height / 1.24,
                      width: size.width,
                      child: tabledetails(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  chooseStream() {
    if (rollNumCheck) {
      //check = 0;
      print(rollNumCheck);

      return Firestore.instance
          .collectionGroup('PendingDues')
          .where("rollNum", isEqualTo: rollNumController.text)
          .where("year", isEqualTo: yearValue)
          .where("month", isEqualTo: monthValue)
          .snapshots();
    } else {
      print(monthValue.toString() +
          yearValue.toString() +
          branchValue.toString());
      if (branchValue == null && monthValue == null && yearValue == null ||
          branchValue == null && monthValue == null && yearValue == 'ALL' ||
          branchValue == null && monthValue == 'ALL' && yearValue == null ||
          branchValue == 'ALL' && monthValue == null && yearValue == null)
        return Firestore.instance
            .collectionGroup('PendingDues')
            .orderBy('rollNum', descending: false)
            .snapshots();
      if (branchValue == null && monthValue == null && yearValue != null)
        return Firestore.instance
            .collectionGroup('PendingDues')
            .orderBy('rollNum', descending: false)
            .where("year", isEqualTo: yearValue)
            .snapshots();
      if (branchValue != null && monthValue == null && yearValue == null)
        return Firestore.instance
            .collectionGroup('PendingDues')
            .orderBy('rollNum', descending: false)
            .where("branch", isEqualTo: branchValue)
            .snapshots();
      if (branchValue == null && monthValue != null && yearValue == null)
        return Firestore.instance
            .collectionGroup('PendingDues')
            .orderBy('rollNum', descending: false)
            .where("month", isEqualTo: monthValue)
            .snapshots();
      if (branchValue != null || monthValue != null || yearValue != null)
        return Firestore.instance
            .collectionGroup('PendingDues')
            .orderBy('rollNum', descending: false)
            .where("year", isEqualTo: yearValue)
            .where("month", isEqualTo: monthValue)
            .where("branch", isEqualTo: branchValue)
            .snapshots();
      /*else
        return Firestore.instance.collectionGroup('PendingDues').snapshots();*/
    }
  }
  //datatable

  SingleChildScrollView tabledetails() {
    getDataColumn(String label) {
      return DataColumn(
        label: Text(
          label,
          style: Style.columnStyle,
        ),
      );
    }

    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
        stream: chooseStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          print('Error: ${snapshot.error}');

          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return new PaginatedDataTable(
                header: Text('Pending Dues', style: Style.headStyle),
                columns: [
                  getDataColumn('Sl.No.'),
                  getDataColumn('Name'),
                  getDataColumn('Roll Number'),
                  getDataColumn('Amount'),
                  getDataColumn('Amount Per Day'),
                  getDataColumn('Bill Date'),
                  getDataColumn('Due Date'),
                  getDataColumn('Month'),
                  getDataColumn('Year'),
                  getDataColumn('Number of Days stay in Hostel'),

                  /*getDataColumn('Hostel Name'),
                  getDataColumn('Hostel Joining Date'),
                  getDataColumn('Hostel room Number'),
                  getDataColumn('Registeration Time'),
                  getDataColumn('Student Mail'),*/
                ],
                source: DTSStuRec(snapshot.data.documents),
                rowsPerPage: 12,
              );
          }
        },
      ),
    );
    //scrollDirection: Axis.horizonta)l,
  }

  Widget getDropDownMenuItem(String text, String value) {
    return DropdownMenuItem(
      child: new Text(text),
      value: value,
    );
  }

  Widget inputBox(String label, TextInputType t, Icon icon) {
    return Container(
      width: MediaQuery.of(context).size.width / 8,
      height: MediaQuery.of(context).size.width / 40,
      child: TextFormField(
        controller: rollNumController,
        keyboardType: t,
        autofocus: false,
        onChanged: (value) {
          setState(() {
            rollNum = rollNumController.text;
            rollNumCheck = true;
            print(rollNum);
            chooseStream();
          });
          if (rollNumController.text.isEmpty)
            setState(() {
              rollNumCheck = false;
              print(rollNum);
              chooseStream();
            });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            borderSide: BorderSide(color: Colors.black87, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              borderSide: BorderSide(color: Colors.black87, width: 3)),
          labelText: label,
          labelStyle: TextStyle(color: Colors.blueGrey),
          suffixIcon: icon,
        ),
        cursorColor: Colors.black87,
        showCursor: true,
      ),
    );
  }
}

class DTSStuRec extends DataTableSource {
  final List<DocumentSnapshot> d;

  DTSStuRec(this.d);

  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${index + 1}', style: Style.cellStyle)),
        DataCell(
          d[index]['sName'] == null
              ? Text('No Data')
              : Text(d[index]['sName'], style: Style.cellStyle),
        ),
        DataCell(
          d[index]['rollNum'] == null
              ? Text('No Data')
              : Text(d[index]['rollNum'], style: Style.cellStyle),
        ),
        DataCell(d[index]['amount'] == null
            ? Text('No Data')
            : Text(d[index]['amount'], style: Style.cellStyle)),
        DataCell(
          d[index]['amPDay'] == null
              ? Text('No Data')
              : Text(d[index]['amPDay'], style: Style.cellStyle),
        ),
        DataCell(
          d[index]['billDate'] == null
              ? Text('No Data')
              : Text(d[index]['billDate'], style: Style.cellStyle),
        ),
        DataCell(
          d[index]['dueDate'] == null
              ? Text('No Data')
              : Text(d[index]['dueDate'], style: Style.cellStyle),
        ),
        DataCell(
          d[index]['month'] == null
              ? Text('No Data')
              : Text(d[index]['month'], style: Style.cellStyle),
        ),
        DataCell(
          d[index]['year'] == null
              ? Text('No Data')
              : Text(d[index]['year'], style: Style.cellStyle),
        ),
        DataCell(
          d[index]['numDSH'] == null
              ? Text('No Data')
              : Text(d[index]['numDSH'], style: Style.cellStyle),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => d.length;

  @override
  int get selectedRowCount => 0;
}
