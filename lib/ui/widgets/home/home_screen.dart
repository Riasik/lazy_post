import 'package:flutter/material.dart';
import 'package:lazy_post/configuration/consts.dart';
import 'package:lazy_post/ui/theme/app_colors.dart';
import 'package:provider/src/provider.dart';
import 'home_model.dart';
import 'slider_view.dart';

class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _getAppBar(), body: const _Body());
  }

  AppBar _getAppBar() {
    return AppBar(title: const Text('Lazy Post'), actions: [
      IconButton(
        icon: const Icon(Icons.history, color: Colors.white),
        onPressed: () {},
      ),
    ]);
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeViewModel>();

    return ListView(
      children: [SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //weight
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 8),
                    child: Text(
                      'Вес (кг)',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize:
                              MediaQuery.of(context).size.width > 360 ? 18 : 16,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SliderView(
                    distValue: model.weight,
                    units: 'кг',
                    onChangedistValue: (double value) {
                      model.weight = value;
                      //data.weight = value;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
              //inputs
              Column(
                children: [
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
                              hintText: 'Объём', labelText: 'Объём (м3)'),
                          controller: model.volumeTextController,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true, signed: true),
                          decoration: const InputDecoration(
                              hintText: 'Стоимость',
                              labelText: 'Стоимость (грн)'),
                          controller: model.priceTextController,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),

              //-------  from --------------
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 16, bottom: 8),
                        child: Text(
                          'Отправитель (расстояние)',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: MediaQuery.of(context).size.width > 360
                                  ? 18
                                  : 16,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      FloatingActionButton(
                        backgroundColor: model.checkSenderLocation()
                            ? AppColors.btnColorBlue
                            : AppColors.btnColorGrey,
                        heroTag: "Sender",
                        child: const Icon(
                          Icons.add_location,
                          size: 50,
                        ),
                        onPressed: () {
                          model.setPosition(context, whom: Const.sender);},
                      ),
                    ],
                  ),
                  SliderView(
                    distValue: model.senderDistance,
                    units: 'км',
                    onChangedistValue: (double value) {
                      model.senderDistance = value;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),

              //-------  to --------------
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 16, bottom: 8),
                        child: Text(
                          'Получатель (расстояние)',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: MediaQuery.of(context).size.width > 360
                                  ? 18
                                  : 16,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      FloatingActionButton(
                        backgroundColor: model.checkReceiverLocation()
                            ? AppColors.btnColorBlue
                            : AppColors.btnColorGrey,
                        heroTag: "receiver",
                        child: const Icon(
                          Icons.add_location,
                          size: 50,
                        ),
                        onPressed: () {
                          model.setPosition(context, whom: Const.receiver);
                        },
                      ),
                    ],
                  ),
                  SliderView(
                    distValue: model.receiverDistance,
                    units: 'км',
                    onChangedistValue: (double value) {
                      model.receiverDistance = value;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                      padding:
                          const EdgeInsets.only(right: 16, top: 8, bottom: 8),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade300,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(38.0),
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  offset: const Offset(0, 2),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 4, bottom: 4),
                            child: InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(24.0)),
                              highlightColor: model.checkSenderLocation() &&
                                      model.checkReceiverLocation()
                                  ? AppColors.btnColorBlue
                                  : AppColors.btnColorGrey,
                              onTap: () {
                                model.checkLogisticResult(context);
                              },
                              child: const Center(
                                child: Text(
                                  'Поиск',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 25,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          )))),
              const SizedBox(height: 10),
              Center(
                  child: Text(model.errMessage,
                      style: const TextStyle(color: AppColors.colorWarning))),
              const SizedBox(height: 10),
              model.errMessage != ''
                  ? FloatingActionButton(
                      heroTag: "receiver",
                      child: const Icon(
                        Icons.settings,
                        size: 50,
                      ),
                      onPressed: () {
                        //model.openAppSettings();
                      })
                  : const SizedBox()
            ],
          ),
        ),
      )],
    );
  }
}
