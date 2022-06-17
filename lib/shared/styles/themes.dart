import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme:  AppBarTheme(
            iconTheme: IconThemeData(color:Colors.white),
            backgroundColor: HexColor('333739'),
            elevation: 0,
            titleTextStyle: TextStyle(
              color:Colors.white,
              fontSize: 20,
            fontWeight: FontWeight.bold,
            ),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: HexColor('333739'),
              statusBarIconBrightness: Brightness.light,
            )
          ),
          scaffoldBackgroundColor: HexColor('333739'),
          bottomNavigationBarTheme:  BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            elevation: 20,
            backgroundColor: HexColor('333739'),
          ),
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontSize:18,
              fontWeight:FontWeight.w600,
              color:Colors.white,
            ),
          ),
          fontFamily: 'Jannah',
          );

ThemeData lightTheme = ThemeData(
          scaffoldBackgroundColor:Colors.white,
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color:Colors.black),
            backgroundColor:Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
              color:Colors.black,
              fontSize: 20,
            fontWeight: FontWeight.bold,
            ),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            )
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
             type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            elevation: 20,
            backgroundColor: Colors.white,
          ),
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontSize:18,
              fontWeight:FontWeight.w600,
              color:Colors.black,
            ),
          ),
          fontFamily: 'Jannah',
        );