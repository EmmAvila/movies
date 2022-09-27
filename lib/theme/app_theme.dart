import 'package:flutter/material.dart';

// esta clase es el tema global de la aplicacion
class AppTheme {
  static const Color primaryLight = Color.fromARGB(211, 40, 56, 233);
  static const Color primaryLightText = Color.fromARGB(255, 255, 255, 255);
  static const Color backgroundColor = Color.fromARGB(59, 75, 64, 21);

  //...copywith()  copia el thema y solo sobrescribe lo que nosotros asignamos
  static final ThemeData lightTheme = ThemeData.light().copyWith(
      //color primario que ciertoos widgets pueden usar
      primaryColor: primaryLight,

      //tema global para los appBar
      appBarTheme: const AppBarTheme(color: primaryLight, elevation: 5),

      //Temas texButons
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(primary: primaryLight)),

      //floatingActionButtonTheme
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: primaryLight),
      //elevatedbutton
      elevatedButtonTheme: ElevatedButtonThemeData(
        //si onPress esta en null el boton no tiene stylos
        style: ElevatedButton.styleFrom(
            primary: AppTheme.primaryLight,
            shape: const StadiumBorder(),
            elevation: 5),
      ),

      // Inputs
      inputDecorationTheme: const InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: Colors.blueGrey),
        suffixIconColor: Colors.blueGrey,
        enabledBorder: OutlineInputBorder(
            // cuando solo esta visible
            borderSide: BorderSide(color: primaryLight),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        focusedBorder: OutlineInputBorder(
            // cuando esta activado
            borderSide: BorderSide(color: primaryLight),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        border: OutlineInputBorder(
            // cuando solo esta visible
            borderSide: BorderSide(color: Colors.blueAccent),
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ));

  // cardTheme: const CardTheme(elevation: 25, color: primaryLight) ????

}
