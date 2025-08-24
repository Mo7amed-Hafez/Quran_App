import 'package:quran_app/features/home/data/models/suwar_page_model.dart';

class SuwarState {}
class InitialState extends SuwarState {}
class LoadingSuwarState extends SuwarState {}
class SuccessSuwarState extends SuwarState {
final List <SuwarPageModel> suwars;

  SuccessSuwarState({required this.suwars});
}
class FailureSuwarState extends SuwarState {
  final String message;
  FailureSuwarState(this.message,);
}