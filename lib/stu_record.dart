import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gcetjmfee_webappv2/view_details.dart';
import './style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentRecord extends StatefulWidget {
  @override
  _StudentRecord createState() => _StudentRecord();
}

bool rollNumCheck = false;

class _StudentRecord extends State<StudentRecord> {
  String batchValue;
  String branchValue;
  String rollNum;
  final rollNumController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final batchDrop = DropdownButton<String>(
      hint: Text(
        'Select Batch',
        textAlign: TextAlign.center,
      ),
      value: batchValue,
      style: TextStyle(
        color: Colors.black,
        fontSize: MediaQuery.of(context).size.width / 130,
        fontWeight: FontWeight.bold,
      ),
      items: <DropdownMenuItem<String>>[
        getDropDownMenuItem('ALL', 'ALL'),
        getDropDownMenuItem('2016 - 2020', '2016 - 2020'),
        getDropDownMenuItem('2017 - 2021', '2017 - 2021'),
        getDropDownMenuItem('2018 - 2022', '2018 - 2022'),
        getDropDownMenuItem('2019 - 2023', '2019 - 2023'),
      ],
      onChanged: (String value) {
        setState(() {
          batchValue = value;
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

    return Column(
      children: <Widget>[
        Container(
          width: size.width,
          height: size.height - size.height / 10,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 130),
                    width: MediaQuery.of(context).size.width / 8,
                    height: MediaQuery.of(context).size.width / 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        border: Border.all(color: Colors.black87, width: 2)),
                    child: batchDrop,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 130),
                    width: MediaQuery.of(context).size.width / 8,
                    height: MediaQuery.of(context).size.width / 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        border: Border.all(color: Colors.black87, width: 2)),
                    child: branchDrop,
                  ),
                  inputBox('Search Reg.no.', TextInputType.number,
                      Icon(Icons.search, size: 28, color: Colors.black87)),
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
    );
  }

  chooseStream() {
    if (rollNumCheck) {
      //check = 0;
      print(rollNumCheck);

      return Firestore.instance
          .collectionGroup('Profile')
          .where("rollNum", isEqualTo: rollNumController.text)
          .snapshots();
    } else {
      if (branchValue == null && batchValue == null ||
          branchValue == null && batchValue == 'ALL' ||
          branchValue == 'ALL' && batchValue == null ||
          batchValue == 'ALL' && branchValue == 'ALL') {
        print('1');
        return Firestore.instance
            .collectionGroup('Profile')
            .orderBy('rollNum', descending: false)
            .snapshots();
      } else if (branchValue != null && batchValue == 'ALL' ||
          branchValue != null && batchValue == null) {
        print('2');
        return Firestore.instance
            .collectionGroup('Profile')
            .orderBy('rollNum', descending: false)
            .where("branch", isEqualTo: branchValue)
            .snapshots();
      } else if (batchValue != null && branchValue == 'ALL' ||
          batchValue != null && branchValue == null) {
        print(3);
        return Firestore.instance
            .collectionGroup('Profile')
            .orderBy('rollNum', descending: false)
            .where("batch", isEqualTo: batchValue)
            .snapshots();
      } else {
        print('4');
        return Firestore.instance
            .collectionGroup('Profile')
            .orderBy('rollNum', descending: false)
            .where("branch", isEqualTo: branchValue)
            .where("batch", isEqualTo: batchValue)
            .snapshots();
      }
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
          //print('Error: ${snapshot.error}');

          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return new PaginatedDataTable(
                header: Text('Students Records', style: Style.headStyle),
                showCheckboxColumn: false,
                columns: [
                  getDataColumn('Sl.No.'),
                  getDataColumn('Name'),
                  getDataColumn('Roll Number'),
                  getDataColumn('Register Number'),
                  getDataColumn('Gender'),
                  getDataColumn('DOB'),
                  getDataColumn('Blood Group'),
                  getDataColumn('Batch'),
                  getDataColumn('Branch'),
                ],
                source: DTSStuRec(snapshot.data.documents, context),
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
  final BuildContext context;

  DTSStuRec(this.d, this.context);
  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(
      index: index,
      onSelectChanged: (bool selected) {
        if (selected)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StudentDetails(d[index])),
          );
      },
      cells: [
        DataCell(Text(
          '${index + 1}',
          style: Style.cellStyle,
        )),
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
        DataCell(d[index]['regNum'] == null
            ? Text('No Data')
            : Text(d[index]['regNum'], style: Style.cellStyle)),
        DataCell(
          d[index]['sGender'] == null
              ? Text('No Data')
              : Text(d[index]['sGender'], style: Style.cellStyle),
        ),
        DataCell(
          d[index]['sDOB'] == null
              ? Text('No Data')
              : Text(d[index]['sDOB'], style: Style.cellStyle),
        ),
        DataCell(
          d[index]['sBG'] == null
              ? Text('No Data')
              : Text(d[index]['sBG'], style: Style.cellStyle),
        ),
        DataCell(
          d[index]['batch'] == null
              ? Text('No Data')
              : Text(d[index]['batch'], style: Style.cellStyle),
        ),
        DataCell(
          d[index]['branch'] == null
              ? Text('No Data')
              : Text(d[index]['branch'], style: Style.cellStyle),
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
