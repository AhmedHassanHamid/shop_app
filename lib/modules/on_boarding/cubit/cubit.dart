import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/on_boarding/cubit/states.dart';
import 'package:shop_app/network/local/cache_helper.dart';

class ShopAppCubit extends Cubit<ShopStates> {
  ShopAppCubit() : super(ShopInitialState());

  static ShopAppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  ThemeMode appMode = ThemeMode.dark;

  void changeNewsMode({bool? fromShared}){
    if (fromShared != null) {
      isDark = fromShared;
      emit(ShopChangeModeState());
    }else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
      emit(ShopChangeModeState());
    });
    }
    
    
  }
}