part of 'wishlist_bloc.dart';

abstract class WishlistEvent {}

class WishlistInitialEvent extends WishlistEvent {}

class WishlistRemoveFromWishEvent extends WishlistEvent {
  final ProductDataModel productDataModel;
  WishlistRemoveFromWishEvent({
    required this.productDataModel,
  });
}
