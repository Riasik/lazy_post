
import 'package:flutter/material.dart';
import 'package:lazy_post/ui/theme/app_colors.dart';

import '../home_model.dart';

class MyButton extends StatelessWidget {
  String name;
  bool? checked;
  MyButton({Key? key, required this.name, required this.checked, required this.model})
      : super(key: key);
  final HomeViewModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        color: checked! ? AppColors.btnColorBlue : AppColors.btnColorGrey,
        borderRadius: const BorderRadius.all(
          Radius.circular(38.0),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.white, offset: const Offset(0, 2), blurRadius: 8.0),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(32.0),
          ),
          onTap: () {
            model.checkAndUpdateButtons(name);
          },
          child: Padding(
              padding: EdgeInsets.all(7.0),
              child: Text(name,textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ))),
        ),
      ),
    );
  }
}
