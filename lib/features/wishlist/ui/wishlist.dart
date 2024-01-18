import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter_application_1/features/wishlist/ui/wishlist_widget.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final WishlistBloc wishlistBloc = WishlistBloc();
  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 149, 142, 129),
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255, 96, 79, 51),
        title: const Text('Wishlist'),
      ),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        builder: (context, state) {
          switch (state.runtimeType) {
            case WishlistSuccessState:
              final wishSuccessState = state as WishlistSuccessState;
              return ListView.builder(
                  itemCount: wishSuccessState.wishlistItems.length,
                  itemBuilder: (context, index) {
                    return WishlistWidget(
                        wishlistBloc: wishlistBloc,
                        productDataModel:
                            wishSuccessState.wishlistItems[index]);
                  });
          }
          return Container();
        },
      ),
    );
  }
}
