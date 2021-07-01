import 'package:flutter/cupertino.dart';
import 'package:lancong/global/global_function.dart' as globalFunction;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';

class StoryFormNotifier extends ChangeNotifier {
  String _errorCategoryId = '';
  String _errorImage = '';
  String _errorTitle = '';
  String _errorSlug = '';
  String _errorDescription = '';
  String _errorSummary = '';
  String _errorContent = '';
  String _errorStatus = '';
  String _errorFeatured = '';

  String _errorUndefined = '';

  String get errorCategoryId {
    return _errorCategoryId;
  }

  String get errorImage {
    return _errorImage;
  }

  String get errorTitle {
    return _errorTitle;
  }

  String get errorSlug {
    return _errorSlug;
  }

  String get errorDescription {
    return _errorDescription;
  }

  String get errorSummary {
    return _errorSummary;
  }

  String get errorContent {
    return _errorContent;
  }

  String get errorStatus {
    return _errorStatus;
  }

  String get errorFeatured {
    return _errorFeatured;
  }

  String get errorUndefined {
    return _errorUndefined;
  }

  Future<bool> storyStore(String categoryId, File image, String title, slug,
      description, summary, content, status, bool featured) async {
    bool storyResult = false;
    var server = await globalFunction.getServer();
    var token = await globalFunction.getToken();
    var url = Uri.http(server, '/api/post');
    var request = http.MultipartRequest("POST", url);
    var stream = new http.ByteStream(Stream.castFrom(image.openRead()));
    var length = await image.length();
    var imageFile = http.MultipartFile("image", stream, length,
        filename: basename(image.path));
    request.headers['Accept'] = 'application/json';
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['category_id'] = categoryId;
    request.files.add(imageFile);
    request.fields['title'] = title;
    request.fields['slug'] = slug;
    request.fields['description'] = description;
    request.fields['summary'] = summary;
    request.fields['content'] = content;
    request.fields['status'] = status;
    request.fields['featured'] = featured.toString();
    final response = await request.send();
    var preResult = await response.stream.bytesToString();
    var result = json.decode(preResult);
    print(result);
    if (response.statusCode == 201) {
      storyResult = true;
    } else if (response.statusCode == 400) {
      if (result['category_id'] != null) {
        var listError = result['category_id'];
        var strError = listError.join('\n');
        _errorCategoryId = strError;
      } else {
        _errorCategoryId = '';
      }
      if (result['image'] != null) {
        var listError = result['image'];
        var strError = listError.join('\n');
        _errorImage = strError;
      } else {
        _errorImage = '';
      }
      if (result['title'] != null) {
        var listError = result['title'];
        var strError = listError.join('\n');
        _errorTitle = strError;
      } else {
        _errorTitle = '';
      }
      if (result['slug'] != null) {
        var listError = result['slug'];
        var strError = listError.join('\n');
        _errorSlug = strError;
      } else {
        _errorSlug = '';
      }
      if (result['description'] != null) {
        var listError = result['description'];
        var strError = listError.join('\n');
        _errorDescription = strError;
      } else {
        _errorDescription = '';
      }
      if (result['summary'] != null) {
        var listError = result['summary'];
        var strError = listError.join('\n');
        _errorSummary = strError;
      } else {
        _errorSummary = '';
      }
      if (result['content'] != null) {
        var listError = result['content'];
        var strError = listError.join('\n');
        _errorContent = strError;
      } else {
        _errorContent = '';
      }
    } else {
      if (result['message'] != null) {
        _errorUndefined = result['message'];
      } else {
        _errorUndefined = '';
      }
    }
    notifyListeners();
    return storyResult;
  }
}
