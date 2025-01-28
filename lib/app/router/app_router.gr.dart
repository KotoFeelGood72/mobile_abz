// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:mobile_abz/presentation/pages/contacts_screen.dart' as _i1;
import 'package:mobile_abz/presentation/pages/faq_screen.dart' as _i2;
import 'package:mobile_abz/presentation/pages/featured/featured_id_screen.dart'
    as _i3;
import 'package:mobile_abz/presentation/pages/featured/featured_screen.dart'
    as _i4;
import 'package:mobile_abz/presentation/pages/home_screen.dart' as _i6;
import 'package:mobile_abz/presentation/pages/reviews_screen.dart' as _i7;

/// generated route for
/// [_i1.ContactsScreen]
class ContactsRoute extends _i8.PageRouteInfo<void> {
  const ContactsRoute({List<_i8.PageRouteInfo>? children})
      : super(ContactsRoute.name, initialChildren: children);

  static const String name = 'ContactsRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i1.ContactsScreen();
    },
  );
}

/// generated route for
/// [_i2.FaqScreen]
class FaqRoute extends _i8.PageRouteInfo<void> {
  const FaqRoute({List<_i8.PageRouteInfo>? children})
      : super(FaqRoute.name, initialChildren: children);

  static const String name = 'FaqRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i2.FaqScreen();
    },
  );
}

/// generated route for
/// [_i3.FeaturedIdScreen]
class FeaturedIdRoute extends _i8.PageRouteInfo<FeaturedIdRouteArgs> {
  FeaturedIdRoute({
    _i9.Key? key,
    required String id,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          FeaturedIdRoute.name,
          args: FeaturedIdRouteArgs(key: key, id: id),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'FeaturedIdRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<FeaturedIdRouteArgs>(
        orElse: () => FeaturedIdRouteArgs(id: pathParams.getString('id')),
      );
      return _i3.FeaturedIdScreen(key: args.key, id: args.id);
    },
  );
}

class FeaturedIdRouteArgs {
  const FeaturedIdRouteArgs({this.key, required this.id});

  final _i9.Key? key;

  final String id;

  @override
  String toString() {
    return 'FeaturedIdRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i4.FeaturedScreen]
class FeaturedRoute extends _i8.PageRouteInfo<void> {
  const FeaturedRoute({List<_i8.PageRouteInfo>? children})
      : super(FeaturedRoute.name, initialChildren: children);

  static const String name = 'FeaturedRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i4.FeaturedScreen();
    },
  );
}

/// generated route for
/// [_i6.HomeScreen]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i6.HomeScreen();
    },
  );
}

/// generated route for
/// [_i7.ReviewsScreen]
class ReviewsRoute extends _i8.PageRouteInfo<void> {
  const ReviewsRoute({List<_i8.PageRouteInfo>? children})
      : super(ReviewsRoute.name, initialChildren: children);

  static const String name = 'ReviewsRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.ReviewsScreen();
    },
  );
}
