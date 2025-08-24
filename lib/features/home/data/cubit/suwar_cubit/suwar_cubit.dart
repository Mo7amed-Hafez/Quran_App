
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/features/home/data/cubit/suwar_cubit/suwar_state.dart';
import 'package:quran_app/features/home/data/models/suwar_page_model.dart';

class SuwarCubit extends Cubit<SuwarState> {
  SuwarCubit() : super(InitialState());
  final Dio dio = Dio();
  getSuwarPages({required int Id}) async {
try{
  emit(LoadingSuwarState());
  final response = await dio.get("https://mp3quran.net/api/v3/ayat_timing?surah=$Id&read=1");
  List <SuwarPageModel> suwar = [];
  for(var surah in response.data){
    suwar.add(SuwarPageModel.fromJson(surah));
  }
  emit(SuccessSuwarState(suwars: suwar));
  
} catch(e){
  
}
  }
}