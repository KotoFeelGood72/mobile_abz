// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/material.dart' as _i15;
import 'package:mobile_abz/presentation/pages/contacts_screen.dart' as _i1;
import 'package:mobile_abz/presentation/pages/faq_screen.dart' as _i2;
import 'package:mobile_abz/presentation/pages/featured/featured_id_screen.dart'
    as _i3;
import 'package:mobile_abz/presentation/pages/featured/featured_screen.dart'
    as _i4;
import 'package:mobile_abz/presentation/pages/home_screen.dart' as _i5;
import 'package:mobile_abz/presentation/pages/order/order_screen.dart' as _i6;
import 'package:mobile_abz/presentation/pages/portfolio/portfolio_id_screen.dart'
    as _i7;
import 'package:mobile_abz/presentation/pages/portfolio/portfolio_screen.dart'
    as _i8;
import 'package:mobile_abz/presentation/pages/reviews_screen.dart' as _i9;
import 'package:mobile_abz/presentation/pages/sale/sale_id_screen.dart' as _i10;
import 'package:mobile_abz/presentation/pages/sale/sale_screen.dart' as _i11;
import 'package:mobile_abz/presentation/pages/services/services_id_screen.dart'
    as _i12;
import 'package:mobile_abz/presentation/pages/services/services_screen.dart'
    as _i13;

/// generated route for
/// [_i1.ContactsScreen]
class ContactsRoute extends _i14.PageRouteInfo<void> {
  const ContactsRoute({List<_i14.PageRouteInfo>? children})
    : super(ContactsRoute.name, initialChildren: children);

  static const String name = 'ContactsRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i1.ContactsScreen();
    },
  );
}

/// generated route for
/// [_i2.FaqScreen]
class FaqRoute extends _i14.PageRouteInfo<void> {
  const FaqRoute({List<_i14.PageRouteInfo>? children})
    : super(FaqRoute.name, initialChildren: children);

  static const String name = 'FaqRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i2.FaqScreen();
    },
  );
}

/// generated route for
/// [_i3.FeaturedIdScreen]
class FeaturedIdRoute extends _i14.PageRouteInfo<FeaturedIdRouteArgs> {
  FeaturedIdRoute({
    _i15.Key? key,
    required String id,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         FeaturedIdRoute.name,
         args: FeaturedIdRouteArgs(key: key, id: id),
         rawPathParams: {'id': id},
         initialChildren: children,
       );

  static const String name = 'FeaturedIdRoute';

  static _i14.PageInfo page = _i14.PageInfo(
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

  final _i15.Key? key;

  final String id;

  @override
  String toString() {
    return 'FeaturedIdRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i4.FeaturedScreen]
class FeaturedRoute extends _i14.PageRouteInfo<void> {
  const FeaturedRoute({List<_i14.PageRouteInfo>? children})
    : super(FeaturedRoute.name, initialChildren: children);

  static const String name = 'FeaturedRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i4.FeaturedScreen();
    },
  );
}

/// generated route for
/// [_i5.HomeScreen]
class HomeRoute extends _i14.PageRouteInfo<void> {
  const HomeRoute({List<_i14.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i5.HomeScreen();
    },
  );
}

/// generated route for
/// [_i6.OrderScreen]
class OrderRoute extends _i14.PageRouteInfo<void> {
  const OrderRoute({List<_i14.PageRouteInfo>? children})
    : super(OrderRoute.name, initialChildren: children);

  static const String name = 'OrderRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i6.OrderScreen();
    },
  );
}

/// generated route for
/// [_i7.PortfolioIdScreen]
class PortfolioIdRoute extends _i14.PageRouteInfo<PortfolioIdRouteArgs> {
  PortfolioIdRoute({
    _i15.Key? key,
    required String id,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         PortfolioIdRoute.name,
         args: PortfolioIdRouteArgs(key: key, id: id),
         rawPathParams: {'id': id},
         initialChildren: children,
       );

  static const String name = 'PortfolioIdRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<PortfolioIdRouteArgs>(
        orElse: () => PortfolioIdRouteArgs(id: pathParams.getString('id')),
      );
      return _i7.PortfolioIdScreen(key: args.key, id: args.id);
    },
  );
}

class PortfolioIdRouteArgs {
  const PortfolioIdRouteArgs({this.key, required this.id});

  final _i15.Key? key;

  final String id;

  @override
  String toString() {
    return 'PortfolioIdRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i8.PortfolioScreen]
class PortfolioRoute extends _i14.PageRouteInfo<void> {
  const PortfolioRoute({List<_i14.PageRouteInfo>? children})
    : super(PortfolioRoute.name, initialChildren: children);

  static const String name = 'PortfolioRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i8.PortfolioScreen();
    },
  );
}

/// generated route for
/// [_i9.ReviewsScreen]
class ReviewsRoute extends _i14.PageRouteInfo<void> {
  const ReviewsRoute({List<_i14.PageRouteInfo>? children})
    : super(ReviewsRoute.name, initialChildren: children);

  static const String name = 'ReviewsRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i9.ReviewsScreen();
    },
  );
}

/// generated route for
/// [_i10.SaleIdScreen]
class SaleIdRoute extends _i14.PageRouteInfo<SaleIdRouteArgs> {
  SaleIdRoute({
    _i15.Key? key,
    required String id,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         SaleIdRoute.name,
         args: SaleIdRouteArgs(key: key, id: id),
         rawPathParams: {'id': id},
         initialChildren: children,
       );

  static const String name = 'SaleIdRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<SaleIdRouteArgs>(
        orElse: () => SaleIdRouteArgs(id: pathParams.getString('id')),
      );
      return _i10.SaleIdScreen(key: args.key, id: args.id);
    },
  );
}

class SaleIdRouteArgs {
  const SaleIdRouteArgs({this.key, required this.id});

  final _i15.Key? key;

  final String id;

  @override
  String toString() {
    return 'SaleIdRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i11.SaleScreen]
class SaleRoute extends _i14.PageRouteInfo<void> {
  const SaleRoute({List<_i14.PageRouteInfo>? children})
    : super(SaleRoute.name, initialChildren: children);

  static const String name = 'SaleRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i11.SaleScreen();
    },
  );
}

/// generated route for
/// [_i12.ServicesIdScreen]
class ServicesIdRoute extends _i14.PageRouteInfo<ServicesIdRouteArgs> {
  ServicesIdRoute({
    _i15.Key? key,
    required String id,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         ServicesIdRoute.name,
         args: ServicesIdRouteArgs(key: key, id: id),
         rawPathParams: {'id': id},
         initialChildren: children,
       );

  static const String name = 'ServicesIdRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ServicesIdRouteArgs>(
        orElse: () => ServicesIdRouteArgs(id: pathParams.getString('id')),
      );
      return _i12.ServicesIdScreen(key: args.key, id: args.id);
    },
  );
}

class ServicesIdRouteArgs {
  const ServicesIdRouteArgs({this.key, required this.id});

  final _i15.Key? key;

  final String id;

  @override
  String toString() {
    return 'ServicesIdRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i13.ServicesScreen]
class ServicesRoute extends _i14.PageRouteInfo<void> {
  const ServicesRoute({List<_i14.PageRouteInfo>? children})
    : super(ServicesRoute.name, initialChildren: children);

  static const String name = 'ServicesRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i13.ServicesScreen();
    },
  );
}
