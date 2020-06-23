

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:societyappresidents/provider/ApiProvider.dart';

class Repository {
  ApiProvider apiProvider = ApiProvider();
  Future<String> login(var userContactNumber, var userPassword) =>
      apiProvider.login(userContactNumber, userPassword);

  Future<void> tenantRegistration(
          var userCategory,
          var userType,
          var userFlatNumber,
          var userOwnerName,
          var userMobileNumber,
          var userEmail) =>
      apiProvider.tenantRegistration(userCategory, userType, userFlatNumber,
          userOwnerName, userEmail, userMobileNumber);

  Future<void> residentRegistration(
        
          var userType,
           var userOwnerName,
          var userFlatNumber,
         
          var userMobileNumber,
          var userEmail,
          var password,
          var society,
          var familyDetails
          ) =>
      apiProvider.residentRegistration( userType, userOwnerName,userFlatNumber,userMobileNumber,
           userEmail,password,society,familyDetails);

  Future<String> raiseComplaint(var subject, var message,File image) =>
      apiProvider.raiseComplaint(subject, message,image);

  Future<String> changePasswordGetContact(var contact) =>
      apiProvider.changePasswordGetContact(contact);
  //Change Password Verify OTP
  Future<String> changePasswordVerifyOTP(var contact, var otp) =>
      apiProvider.changePasswordVerifyOTP(contact, otp);
  //Change Password Confirmation
  Future<String> changePasswordConfirmation(var contact, var password) =>
      apiProvider.changePasswordConfirmation(contact, password);

      Future<void> getProfileDetails()=>apiProvider.getProfileDetails();
}
