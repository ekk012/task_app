import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/features/cart/bloc/cart_event.dart';
import 'package:task_app/features/cart/bloc/cart_state.dart';
import 'package:task_app/features/home/bloc/home_bloc.dart';
import 'package:task_app/features/home/bloc/home_event.dart';
import 'package:task_app/features/home/bloc/home_state.dart';
import 'package:task_app/features/home/ui/product_tile.dart';
import 'package:task_app/features/summary/ui/summary.dart';

import '../../../utilities/utils.dart';
import '../../cart/bloc/cart_bloc.dart';
import '../models/product_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listener: (context, state) {
        if (state is HomeNavigateToSummaryState) {
          Navigator.pushNamed(context, '/summary').then((result) {
            homeBloc.add(HomeInitialEvent());
          });
        }
      },

      // listenWhen: (previous, current) {

      // },
      // buildWhen: (previous, current) {

      // },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.green,
                title: const Text('Home Screen'),
              ),
              body: ListView.builder(
                itemCount: successState.products.length,
                itemBuilder: (context, index) {
                  return ProductTileWidget(
                    cartProducts: successState.products[index],
                  );
                },
              ),
              floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.green,
                  ),
                  BlocBuilder<CartBloc, CartState>(builder: (context, state) {
                    return Text(
                      "${state.totalItems} Items",
                      style: TextStyle(color: Colors.green),
                    );
                  }),
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: FloatingActionButton.extended(
                      backgroundColor: Colors.green,
                      onPressed: () {
                        homeBloc.add(PlaceOrderButtonClicked());
                      },
                      label: const Text(
                        "Place Order",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            );
          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
