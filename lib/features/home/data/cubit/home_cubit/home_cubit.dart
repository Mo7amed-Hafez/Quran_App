import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/features/home/data/cubit/home_cubit/home_state.dart';
import 'package:quran_app/features/home/data/models/radio_model.dart';
import 'package:quran_app/features/home/data/models/surah_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'User-Agent': 'QuranApp/1.0',
      },
    ),
  );

  String selectedButtonName = "";

  Future<void> onClick({required String buttonName}) async {
    selectedButtonName = buttonName;

    try {
      emit(HomeLoadingState());

      if (buttonName == "Suwar") {
        
        final response = await _dio.get(
          'https://api.quran.com/api/v4/chapters?language=ar',
        );

        if (response.statusCode == 200 && response.data != null) {
          final List<dynamic> chaptersData = response.data['chapters'] ?? [];

          if (chaptersData.isNotEmpty) {
            final List<SurahModel> suwar = chaptersData
                .where((chapter) => chapter != null)
                .map(
                  (chapter) => SurahModel(
                    id: chapter['id'] ?? 0,
                    name:
                        chapter['name_arabic'] ?? chapter['name_simple'] ?? '',
                    makkia: chapter['revelation_place'] == 'makkah' ? 1 : 0,
                  ),
                )
                .toList();

            if (suwar.isNotEmpty) {
              emit(SuwarSuccessState(suwarList: suwar));
              return;
            }
          }
        }

        emit(HomeFailureState(errorMessage: 'فشل في جلب بيانات القرآن'));
      } else if (buttonName == "Radio") {
       
        final response = await _dio.get(
          'https://mp3quran.net/api/v3/radios?language=ar',
        );

        if (response.statusCode == 200 && response.data != null) {
          final List<dynamic> radioData = response.data['radios'] ?? [];

          if (radioData.isNotEmpty) {
            final List<RadioModel> radio = radioData
                .where((radioItem) => radioItem != null)
                .map((radioItem) => RadioModel.fromJson(radioItem))
                .toList();

            if (radio.isNotEmpty) {
              emit(RadioSuccessState(radioList: radio));
              return;
            }
          }
        }

        emit(HomeFailureState(errorMessage: 'فشل في جلب بيانات الراديو'));
      } else {
        emit(HomeFailureState(errorMessage: 'نوع غير معروف: $buttonName'));
      }
    } on DioException catch (e) {
      String errorMessage = 'حدث خطأ في الاتصال';
      if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'انتهت مهلة الاتصال - تحقق من الإنترنت';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'انتهت مهلة استقبال البيانات';
      } else if (e.type == DioExceptionType.badResponse) {
        errorMessage =
            'خطأ في الاستجابة: ${e.response?.statusCode} - ${e.response?.statusMessage}';
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage = 'فشل في الاتصال بالخادم';
      } else if (e.type == DioExceptionType.cancel) {
        errorMessage = 'تم إلغاء الطلب';
      }
      emit(HomeFailureState(errorMessage: errorMessage));
    } catch (e) {
      emit(HomeFailureState(errorMessage: 'حدث خطأ غير متوقع: $e'));
    }
  }
}
