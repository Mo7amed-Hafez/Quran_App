import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_app/features/home/data/cubit/suwar_cubit/suwar_cubit.dart';
import 'package:quran_app/features/home/data/cubit/suwar_cubit/suwar_state.dart';

class SuwarView extends StatefulWidget {
  final int surahId;

  const SuwarView({super.key, required this.surahId});

  @override
  State<SuwarView> createState() => _SuwarViewState();
}

class _SuwarViewState extends State<SuwarView> {
  @override
  void initState() {
    super.initState();
    // نجيب البيانات أول ما يفتح
    context.read<SuwarCubit>().getSuwarPages(id: widget.surahId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("عرض السورة"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocConsumer<SuwarCubit, SuwarState>(
        listener: (context, state) {
          if (state is FailureSuwarState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 5),
                action: SnackBarAction(
                  label: 'إعادة المحاولة',
                  textColor: Colors.white,
                  onPressed: () {
                    context.read<SuwarCubit>().getSuwarPages(
                      id: widget.surahId,
                    );
                  },
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is SuccessSuwarState) {
            if (state.suwars.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.inbox_outlined, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      "لا توجد صفحات متاحة",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.suwars.length,
              itemBuilder: (context, index) {
                final suwar = state.suwars[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: _buildImageWidget(suwar.page),
                  ),
                );
              },
            );
          } else if (state is FailureSuwarState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    "خطأ: ${state.message}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<SuwarCubit>().getSuwarPages(
                        id: widget.surahId,
                      );
                    },
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('جاري تحميل صفحات السورة...'),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildImageWidget(String imageUrl) {
    if (imageUrl.endsWith('.svg')) {
      return SvgPicture.network(
        imageUrl,
        placeholderBuilder: (context) => _buildPlaceholder(),
        errorBuilder: (context, error, stackTrace) => _buildFallbackImage(),
      );
    } else {
      return Image.network(
        imageUrl,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildPlaceholder();
        },
        errorBuilder: (context, error, stackTrace) => _buildFallbackImage(),
      );
    }
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 200,
      color: Colors.grey[200],
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 8),
            Text('جاري تحميل الصفحة...'),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackImage() {
    return Container(
      height: 200,
      color: Colors.grey[100],
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.book, size: 64, color: Colors.green),
            SizedBox(height: 8),
            Text(
              'صفحة القرآن',
              style: TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'اضغط لعرض النص',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      height: 200,
      color: Colors.grey[200],
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red),
            SizedBox(height: 8),
            Text('فشل في تحميل الصفحة', style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
