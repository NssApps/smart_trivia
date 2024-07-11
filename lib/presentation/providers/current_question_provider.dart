

import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentQuestionProvider = StateProvider.autoDispose<int>((ref) => 0);