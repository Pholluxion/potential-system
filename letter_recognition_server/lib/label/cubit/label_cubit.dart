import 'package:broadcast_bloc/broadcast_bloc.dart';
import 'package:letter_recognition_server/label/label.dart';

/// LabelCubit is a Cubit that emits a [Label] object.
class LabelCubit extends BroadcastCubit<Label> {
  /// Create an instance of [LabelCubit]
  LabelCubit() : super('');

  /// Update the state of the cubit
  void updateLabel(String label) => emit(label);
}
