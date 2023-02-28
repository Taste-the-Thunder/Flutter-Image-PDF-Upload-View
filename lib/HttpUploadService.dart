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

  Future uploadImage({
    required XFile file,
  }) async {
    final uri = Uri.parse('http://192.168.1.4:8000/api/image');
    try {
      http.MultipartRequest request = http.MultipartRequest("POST", uri);
      http.MultipartFile multipartFile =
      await http.MultipartFile.fromPath('image', file.path);
      request.files.add(multipartFile);
      request.headers.addAll(_header());
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print('hehe ${file.path},${file.runtimeType},${file.hashCode}');
      print(jsonDecode(response.body));
      print('hoho');
      return jsonDecode(response.body);
    } catch (e) {
      return null;
    }
  }

  _header() {
    return {"Content-Type": "multipart/form-data"
    };
  }

}