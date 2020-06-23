import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:societyappresidents/bloc/RaiseComplaintBloc.dart';

class RaiseComplaint extends StatefulWidget {
  @override
  _RaiseComplaintState createState() => _RaiseComplaintState();
}

class _RaiseComplaintState extends State<RaiseComplaint> {
  var ImagePath;
  var img;
  var resp;
    final _scaffoldKey = GlobalKey<ScaffoldState>();


  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      img = image;
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      img = image;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaffoldKey,
      backgroundColor: Colors.blue[400],      
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Raise A Complaint",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ListTile(
                  title: TextFormField(
                    onChanged: raiseComplaintBloc.getSubject,
                    decoration: InputDecoration(
                        labelText: "Subject",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                ),
                ListTile(
                  title: TextFormField(
                    onChanged: raiseComplaintBloc.getMessage,
                    maxLines: 7,
                    decoration: InputDecoration(
                        labelText: "Message",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black)),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: img == null
                        ? Center(
                            child: Icon(Icons.queue),
                          )
                        : Image.file(
                            img,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Center(
                  child: RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: BorderSide(color: Colors.black)),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0)),
                          ),
                          builder: (context) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.collections),
                                  title: Text('Choose From Gallery'),
                                  onTap: () {
                                    getImageFromGallery();
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.camera_alt),
                                  title: Text('Take A Photo'),
                                  onTap: () {
                                    getImageFromCamera();
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: Text(
                      "Pick Image",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: RaisedButton(
                    color: Colors.white,
                    onPressed: ()async {
                      print("Clicked");
                      raiseComplaintBloc.dialogLoader(context);
                      
                      raiseComplaintBloc.image.value = img;
                     resp=await raiseComplaintBloc.raiseComplaint();
                     if(resp=='success'){
                       Navigator.pop(context);
                       _scaffoldKey.currentState.showSnackBar(new SnackBar(
                                content: new Text("Complaint Raised Successfully !",
                                    style: TextStyle(fontFamily: 'Ralweway'))));

                     }else{
                       Navigator.pop(context);
                       _scaffoldKey.currentState.showSnackBar(new SnackBar(
                                content: new Text("Please Try Again later !",
                                    style: TextStyle(fontFamily: 'Ralweway'))));

                     }
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
          ),
        ],
      ),
    );
  }
}
