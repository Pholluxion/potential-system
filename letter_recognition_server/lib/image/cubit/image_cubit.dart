import 'package:broadcast_bloc/broadcast_bloc.dart';

import 'package:letter_recognition_server/image/image.dart';

/// A [Cubit] that manages the state of the image
class ImageCubit extends BroadcastCubit<Image> {
  /// Create an instance of [ImageCubit]
  ImageCubit() : super([]);

  /// Update the state of the cubit
  void update(Image image) => emit(image);
}
