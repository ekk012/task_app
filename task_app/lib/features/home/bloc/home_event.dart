import 'package:flutter/material.dart';
import 'package:task_app/features/home/ui/home.dart';

import '../models/product_model.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class PlaceOrderButtonClicked extends HomeEvent {}
