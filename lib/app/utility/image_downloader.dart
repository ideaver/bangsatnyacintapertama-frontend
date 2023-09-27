import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_downloader_web/src/image_type.dart';
import 'package:universal_html/html.dart' as html;

import 'console_log.dart';

class ImageDownloader {
  // static var httpClient = new HttpClient();

  static Future<String?> download(BuildContext context, String? url, String id, {bool clearCurrentCache = true}) async {
    // Download image
    // File? file;

    if (url != null && url != '') {
      bool validURL = Uri.parse(url).isAbsolute;
      cl('$url is valid uri = $validURL');

      cl(url.replaceRange(0, 8, ""));

      // var ss = Uri.parse(url);

      if (validURL) {
        var res = await http.get(
          // Uri.https(ss.host, ss.path),
          Uri.parse(url),
          // headers: {
          //   "Accept":
          //       "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
          //   //   // "content-type": "application/json",
          //   "Access-Control-Allow-Origin": "*", // Required for CORS support to work
          //   //   // "Access-Control-Allow-Credentials": "true", // Required for cookies, authorization headers with HTTPS
          //   //   // "Access-Control-Allow-Headers":
          //   //   //     "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          //   //   // "Access-Control-Allow-Methods": "GET, OPTIONS"
          // "Access-Control-Allow-Origin": "true",
          // 'Content-Type': 'application/json',
          // 'Accept': '*/*'
          // },
        );

        // final blob = html.Blob([res.bodyBytes]);
        // final urlBlob = html.Url.createObjectUrlFromBlob(blob);
        // final anchor = html.document.createElement('a') as html.AnchorElement
        //   ..href = urlBlob
        //   ..style.display = 'none'
        //   ..download = "filename";
        // html.document.body?.children.add(anchor);

        // anchor.click();

        // html.document.body?.children.remove(anchor);
        // html.Url.revokeObjectUrl(url);

        // var response = await res.close();
        // var bytes = await consolidateHttpClientResponseBytes(response);

        await downloadImageFromUInt8List(
          uInt8List: res.bodyBytes,
          name: id,
          type: "image/${url.split(".").last}",
        );

        // final html.AnchorElement anchorElement = html.AnchorElement(href: url);
        // anchorElement.download = id;
        // anchorElement.click();

        // Directory documentDirectory = await getTemporaryDirectory();

        // file = File(
        //   path.join(
        //     documentDirectory.path,
        //     id,
        //   ),
        // );

        // file.writeAsBytesSync(response.bodyBytes);
      } else {
        return null;
      }
    }

    // if (file != null && file.path != '') {
    //   if (clearCurrentCache) {
    //     imageCache.clear();
    //     imageCache.clearLiveImages();
    //   }

    //   await precacheImage(FileImage(file), context);

    //   return file.path;
    // } else {
    //   return null;
    // }
  }

  /// Download image from uInt8List to user device
  static Future<void> downloadImageFromUInt8List({
    required Uint8List uInt8List,
    double imageQuality = 0.95,
    String? name,
    required String type,
    ImageType imageType = ImageType.png,
  }) async {
    final image = await decodeImageFromList(uInt8List);

    final html.CanvasElement canvas = html.CanvasElement(
      height: image.height,
      width: image.width,
    );

    final ctx = canvas.context2D;

    final List<String> binaryString = [];

    for (final imageCharCode in uInt8List) {
      final charCodeString = String.fromCharCode(imageCharCode);
      binaryString.add(charCodeString);
    }
    final data = binaryString.join();

    final base64 = html.window.btoa(data);

    final img = html.ImageElement();

    img.src = "data:$type;base64,$base64";

    final html.ElementStream<html.Event> loadStream = img.onLoad;

    loadStream.listen((event) {
      ctx.drawImage(img, 0, 0);
      final dataUrl = canvas.toDataUrl(type, imageQuality);
      final html.AnchorElement anchorElement = html.AnchorElement(href: dataUrl);
      anchorElement.download = name ?? dataUrl;
      anchorElement.click();
    });
  }
}
