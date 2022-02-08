import 'package:flutter/material.dart';
import 'package:lazy_post/configuration/consts.dart';

import '../../../theme/app_colors.dart';
import '../home_model.dart';
import 'slider_view.dart';

class EditLocationWidget extends StatelessWidget {
  final String title;
  final HomeViewModel model;
  final Coordinates coordinates;

  const EditLocationWidget(
      {Key? key,
        required this.title,
        required this.model,
        required this.coordinates})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var officeIcon = (coordinates == Coordinates.sender)
        ? model.senderOffice
        : model.receiverOffice;
    var terminalIcon = (coordinates == Coordinates.sender)
        ? model.senderTerminal
        : model.receiverTerminal;
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
              fontWeight: FontWeight.normal),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(coordinates == Coordinates.sender
                    ? 'отделения'
                    : 'отделении'),
                const SizedBox(height: 3),
                Container(
                  decoration: BoxDecoration(
                    color: officeIcon
                        ? AppColors.btnColorBlue
                        : AppColors.btnColorGrey,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(38.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          offset: const Offset(0, 2),
                          blurRadius: 8.0),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {
                        model.changeTerminalOffice(
                            coordinates == Coordinates.sender
                                ? Const.senderOffice
                                : Const.receiverOffice);
                      },
                      child: const Padding(
                          padding: EdgeInsets.all(7.0),
                          child:
                          Icon(Icons.store, size: 30, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Column(children: [
              Text(coordinates == Coordinates.sender
                  ? 'почтомата'
                  : 'почтомате'),
              const SizedBox(height: 3),
              Container(
                decoration: BoxDecoration(
                  color: terminalIcon
                      ? AppColors.btnColorBlue
                      : AppColors.btnColorGrey,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    onTap: () {
                      model.changeTerminalOffice(
                          coordinates == Coordinates.sender
                              ? Const.senderTerminal
                              : Const.receiverTerminal);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(7.0),
                      child: Icon(Icons.corporate_fare,
                          size: 30, color: Colors.white),
                    ),
                  ),
                ),
              )
            ])
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SliderView(
          distValue: coordinates == Coordinates.sender
              ? model.senderDistance
              : model.receiverDistance,
          units: 'км',
          min: 0,
          max: 10,
          onChangedistValue: (double value) {
            coordinates == Coordinates.sender
                ? model.senderDistance = value
                : model.receiverDistance = value;
          },
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}