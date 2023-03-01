import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class HttpUploadService {

  // Future<String> uploadPhotos(List<String> paths) async {
  //   Uri uri = Uri.parse('http://10.0.0.103:5000/profile/upload-mutiple');
  //   http.MultipartRequest request = http.MultipartRequest('POST', uri);
  //   for(String path in paths){
  //     request.files.add(await http.MultipartFile.fromPath('image', path));
  //   }
  //
  //   http.StreamedResponse response = await request.send();
  //   var responseBytes = await response.stream.toBytes();
  //   var responseString = utf8.decode(responseBytes);
  //   print('\n\n');
  //   print('RESPONSE WITH HTTP');
  //   print(responseString);
  //   print('\n\n');
  //   return responseString;
  // }

  // var postUri =
  // Uri.parse(baseUrl + Services.editUserProfile());
  //
  // http.MultipartRequest request =
  // new http.MultipartRequest("POST", postUri);
  // if (image_Path != null) {
  // http.MultipartFile multipartFile =
  // await http.MultipartFile.fromPath('profile_picture', image_Path);
  // request.files.add(multipartFile);
  // }
  // final token = SharedPreferencesHelper.getAccessToken();
  // Map<String, String> headers = {
  // "Content-Type": "application/json",
  // "Authorization": "Bearer " + token,
  // };
  //
  // request.headers.addAll(headers);
  // request.fields['gender'] = gender!;
  // request.fields['name'] = fullName!;
  // request.fields['email'] = emailId!;
  // request.fields['mobile_number'] = mobileNo!;
  // request.fields['dob'] = dob!;
  // request.fields['profession'] = profession!;
  // request.fields['is_lj_student'] = isAgreeLJStudent == true ? '1' : '0';
  //
  // request
  //     .send()
  //     .then((result) async {
  // http.Response.fromStream(result).then((response) {
  //
  // if (response.statusCode == 200) {
  // print("Uploaded! ");
  // print('response.body ' + response.body);
  // UserModel user =
  // UserModel.fromJson(jsonDecode(response.body));
  // _saveUserData(user, context);
  // verificationStatus = VerificationState.IDEAL;
  // } else {
  // verificationStatus = VerificationState.ERROR;
  // PCFlushBar.showFlushBar(context,
  // title: PCStrings.somethingWrong,
  // body: "Data Can't Update",
  // isErrorFlushBar: true);
  // }
  // });
  // })
  //     .catchError((err) => print('error : ' + err.toString()))
  //     .whenComplete(() {});

  Future uploadImage({
    required XFile filePath,
  }) async {
    final uri = Uri.parse('http://192.168.1.4:8000/api/image');
    try {
      http.MultipartRequest request = http.MultipartRequest("POST", uri);

      http.MultipartFile multipartFile = await http.MultipartFile.fromPath('image', filePath.path);
      request.files.add(multipartFile);
      request.headers.addAll(_header());
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } catch (e) {
      return null;
    }
  }

  _header() {
    return {"Content-Type": "multipart/form-data","Accept": "application/json"};
  }

}