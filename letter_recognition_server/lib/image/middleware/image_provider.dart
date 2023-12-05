import 'package:dart_frog/dart_frog.dart';

import 'package:letter_recognition_server/image/image.dart';

/// A [ImageCubit] that manages the state of the image
final _state = ImageCubit();

/// Provides an instance of a [ImageCubit].
final imageProvider = provider<ImageCubit>((_) => _state);
