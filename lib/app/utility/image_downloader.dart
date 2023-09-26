import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'console_log.dart';

class ImageDownloader {
  static final client = new Client();

  static Future<String?> download(BuildContext context, String? url, String id, {bool clearCurrentCache = true}) async {
    // Download image
    File? file;

    if (url != null && url != '') {
      bool validURL = Uri.parse(url).isAbsolute;
      cl('$url is valid uri = $validURL');

      if (validURL) {
        var response = await client.get(Uri.parse(url));

        Directory documentDirectory = await getApplicationDocumentsDirectory();

        file = File(
          path.join(
            documentDirectory.path,
            id,
          ),
        );

        file.writeAsBytesSync(response.bodyBytes);
      } else {
        return null;
      }
    }

    if (file != null && file.path != '') {
      if (clearCurrentCache) {
        imageCache.clear();
        imageCache.clearLiveImages();
      }

      await precacheImage(FileImage(file), context);

      return file.path;
    } else {
      return null;
    }
  }
}
