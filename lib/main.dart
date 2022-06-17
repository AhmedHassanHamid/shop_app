import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/on_boarding/cubit/cubit.dart';

import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/styles/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    ()async {
      // Use blocs...
      await CacheHelper.init();
      DioHelper.init();
      bool? isDark = CacheHelper.getData(key: 'isDark');
      Widget widget;
      bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
      String? token = CacheHelper.getData(key: 'token');
      print(token);

      if (onBoarding !=null) {
        if (token != null) {
            widget = ShopLayout();
        }else {
          widget = LoginScreen();
        }
      }else{
        widget = OnBoardingScreen();
      }
      print(onBoarding);
       runApp( MyApp(isDark: isDark, startWidget: widget)); 
    },
    blocObserver: MyBlocObserver(),
    );
  
}

class MyApp extends StatelessWidget {

   bool? isDark;
   Widget? startWidget;
   MyApp({this.isDark ,   this.startWidget});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData()),
        ),

        BlocProvider(
          create: ((context) => ShopAppCubit()),
        ),
      ],
      child: BlocConsumer<ShopCubit , ShopStates>(
        listener: (context , state) {},
        builder:(context , state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ShopAppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          home: startWidget,
        );
        },
      ),
    );
  }
}

