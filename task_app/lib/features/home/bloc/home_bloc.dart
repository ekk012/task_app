import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:task_app/data/product_data.dart';
import 'package:task_app/features/home/bloc/home_event.dart';
import 'package:task_app/features/home/bloc/home_state.dart';
import 'package:task_app/features/home/models/product_model.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<PlaceOrderButtonClicked>(placeOrderButtonClicked);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(HomeLoadedSuccessState(
        products: ProductData.products
            .map((e) => Product(
                id: e['id'],
                name: e['name'],
                description: e['description'] ?? '',
                price: e['price'],
                imageUrl: e['imageUrl']
                ))
            .toList()));
  }

  FutureOr<void> placeOrderButtonClicked(
      PlaceOrderButtonClicked event, Emitter<HomeState> emit) {
    emit(HomeNavigateToSummaryState());
  }
}
