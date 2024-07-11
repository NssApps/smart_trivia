

import 'package:flutter_riverpod/flutter_riverpod.dart';

final numQuestionsProvider = StateProvider<int>((ref) => 10);
final categoryProvider = StateProvider<Map<String,String>>((ref) => {'': 'Any'});
final categorySelectedProvider = StateProvider<String>((ref) => '');
final difficultyProvider = StateProvider<String>((ref) => 'Any');
final typeProvider = StateProvider<String>((ref) => 'Any');