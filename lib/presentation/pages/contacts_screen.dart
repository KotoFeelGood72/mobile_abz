import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_abz/presentation/widgets/layouts.dart';
// import 'package:yandex_mapkit/yandex_mapkit.dart';

@RoutePage()
class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final mapObjects = <MapObject>[
    //   PlacemarkMapObject(
    //     mapId: const MapObjectId('placemark_1'),
    //     point: const Point(latitude: 55.729274, longitude: 37.624875),
    //     icon: PlacemarkIcon.single(
    //       PlacemarkIconStyle(
    //         image: BitmapDescriptor.fromAssetImage(
    //           'assets/images/car_marker.png',
    //         ),
    //         scale: 2,
    //       ),
    //     ),
    // ),
    // ];

    return Layouts(slivers: [
      SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Карта
            // SizedBox(
            //   height: 200,
            //   child: YandexMap(
            //     mapObjects: mapObjects,
            //     onMapCreated: (controller) {
            //       controller.moveCamera(
            //         CameraUpdate.newCameraPosition(
            //           const CameraPosition(
            //             target: Point(latitude: 55.729274, longitude: 37.624875),
            //             zoom: 16,
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Адрес
                  const Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.purple),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '5-ый Донской проезд, дом 19',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Кнопка "Проложить маршрут"
                  OutlinedButton(
                    onPressed: () {
                      // Логика для маршрута
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.purple),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Text(
                      'Проложить маршрут',
                      style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 1),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Телефон
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.black),
                      SizedBox(width: 8),
                      Text(
                        '8 (495) 649-60-47',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // WhatsApp
                  Row(
                    children: [
                      // Icon(Icons.whatsapp, color: Colors.green),
                      SizedBox(width: 8),
                      Text(
                        '8 (495) 649-60-47',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Telegram
                  Row(
                    children: [
                      Icon(Icons.telegram, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(
                        '8 (495) 649-60-47',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    ], currentIndex: 4);
  }
}
