import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gcetjmfee_webappv2/style.dart';
import 'package:gcetjmfee_webappv2/title.dart';
import 'package:intl/intl.dart';

class GenerateBill extends StatefulWidget {
  GenerateBill({Key key}) : super(key: key);

  @override
  _GenerateBillState createState() => _GenerateBillState();
}

List<int> dshList = List<int>(50);
List<String> rollNum = List<String>(50);
var cpd;
var uploadNum = 0;
var dueDate;
List<int> amList = List<int>(50);
var formatter = new DateFormat('dd-MM-yyyy');
DateTime selectedDate = DateTime.now();
String billDate;
String monthValue;
String yearValue;
bool loading = false;

class _GenerateBillState extends State<GenerateBill> {
  String batchValue;
  String branchValue;

  @override
  void initState() {
    super.initState();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  showAlertDialog(BuildContext context, String text) {
    Widget remindButton = FlatButton(
      child: Text(
        "Ok",
        style: Style.columnStyle,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        "Notice",
        style: Style.columnStyle,
      ),
      content: Text(
        text,
        style: Style.cellStyle,
      ),
      actions: [
        remindButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future storeDocs() async {
    setState(() {
      loading = true;
    });
    billDate = formatter.format(selectedDate.toLocal());
    print(rollNum);
    QuerySnapshot querySnapshot = await Firestore.instance
        .collectionGroup('Profile')
        .orderBy('rollNum', descending: false)
        .where("branch", isEqualTo: branchValue)
        .where("batch", isEqualTo: batchValue)
        .getDocuments();
    for (int i = 0, j = 0; i < querySnapshot.documents.length; i++) {
      var a = querySnapshot.documents[i];
      if (a.documentID == rollNum[j]) {
        print(rollNum[j]);
        uploadNum = j;
        Firestore.instance
            .collection(
                '$batchValue/$branchValue/PaymentDetails/${rollNum[i]}/PendingDues')
            .document('$monthValue')
            .setData({
          'amount': amList[j],
          'sName': a['sName'],
          'rollNum': a['rollNum'],
          'branch': a['branch'],
          'batch': a['batch'],
          'amPDay': cpd,
          'billDate': billDate,
          'dueDate': dueDate,
          'month': monthValue,
          'year': yearValue,
          'numDSH': dshList[j],
        });
        j++;
      } else
        continue;
      print(a.documentID);
    }

    /*for (int i = 0; i < rollNum.length; i++) {
      if (rollNum[i] != null) print(rollNum[i]);
    }*/
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
      body: (loading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    title(size, 'Generate MessBill', context),
                    Container(
                      width: size.width,
                      height: size.height - size.height / 10,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width /
                                            130),
                                width: MediaQuery.of(context).size.width / 8,
                                height: MediaQuery.of(context).size.width / 40,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                    border: Border.all(
                                        color: Colors.black87, width: 2)),
                                child: batchDrop,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width /
                                            130),
                                width: MediaQuery.of(context).size.width / 8,
                                height: MediaQuery.of(context).size.width / 40,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                    border: Border.all(
                                        color: Colors.black87, width: 2)),
                                child: branchDrop,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width /
                                            130),
                                width: MediaQuery.of(context).size.width / 8,
                                height: MediaQuery.of(context).size.width / 40,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                    border: Border.all(
                                        color: Colors.black87, width: 2)),
                                child: yearDrop,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width /
                                            130),
                                width: MediaQuery.of(context).size.width / 8,
                                height: MediaQuery.of(context).size.width / 40,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                    border: Border.all(
                                        color: Colors.black87, width: 2)),
                                child: monthDrop,
                              ),
                              ButtonTheme(
                                height: MediaQuery.of(context).size.width / 40,
                                minWidth:
                                    MediaQuery.of(context).size.width / 10,
                                hoverColor: Colors.yellow,
                                child: RaisedButton(
                                  color: Colors.yellowAccent,
                                  onPressed: () {
                                    setState(() {
                                      for (int i = 0; i < 50; i++) {
                                        if (dshList[i] != null) {
                                          amList[i] = dshList[i] * cpd;
                                        }
                                      }
                                    });
                                  },
                                  child: Text(
                                    'Calculate',
                                    style: Style.columnStyle
                                        .copyWith(letterSpacing: 2),
                                  ),
                                ),
                              ),
                              ButtonTheme(
                                height: MediaQuery.of(context).size.width / 40,
                                minWidth:
                                    MediaQuery.of(context).size.width / 10,
                                hoverColor: Colors.green,
                                child: RaisedButton(
                                  color: Colors.greenAccent,
                                  onPressed: () async {
                                    bool checkPresentDSH = true;
                                    bool checkPresentam = true;
                                    if (batchValue == null)
                                      showAlertDialog(
                                          context, 'Batch is not choosen');
                                    else if (branchValue == null)
                                      showAlertDialog(
                                          context, 'Branch is not choosen');
                                    else if (yearValue == null)
                                      showAlertDialog(
                                          context, 'Year not choosen');
                                    else if (monthValue == null)
                                      showAlertDialog(
                                          context, 'Month not choosen');
                                    else if (cpd == null)
                                      showAlertDialog(context,
                                          'Cost per day is not entered');
                                    else if (dueDate == null)
                                      showAlertDialog(
                                          context, 'Due Date is not selected');
                                    else {
                                      for (int i = 0; i < dshList.length; i++) {
                                        print(dshList[i]);
                                        if (dshList[i] != null) {
                                          checkPresentDSH = false;
                                          break;
                                        }
                                      }
                                      for (int i = 0; i < amList.length; i++) {
                                        if (amList[i] != null) {
                                          checkPresentam = false;
                                          break;
                                        }
                                      }
                                      if (checkPresentDSH)
                                        showAlertDialog(context,
                                            'Number of Days stay in Hostel is not entered. Minimum one need to upload data.');
                                      else if (checkPresentam)
                                        showAlertDialog(context,
                                            'Amount is not calculated. Minimum one need to upload data.');
                                      else {
                                        await storeDocs().whenComplete(() {
                                          setState(() {
                                            loading = false;
                                          });
                                        });

                                        showAlertDialog(context,
                                            '${uploadNum + 1} Data uploaded successfully');
                                        for (var i = 0;
                                            i < dshList.length;
                                            i++) {
                                          dshList[i] = null;
                                        }
                                        for (var i = 0;
                                            i < amList.length;
                                            i++) {
                                          amList[i] = null;
                                        }
                                        //dshList.removeRange(0, 50);
                                      }
                                    }
                                  },
                                  child: Text(
                                    'Upload',
                                    style: Style.columnStyle
                                        .copyWith(letterSpacing: 2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height / 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: size.height / 1.27,
                                width: size.width / 1.23,
                                child: tabledetails(),
                              ),
                              SizedBox(
                                width: size.width / 40,
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Cost Per Day',
                                        style: Style.columnStyle),
                                    SizedBox(
                                      height: size.height / 100,
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(10),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                          borderSide: BorderSide(
                                              color: Colors.black54, width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0)),
                                            borderSide: BorderSide(
                                                color: Colors.black87,
                                                width: 3)),
                                        labelStyle:
                                            TextStyle(color: Colors.blueGrey),
                                      ),
                                      cursorColor: Colors.black87,
                                      onChanged: (value) {
                                        setState(() {
                                          cpd = int.parse(value);
                                        });
                                        print(value);
                                      },
                                      showCursor: true,
                                    ),
                                    SizedBox(
                                      height: size.height / 30,
                                    ),
                                    Text('Select Due Date',
                                        style: Style.columnStyle),
                                    SizedBox(
                                      height: size.height / 100,
                                    ),
                                    ButtonTheme(
                                      minWidth: size.width / 5,
                                      height: 45,
                                      hoverColor: Colors.black26,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                          border: Border.all(
                                              color: Colors.black54, width: 2),
                                        ),
                                        child: RaisedButton(
                                          color: Colors.white,
                                          onPressed: () {
                                            _selectDate(context);
                                            dueDate = formatter
                                                .format(selectedDate.toLocal());
                                          },
                                          child: Text(
                                            "${formatter.format(selectedDate.toLocal())}",
                                            style: Style.columnStyle,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  chooseStream() {
    if (batchValue == null || branchValue == null)
      return null;
    else
      return Firestore.instance
          .collectionGroup('Profile')
          .orderBy('rollNum', descending: false)
          .where("branch", isEqualTo: branchValue)
          .where("batch", isEqualTo: batchValue)
          .snapshots();
  }

  SingleChildScrollView tabledetails() {
    getDataColumn(String label) {
      return DataColumn(
        label: Text(
          label,
          style: Style.columnStyle,
          textAlign: TextAlign.center,
        ),
      );
    }

    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
        stream: chooseStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //print('Error: ${snapshot.error}');
          if (!snapshot.hasData) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(100.0),
              child: Text(
                'Data not Found',
                style: TextStyle(fontSize: 30, color: Colors.red),
              ),
            ));
          }
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return new PaginatedDataTable(
                header: Text(
                  'Mess bill Generation for $batchValue  -  $branchValue',
                  style: Style.columnStyle,
                  textAlign: TextAlign.center,
                ),
                showCheckboxColumn: false,
                columns: [
                  getDataColumn('Sl.No.'),
                  getDataColumn('Roll Number'),
                  getDataColumn('Name'),
                  getDataColumn('Year'),
                  getDataColumn('Month'),
                  getDataColumn('Number of Days\nstay in Hostel'),
                  getDataColumn('Cost Per\nday'),
                  getDataColumn('Amount'),
                  getDataColumn('Due Date'),
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
}

class DTSStuRec extends DataTableSource {
  final List<DocumentSnapshot> d;
  final BuildContext context;

  Widget getTextField(int index, String roll) {
    return TextFormField(
      initialValue: dshList[index] == null ? '' : dshList[index].toString(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          borderSide: BorderSide(color: Colors.black87, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            borderSide: BorderSide(color: Colors.black87, width: 3)),
        labelStyle: TextStyle(color: Colors.blueGrey),
      ),
      cursorColor: Colors.black87,
      onChanged: (value) {
        dshList[index] = int.parse(value);
        rollNum[index] = roll;
      },
      showCursor: true,
    );
  }

  DTSStuRec(this.d, this.context);
  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
          Text('${index + 1}',
              style: Style.cellStyle, textAlign: TextAlign.center),
        ),
        DataCell(
          d[index]['rollNum'] == null
              ? Text('No Data', textAlign: TextAlign.center)
              : Text(d[index]['rollNum'],
                  style: Style.cellStyle, textAlign: TextAlign.center),
        ),
        DataCell(
          d[index]['sName'] == null
              ? Text('No Data', textAlign: TextAlign.center)
              : Text(d[index]['sName'],
                  style: Style.cellStyle, textAlign: TextAlign.center),
        ),
        DataCell(
          Text(yearValue == null ? 'Year' : '${yearValue}',
              style: Style.cellStyle, textAlign: TextAlign.center),
        ),
        DataCell(
          Text(monthValue == null ? 'Month' : '${monthValue}',
              style: Style.cellStyle, textAlign: TextAlign.center),
        ),
        DataCell(
          Container(
            height: MediaQuery.of(context).size.height / 30,
            child: getTextField(index, d[index]['rollNum']),
          ),
        ),
        DataCell(
          Text(cpd == null ? '0' : '${cpd}',
              style: Style.cellStyle, textAlign: TextAlign.center),
        ),
        DataCell(
          Text(amList[index] == null ? '0' : '${amList[index]}',
              style: Style.cellStyle, textAlign: TextAlign.center),
        ),
        DataCell(
          Text(
              dueDate == null
                  ? 'Date'
                  : "${formatter.format(selectedDate.toLocal())}",
              style: Style.cellStyle,
              textAlign: TextAlign.center),
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
