import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:societyappresidents/utilities/Constants.dart';

class ApiProvider {
  Future<String> login(userContactNumber, userPassword) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    http.Response response = await http.post(Constants.BASE_URL + "users/login",
        body: {'contact': userContactNumber, 'password': userPassword},
        headers: {});

    print(response.body);

    if (response.statusCode == 200) {
      var decodedResponse = json.decode(response.body);
      if (decodedResponse['state'] == 'success') {
        var storage = new FlutterSecureStorage();
        await storage.write(key: "token", value: decodedResponse['token']);        
        await storage.write(key: "flat_no", value: decodedResponse['flat_no']);        
        await sharedPreferences.setString("name", decodedResponse['name']);
        await sharedPreferences.setString("id", decodedResponse['id']);
        //await sharedPreferences.setString("flat_no", decodedResponse['flat_no']);

        return "success";
      } else {
        return "fail";
      }
    } else {
      throw Exception("Cannot Perform The Operation");
    }
  }

  Future<void> tenantRegistration(userCategory, userPassword, userFlatNumber,
      userOwnerName, userEmail, userMobileNumber) async {
    http.Response response = await http.post(Constants.BASE_URL + " ", body: {
      'category': userCategory,
      'type': userPassword,
      'flatNumber': userFlatNumber,
      'ownerName': userOwnerName,
      'mobileNumber': userMobileNumber,
      'email': userEmail
    }, headers: {});

    print(response.body);

    if (response.statusCode == 200) {
      var decodedResponse = json.decode(response.body);
      if (decodedResponse['state'] == 'success') {
      } else {}
    } else {
      throw Exception("Cannot Perform The Operation");
    }
  }

  Future<void> residentRegistration(userCategory, userOwnerName, userFlatNumber,
      userMobileNumber, userEmail, userPassword, society, familyDetails) async {
    http.Response response =
        await http.post(Constants.BASE_URL + "users/register", body: {
      'type': userCategory,
      'flat_no': userFlatNumber,
      'owner_name': userOwnerName,
      'contact': userMobileNumber,
      'email': userEmail,
      'password': userPassword,
      'society': society,
      'members': familyDetails
    }, headers: {});

    print(response.body);

    if (response.statusCode == 200) {
      var decodedResponse = json.decode(response.body);
      if (decodedResponse['state'] == 'success') {
      } else {}
    } else {
      throw Exception("Cannot Perform The Operation");
    }
  }

  Future<String> raiseComplaint(subject, message, image) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse(Constants.BASE_URL + 'complaints/add_complaint'));
    //add text fields
    var storage=FlutterSecureStorage();
    var token=await storage.read(key: 'token');
    request.fields["subject"] = subject;
    request.fields["message"] = message;
    request.headers['Authorization'] = 'Bearer '+token;
    
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("image", image.path);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
    if (json.decode(responseString)['state'] == 'success') {
      return 'success';
    } else {
      return 'fail';
    }

    // http.Response response = await http.post(Constants.BASE_URL + " ",
    //     body: {'subject': subject, 'message': message}, headers: {});
    // print(response.body);
    // if (response.statusCode == 200) {
    //   var decodedResponse = json.decode(response.body);
    //   if (decodedResponse['state'] == 'success') {
    //   } else {}
    // } else {
    //   throw Exception("Cannot Perform The Operation");
    // }
  }

  //Change Password ( Get Contact ) API
  Future<String> changePasswordGetContact(var contact) async {
    print(contact);
    http.Response response = await http
        .post(Constants.BASE_URL + 'users/get_contact_update_password', body: {
      'contact': contact,
    });
    print(response.body);
    if (response.statusCode == 200) {
      var decodedResponse = json.decode(response.body);
      if (decodedResponse['state'] == 'success') {
        return 'success';
      } else {
        return "fail";
      }
    } else {
      throw Exception('Cannot perform the operation !');
    }
  }

  //Change Password ( Verify OTP ) API
  Future<String> changePasswordVerifyOTP(var contact, var otp) async {
    print(contact);
    print(otp);
    http.Response response = await http.post(
        Constants.BASE_URL + 'users/verify_otp_update_password',
        body: {'contact': contact, 'otp': otp});
    print(response.body);
    if (response.statusCode == 200) {
      var decodedResponse = json.decode(response.body);
      if (decodedResponse['state'] == 'success') {
        return 'success';
      } else {
        return 'fail';
      }
    } else {
      throw Exception('Cannot perform the operation !');
    }
  }

  //Confirm Password API
  Future<String> changePasswordConfirmation(var contact, var password) async {
    print(contact);
    http.Response response = await http.post(
        Constants.BASE_URL + 'users/change_password',
        body: {'contact': contact, 'password': password});
    print(response.body);
    if (response.statusCode == 200) {
      var decodedResponse = json.decode(response.body);
      if (decodedResponse['state'] == 'success') {
        return 'success';
      } else {
        return 'fail';
      }
    } else {
      throw Exception('Cannot perform the operation !');
    }
  }

  getSocieties() async {
    http.Response response = await http.get(
      Constants.BASE_URL + 'societies/get_societies',
    );
    print(response.body);
    if (response.statusCode == 200) {
      var decodedResponse = json.decode(response.body);
      if (decodedResponse['state'] == 'success') {
        return decodedResponse['data'];
      } else {
        return [];
      }
    } else {
      throw Exception('Cannot perform the operation !');
    }
  }

  getMessages() async {
    http.Response response =
        await http.get(Constants.BASE_URL + 'messages/get_messages');
    print(response.body);
    if (response.statusCode == 200) {
      var decodedResponse = json.decode(response.body);
      if (decodedResponse['state'] == 'success') {
        return decodedResponse['data'];
      } else {
        return [];
      }
    } else {
      throw Exception('Cannot perform the operation !');
    }
  }

  Future<List> getProfileDetails() async {
    var storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    http.Response response = await http.get(
        Constants.BASE_URL + "users/get_profile_data",
        headers: {"Authorization": 'Bearer ' + token});

    print(response.body);

    if (response.statusCode == 200) {
      var decodedResponse = json.decode(response.body);
      if (decodedResponse['state'] == 'success') {
        return decodedResponse['data'];
      } else {
        return [];
      }
    } else {
      throw Exception("Cannot Perform The Operation");
    }
  }
}
