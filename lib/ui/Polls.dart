import 'package:flutter/material.dart';

class Polls extends StatefulWidget {
  @override
  _PollsState createState() => _PollsState();
}

class _PollsState extends State<Polls> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[400],      
        appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Polls",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width,
        child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: BorderSide(color: Colors.black)),
                  child: Column(
                    children: [

                      Card(
                        
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
