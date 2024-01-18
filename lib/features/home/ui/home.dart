import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/features/cart/ui/cart.dart';
import 'package:flutter_application_1/features/home/bloc/home_bloc.dart';
import 'package:flutter_application_1/features/home/ui/product_widget.dart';
import 'package:flutter_application_1/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Cart()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Wishlist()));
        } else if (state is HomeProductItemCartedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Item Carted')));
        } else if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(
                const SnackBar(content: Text('Item Wishlisted')));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: buildBody(state),
        );
      },
    );
  }

  Widget buildBody(HomeState state) {
    if (state is HomeLoadingState) {
      return  const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is HomeLoadedSuccessState) {
      return buildLoadedSuccess(state);
    } else if (state is HomeErrorState) {
      return const Center(
        child: Text('Error'),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildLoadedSuccess(HomeLoadedSuccessState state) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 122, 113, 99),
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255, 96, 79, 51),
        title:const Text('Adidas Shoes'),
        actions: [
          IconButton(
            onPressed: () {
              homeBloc.add(HomeWishlistButtonNavigateEvent());
            },
            icon: const Icon(Icons.favorite_border),
          ),
          IconButton(
            onPressed: () {
              homeBloc.add(HomeCartButtonNavigateEvent());
            },
            icon: const Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: state.products.length,
        itemBuilder: (context, index) {
          return ProductWidget(
            homeBloc: homeBloc,
            productDataModel: state.products[index],
          );
        },
      ),
    );
  }
}
