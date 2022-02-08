import 'package:flutter/material.dart';

import '../home_model.dart';
import 'slider_view.dart';

class Inputs extends StatelessWidget {
  const Inputs({
    Key? key,
    required this.model,
  }) : super(key: key);

  final HomeViewModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            'Указать размеры:',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey.shade700,
                fontSize:
                MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
          ),),
        const SizedBox(height: 5,),
        Row(
          children: [
            Expanded(
              child: TextField(
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                decoration: const InputDecoration(
                    hintText: 'Длинна', labelText: 'Длинна (см)'),
                controller: model.lengthTextController,
                onChanged: (v) {
                  model.calculateVolume();
                },
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextField(
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                decoration: const InputDecoration(
                    hintText: 'Ширина', labelText: 'Ширина (см)'),
                controller: model.widthTextController,
                onChanged: (v) {
                  model.calculateVolume();
                },
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextField(
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                decoration: const InputDecoration(
                    hintText: 'Высота', labelText: 'Высота (см)'),
                controller: model.heightTextController,
                onChanged: (v) {
                  model.calculateVolume();
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                decoration: const InputDecoration(
                    hintText: 'Объём', labelText: 'Объёмный вес (кг)'),
                controller: model.volumeTextController,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextField(
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                decoration: const InputDecoration(
                    hintText: 'Стоимость', labelText: 'Стоимость (грн)'),
                controller: model.priceTextController,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Weight(model: model)
      ],
    );
  }
}

class Weight extends StatelessWidget {
  const Weight({
    Key? key,
    required this.model,
  }) : super(key: key);

  final HomeViewModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Вес (кг)',
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
              fontWeight: FontWeight.normal),
        ),
        SliderView(
          distValue: model.weight,
          min: 0.5,
          max: 50,
          units: 'кг',
          onChangedistValue: (double value) {
            model.weight = value;
          },
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}