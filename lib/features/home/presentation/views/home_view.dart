import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/utils/app_assets.dart';
import 'package:quran_app/core/utils/app_colors.dart';
import 'package:quran_app/core/widgets/custom_category_button.dart';
import 'package:quran_app/core/widgets/custom_suwar.dart';
import 'package:quran_app/core/widgets/logo_name.dart';
import 'package:quran_app/features/home/data/cubit/home_cubit/home_cubit.dart';
import 'package:quran_app/features/home/data/cubit/home_cubit/home_state.dart';
import 'package:quran_app/features/home/data/cubit/suwar_cubit/suwar_cubit.dart';
import 'package:quran_app/features/home/presentation/views/suwar_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SuwarCubit(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      const LogoName(),
                      const Text(
                        'ٱلْقُرْآنُ ٱلْكَرِيمُ',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Text(
                        'Ramadn 15 1443',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          shadowColor: const Color(0xFF0738DB),
                          elevation: 6,
                          minimumSize: const Size(150, 40),
                        ),
                        child: const Text(
                          " Fagr 4:15 ",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Flexible(child: Image.asset(AppAssets.man)),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                "Categories",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  CustomCategoryButton(
                    buttonName: 'Suwar',
                    onTap: () {
                      BlocProvider.of<HomeCubit>(
                        context,
                      ).onClick(buttonName: 'Suwar');
                    },
                  ),
                  const SizedBox(width: 10),
                  CustomCategoryButton(
                    buttonName: 'Radio',
                    onTap: () {
                      BlocProvider.of<HomeCubit>(
                        context,
                      ).onClick(buttonName: 'Radio');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              BlocConsumer<HomeCubit, HomeState>(
                listener: (context, state) {
                  if (state is HomeFailureState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 5),
                        action: SnackBarAction(
                          label: 'إعادة المحاولة',
                          textColor: Colors.white,
                          onPressed: () {
                            // إعادة المحاولة مع آخر button تم اختياره
                            final cubit = BlocProvider.of<HomeCubit>(context);
                            if (cubit.selectedButtonName.isNotEmpty) {
                              cubit.onClick(
                                buttonName: cubit.selectedButtonName,
                              );
                            }
                          },
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is HomeFailureState) {
                    return Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              state.errorMessage,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                // إعادة المحاولة مع آخر button تم اختياره
                                final cubit = BlocProvider.of<HomeCubit>(
                                  context,
                                );
                                if (cubit.selectedButtonName.isNotEmpty) {
                                  cubit.onClick(
                                    buttonName: cubit.selectedButtonName,
                                  );
                                }
                              },
                              child: const Text('إعادة المحاولة'),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (state is SuwarSuccessState) {
                    return Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 3),
                        itemCount: state.suwarList.length,
                        itemBuilder: (context, index) {
                          return CustomSuwar(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SuwarView(
                                    surahId: state.suwarList[index].id,
                                  ),
                                ),
                              );
                            },
                            title: state.suwarList[index].name,
                            subtitle: state.suwarList[index].makkia == 1
                                ? "مكية"
                                : "مدنية",
                          );
                        },
                      ),
                    );
                  } else if (state is HomeLoadingState) {
                    return const Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text('جاري التحميل...'),
                          ],
                        ),
                      ),
                    );
                  } else if (state is RadioSuccessState) {
                    return Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 3),
                        itemCount: state.radioList.length,
                        itemBuilder: (context, index) {
                          return CustomSuwar(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SuwarView(
                                    surahId: state.radioList[index].id,
                                  ),
                                ),
                              );
                            },
                            title: state.radioList[index].name,
                            subtitle: state.radioList[index].url,
                          );
                        },
                      ),
                    );
                  } else {
                    return const Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              "اختر فئة لعرض البيانات",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
