import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:societyappresidents/bloc/ResidentBloc.dart';
import 'package:societyappresidents/provider/ApiProvider.dart';
import 'dart:convert';

class ResidentForm extends StatefulWidget {
  @override
  _ResidentFormState createState() => _ResidentFormState();
}

class _ResidentFormState extends State<ResidentForm> {
  var dropdownValueFlat;
  var dropdownValueType;
  var dropdownValueRelation;
  var dropdownValueSocietyType;

  List familyDetails;
  TextEditingController memberNameController = TextEditingController();
  ApiProvider apiProvider;
  List societies = [];
  List<String> societyNames = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    familyDetails = [];
    getSocities();
  }

  getSocities() async {
    apiProvider = ApiProvider();
    societies = await apiProvider.getSocieties();
    setState(() {
      print(societies);
      for (var i in societies) {
        print(i['name']);
        societyNames.add(json.encode({'name': i['name'], 'id': i['_id']}));
      }
    });
  }

  void dialogBoxFamilyDetails() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: BorderSide(color: Colors.black)),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ListTile(
                          title: TextFormField(
                            controller: memberNameController,
                            decoration: InputDecoration(
                                labelText: "Full Name",
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                        ),
                        ListTile(
                          title: DropdownButton<String>(
                            value: dropdownValueRelation,
                            iconSize: 0.0,
                            elevation: 16,
                            hint: Text(
                              "Relation",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15.0),
                            ),
                            underline: Container(
                              height: 1,
                              color: Colors.black,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                print(newValue);
                                dropdownValueRelation = newValue;
                              });
                            },
                            items: <String>[
                              "Father",
                              "Mother",
                              "Son",
                              "Daughter",
                              "Wife",
                              "Friends",
                              "Others"
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                              onPressed: () {
                                setState(() {
                                  familyDetails.add({
                                    'name': memberNameController.text,
                                    'relation': dropdownValueRelation.toString()
                                  });
                                  Navigator.pop(context);
                                });
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.black)),
                              color: Colors.white,
                              elevation: 5.0,
                              child: Text(
                                "Add",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.black)),
                              color: Colors.white,
                              elevation: 5.0,
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          title: new Text(
            "Add Family Details",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        );
      },
    ).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.blue[400],      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Resident Registration ",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [Colors.cyan, Colors.cyan])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ListTile(
                        title: DropdownButton<String>(
                          value: dropdownValueSocietyType,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                          iconSize: 0.0,
                          elevation: 16,
                          hint: Text(
                            "Society/Apartment",
                            style:
                                TextStyle(color: Colors.black, fontSize: 15.0),
                          ),
                          underline: Container(
                            height: 1,
                            color: Colors.black,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueSocietyType = newValue;
                            });
                          },
                          items: societyNames
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: json.decode(value)['id'],
                              child: Text(
                                json.decode(value)['name'],
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      ListTile(
                        title: TextFormField(
                          onChanged: residentBloc.getUserOwnerName,
                          decoration: InputDecoration(
                              labelText: "Owner Name",
                              labelStyle: TextStyle(
                                color: Colors.black,
                              )),
                        ),
                      ),
                      ListTile(
                        title: DropdownButton<String>(
                          value: dropdownValueFlat,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                          iconSize: 0.0,
                          elevation: 16,
                          hint: Text(
                            "Flat Number",
                            style:
                                TextStyle(color: Colors.black, fontSize: 15.0),
                          ),
                          underline: Container(
                            height: 1,
                            color: Colors.black,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueFlat = newValue;
                            });
                          },
                          items: <String>[
                            "C-501",
                            "C-502",
                            "C-503",
                            "C-504",
                            "C-505"
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      ListTile(
                        title: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10)
                          ],
                          onChanged: residentBloc.getUserMobileNumber,
                          decoration: InputDecoration(
                              labelText: "Mobile Number",
                              labelStyle: TextStyle(
                                color: Colors.black,
                              )),
                        ),
                      ),
                      ListTile(
                        title: TextFormField(
                          onChanged: residentBloc.getUserEmail,
                          decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(
                                color: Colors.black,
                              )),
                        ),
                      ),
                      ListTile(
                        title: TextFormField(
                          obscureText: true,
                          onChanged: residentBloc.getUserPassword,
                          decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                color: Colors.black,
                              )),
                        ),
                      ),
                      ListTile(
                        trailing: IconButton(
                          onPressed: () {
                            dialogBoxFamilyDetails();
                          },
                          tooltip: "Add Family Details",
                          icon: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 25.0,
                          ),
                        ),
                        title: Text(
                          "Family Details",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        margin: EdgeInsets.only(left: 10.0, right: 10.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(12.0)),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: familyDetails.length == 0
                                ? 0
                                : familyDetails.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                    familyDetails[index]['name'].toString() +
                                        "(" +
                                        familyDetails[index]['relation']
                                            .toString() +
                                        ")"),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: RaisedButton(
              color: Colors.white,
              onPressed: () {
                residentBloc.society.value = dropdownValueSocietyType;

                residentBloc.userCategory.value = "Resident";

                residentBloc.userFlatNumber.value = dropdownValueFlat;
                residentBloc.familyDetails.value =
                    json.encode(familyDetails).toString();

                residentBloc.residentRegister();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.black, width: 2.0)),
              child: Text(
                "Register",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
