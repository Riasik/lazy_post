import 'package:flutter/material.dart';
import 'package:lazy_post/ui/theme/app_colors.dart';

import '../home_model.dart';

class MyLocationWidget extends StatelessWidget {
  const MyLocationWidget({
    Key? key,
    required this.model,
    required this.title,
    required this.coordinates,
    required this.hasCoordinates,
  }) : super(key: key);

  final HomeViewModel model;
  final String title;
  final Coordinates coordinates;
  final bool hasCoordinates;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
            Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                    fontWeight: FontWeight.normal),
              ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
              FloatingActionButton(
                backgroundColor: hasCoordinates
                    ? AppColors.btnColorBlue
                    : AppColors.btnColorGrey,
                heroTag: coordinates,
                tooltip: 'Выберите точку отправки',
                child: Icon(
                  hasCoordinates ? Icons.location_on : Icons.place_outlined,
                  size: 50,
                ),
                onPressed: () {
                  model.setPosition(context, whom: coordinates);
                },
              ),
              const SizedBox(width: 20,),
              IconButton(
                onPressed: hasCoordinates
                    ? () {
                        model.viewNearPoints(coordinates, context);
                      }
                    : null,
                icon: Icon(
                  hasCoordinates
                      ? Icons.near_me
                      : Icons.near_me_disabled_outlined,
                ),
              )
            ]),
            const SizedBox(height: 10,)
          ],
    );
  }
}
