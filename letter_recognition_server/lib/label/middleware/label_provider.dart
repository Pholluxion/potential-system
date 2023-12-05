import 'package:dart_frog/dart_frog.dart';

import 'package:letter_recognition_server/label/cubit/label_cubit.dart';

/// A [LabelCubit] that manages the state of the label
final _state = LabelCubit();

/// Provides an instance of a [LabelCubit].
final labelProvider = provider<LabelCubit>((_) => _state);
