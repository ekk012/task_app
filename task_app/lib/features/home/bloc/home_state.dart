import 'package:flutter/material.dart';
import 'package:task_app/features/home/models/product_model.dart';
import 'package:task_app/features/home/ui/home.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<Product> products;

  HomeLoadedSuccessState({required this.products});
}

class HomeErrorState extends HomeState {}

class HomeNavigateToSummaryState extends HomeActionState {}



