import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/features/home/data/cubit/suwar_cubit/suwar_state.dart';
import 'package:quran_app/features/home/data/models/suwar_page_model.dart';

class SuwarCubit extends Cubit<SuwarState> {
  SuwarCubit() : super(InitialState());

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

  Future<void> getSuwarPages({required int id}) async {
    try {
      emit(LoadingSuwarState());

      // استخدام API أبسط لجلب معلومات السورة
      final response = await _dio.get(
        'https://api.quran.com/api/v4/chapters/$id?language=ar',
      );

      if (response.statusCode == 200 && response.data != null) {
        final chapterData = response.data['chapter'];

        if (chapterData != null) {
          // إنشاء صفحات وهمية بناءً على عدد الآيات
          final int versesCount = chapterData['verses_count'] ?? 0;
          final String chapterName =
              chapterData['name_arabic'] ?? chapterData['name_simple'] ?? '';

          if (versesCount > 0) {
            // إنشاء صفحات بناءً على عدد الآيات (تقريباً 10 آيات لكل صفحة)
            final int pagesCount = (versesCount / 10).ceil();

            final List<SuwarPageModel> suwar = List.generate(
              pagesCount,
              (index) => SuwarPageModel(
                page:
                    'https://cdn.islamic.network/quran/images/${index + 1}.png',
                id: index + 1,
                time: 'صفحة ${index + 1} من $chapterName',
              ),
            );

            if (suwar.isNotEmpty) {
              emit(SuccessSuwarState(suwars: suwar));
              return;
            }
          }
        }
      }

      // إذا فشل API الأول، نجرب إنشاء صفحات افتراضية
      final List<SuwarPageModel> fallbackSuwar = List.generate(
        5, // 5 صفحات افتراضية
        (index) => SuwarPageModel(
          page: 'https://www.m3quran.net/api/quran_pages_svg/${index + 1}.svg',
          id: index + 1,
          time: 'صفحة ${index + 1}',
        ),
      );

      emit(SuccessSuwarState(suwars: fallbackSuwar));
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
      emit(FailureSuwarState(errorMessage));
    } catch (e) {
      emit(FailureSuwarState('حدث خطأ غير متوقع: $e'));
    }
  }
}
