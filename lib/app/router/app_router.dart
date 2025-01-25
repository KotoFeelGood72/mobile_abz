import 'package:auto_route/auto_route.dart';

import 'package:mobile_abz/app/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          path: '/home',
          initial: true,
        ),
        AutoRoute(
          page: ReviewsRoute.page,
          path: '/reviews',
        ),
        AutoRoute(
          page: FaqRoute.page,
          path: '/faq',
        ),
        AutoRoute(
          page: ContactsRoute.page,
          path: '/contacts',
        ),
        AutoRoute(
          page: FeaturedTemplateRoute.page,
          path: '/featured',
          children: [
            AutoRoute(
              page: FeaturedRoute.page,
              path: '',
            ),
            AutoRoute(
              page: FeaturedIdRoute.page,
              path: ':id',
            ),
          ],
        ),
      ];
}
