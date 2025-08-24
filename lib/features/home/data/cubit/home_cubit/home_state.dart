import 'package:quran_app/features/home/data/models/radio_model.dart';
import 'package:quran_app/features/home/data/models/surah_model.dart';

class HomeState {}

class HomeInitialState extends HomeState {}  

class HomeLoadingState extends HomeState {}

class SuwarSuccessState extends HomeState {
  final List<SurahModel> suwarList;
  SuwarSuccessState({required this.suwarList});
}

class RadioSuccessState extends HomeState {
  final List<RadioModel> radioList;
  RadioSuccessState({required this.radioList});
}

class HomeFailureState extends HomeState {
  final String errorMessage;
  HomeFailureState({required this.errorMessage});
}

