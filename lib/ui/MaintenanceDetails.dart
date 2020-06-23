import 'package:flutter/material.dart';

class MaintenanceDetails extends StatefulWidget {
  @override
  _MaintenanceDetailsState createState() => _MaintenanceDetailsState();
}

class _MaintenanceDetailsState extends State<MaintenanceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Maintenance Details",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
