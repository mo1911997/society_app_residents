import 'package:rxdart/rxdart.dart';
import 'package:societyappresidents/repositories/Repository.dart';

class ProfileBloc {
  Repository repository = Repository();
  final societyType = BehaviorSubject<String>();
  final ownerName = BehaviorSubject<String>();
  final flatNumber = BehaviorSubject<String>();
  final mobileNumber = BehaviorSubject<String>();
  final email = BehaviorSubject<String>();
  final familyDetails = BehaviorSubject<List>();

  Function(String) get getSocietyType => societyType.sink.add;
  Function(String) get getOwnerName => ownerName.sink.add;
  Function(String) get getFlatNumber => flatNumber.sink.add;
  Function(String) get getMobileNumber => mobileNumber.sink.add;
  Function(String) get getEmail => email.sink.add;
  Function(List) get getFamilyDetails => familyDetails.sink.add;

  profileDetails() {
    repository.getProfileDetails();
  }

  dispose() {
    societyType.close();
    ownerName.close();
    flatNumber.close();
    mobileNumber.close();
    email.close();
    familyDetails.close();
  }
}
