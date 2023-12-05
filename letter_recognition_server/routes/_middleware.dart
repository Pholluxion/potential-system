import 'package:dart_frog/dart_frog.dart';

import 'package:letter_recognition_server/image/image.dart';
import 'package:letter_recognition_server/label/label.dart';

Handler middleware(Handler handler) =>
    handler.use(imageProvider).use(labelProvider);
