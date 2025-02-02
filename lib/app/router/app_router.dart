import 'package:auto_route/auto_route.dart';
import 'package:mobile_abz/app/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        CustomRoute(
            page: HomeRoute.page,
            path: '/home',
            initial: true,
            durationInMilliseconds: 100,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: ReviewsRoute.page,
            path: '/reviews',
            durationInMilliseconds: 100,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: FaqRoute.page,
            path: '/faq',
            durationInMilliseconds: 100,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: ContactsRoute.page,
            path: '/contacts',
            durationInMilliseconds: 100,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: FeaturedRoute.page,
            path: '/featured',
            durationInMilliseconds: 100,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: FeaturedIdRoute.page,
            path: '/featured/:id',
            durationInMilliseconds: 100,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: ServicesIdRoute.page,
            path: '/services/:id',
            durationInMilliseconds: 100,
            transitionsBuilder: TransitionsBuilders.fadeIn),
      ];
}
