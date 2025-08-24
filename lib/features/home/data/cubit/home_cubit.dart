import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/features/home/data/cubit/home_state.dart';
import 'package:quran_app/features/home/data/models/radio_model.dart';
import 'package:quran_app/features/home/data/models/surah_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());
  Dio dio = Dio();

  String selectedButtonName = "";
  onClick({required String buttonName}) async {
    selectedButtonName = buttonName;
    try {
      emit(HomeLoadingState());
      var response = await dio.get(
        "https://mp3quran.net/api/v3/?language=ar",
      );
      if (buttonName == "Suwar") {
        List<SurahModel> suwar = [];
        for (var surah in response.data['Suwar']) {
          suwar.add(SurahModel.fromJson(surah));
        }
        emit(SuwarSuccessState(suwarList: suwar));
      } else {
        List<RadioModel> radio = [];
        for (var radio in response.data['Radio']) {
          radio.add(RadioModel.fromJson(radio));
        }
        emit(RadioSuccessState(radioList: radio));
      }
    } catch (e) {
      emit(HomeFailureState(errorMessage: e.toString()));
    }
  }
}
