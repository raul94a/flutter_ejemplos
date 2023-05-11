import 'package:flutter/material.dart';

mixin MaterialStatePropertyMixin{
  MaterialStateProperty<T> getProperty<T>(T property){
    return MaterialStateProperty.resolveWith((states) => property);
  }
}