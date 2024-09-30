import 'dart:io';

import 'package:bubble_gpt/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareService {
  static Future<String> loadDocumentFromNetwork(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      final bytes = response.bodyBytes;
      final filename = basename(url);
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$filename');
      await file.writeAsBytes(bytes, flush: true);
      return file.path;
    } catch (e) {
      return "";
    }
  }

  static Future<void> shareImage(String url, String description) async {
    var files = <XFile>[];
    EasyLoading.show();
    var file = await loadDocumentFromNetwork(url);
    EasyLoading.dismiss();
    if (file != "") {
      files.add(XFile(file));
      try {
        await Share.shareXFiles(files, text: description);
      } catch (e) {
        debugPrint("==> $e");
        Utility.showToastMessage(e.toString());
      } finally {
        EasyLoading.dismiss();
      }
    } else {
      Utility.showToastMessage("Something went wrong!");
    }
  }
}
