import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/utils/app_assets.dart';
import 'package:quran_app/core/utils/app_colors.dart';
import 'package:quran_app/core/widgets/custom_category_button.dart';
import 'package:quran_app/core/widgets/custom_suwar.dart';
import 'package:quran_app/core/widgets/logo_name.dart';
import 'package:quran_app/features/home/data/cubit/home_cubit.dart';
import 'package:quran_app/features/home/data/cubit/home_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    LogoName(),
                    Text(
                      'ٱلْقُرْآنُ ٱلْكَرِيمُ',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '19:20',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
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
                      child: Text(
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
            Text(
              "Categories",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              spacing: 10,
              children: [
                CustomCategoryButton(
                  buttonName: 'Suwar',
                  onTap: () {
                    BlocProvider.of<HomeCubit>(
                      context,
                    ).onClick(buttonName: 'Suwar');
                  },
                ),
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

            SizedBox(height: 10),

            BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is HomeFailureState) {
                  return Center(child: Text(state.errorMessage));
                } else if (state is SuwarSuccessState) {
                  return Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 3),
                      itemCount: state.suwarList.length,
                      itemBuilder: (context, index) {
                        return CustomSuwar(
                          title: state.suwarList[index].name,
                          subtitle: state.suwarList[index].makkia == 1
                              ? "مكية"
                              : "مدنية",
                        );
                      },
                    ),
                  );
                } else if (state is HomeLoadingState) {
                  return const Align(
                    alignment: AlignmentDirectional.center,
                    child: CircularProgressIndicator(),
                  );
                } else if (state is RadioSuccessState) {
                  return Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 3),
                      itemCount: state.radioList.length,
                      itemBuilder: (context, index) {
                        return CustomSuwar(
                          title: state.radioList[index].name,
                          subtitle: state.radioList[index].url ?? "Not Found",
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      "Not Found Data Yet",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
