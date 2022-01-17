import 'package:flutter/material.dart';
import 'package:lazy_post/configuration/consts.dart';
import 'package:lazy_post/ui/navigation/main_navigation.dart';
import 'package:lazy_post/ui/theme/app_colors.dart';
import 'package:provider/src/provider.dart';
import 'home_model.dart';
import 'slider_view.dart';

class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeViewModel>();
    return Scaffold(
      appBar: _getAppBar(context),
      body: const _Body(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.btnColorGrey,
        heroTag: "Удалить",
        child: const Icon(
          Icons.delete,
          size: 50,
        ),
        onPressed: () {
          model.setInit();
        },
      ),
    );
  }

  AppBar _getAppBar(BuildContext context) {
    return AppBar(title: const Text('Lazy Post'), actions: [
      IconButton(
        icon: const Icon(Icons.history, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pushNamed(MainNavigationRouteNames.homeHistory);
        },
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
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //weight
                Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                     Text(
                        'Вес (кг)',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: MediaQuery.of(context).size.width > 360
                                ? 18
                                : 16,
                            fontWeight: FontWeight.normal),
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
                              keyboardType:
                                  const TextInputType.numberWithOptions(
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
                              keyboardType:
                                  const TextInputType.numberWithOptions(
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
                              keyboardType:
                                  const TextInputType.numberWithOptions(
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
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true, signed: true),
                              decoration: const InputDecoration(
                                  hintText: 'Объём', labelText: 'Объём (м3)'),
                              controller: model.volumeTextController,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextField(
                              keyboardType:
                                  const TextInputType.numberWithOptions(
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
                        Expanded(
                          flex: 2,
                          child:  Text(
                              'Отправитель',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize:
                                      MediaQuery.of(context).size.width > 360
                                          ? 18
                                          : 16,
                                  fontWeight: FontWeight.normal),
                            ),

                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: model.senderOffice
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
                                model.changeTerminalOffice(Const.senderOffice);
                              },
                              child: const Padding(
                                  padding: EdgeInsets.all(7.0),
                                  child: Icon(Icons.store,
                                      size: 30,
                                      color: Colors
                                          .white) // HotelAppTheme.buildLightTheme().backgroundColor),
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: model.senderTerminal
                                ? AppColors.btnColorBlue
                                : AppColors.btnColorGrey,
                            //HotelAppTheme.buildLightTheme().primaryColor,
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
                                model
                                    .changeTerminalOffice(Const.senderTerminal);
                              },
                              child: const Padding(
                                  padding: EdgeInsets.all(7.0),
                                  child: Icon(Icons.corporate_fare,
                                      size: 30,
                                      color: Colors
                                          .white) // HotelAppTheme.buildLightTheme().backgroundColor),
                                  ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child:  FloatingActionButton(
                              backgroundColor: model.check(model.senderLocation)
                                  ? AppColors.btnColorBlue
                                  : AppColors.btnColorGrey,
                              heroTag: "Sender",
                              child: Icon(
                                model.check(model.senderLocation)
                                    ? Icons.location_on
                                    : Icons.add_location,
                                size: 50,
                              ),
                              onPressed: () {
                                model.setPosition(context, whom: Const.sender);
                              },
                            ),

                        )
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
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Получатель',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize:
                                    MediaQuery.of(context).size.width > 360
                                        ? 18
                                        : 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: model.receiverOffice
                                ? AppColors.btnColorBlue
                                : AppColors.btnColorGrey,
                            //HotelAppTheme.buildLightTheme().primaryColor,
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
                                model
                                    .changeTerminalOffice(Const.receiverOffice);
                              },
                              child: const Padding(
                                  padding: EdgeInsets.all(7.0),
                                  child: Icon(Icons.store,
                                      size: 30,
                                      color: Colors
                                          .white) // HotelAppTheme.buildLightTheme().backgroundColor),
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: model.receiverTerminal
                                ? AppColors.btnColorBlue
                                : AppColors.btnColorGrey,
                            //HotelAppTheme.buildLightTheme().primaryColor,
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
                                    Const.receiverTerminal);
                              },
                              child: const Padding(
                                  padding: EdgeInsets.all(7.0),
                                  child: Icon(Icons.corporate_fare,
                                      size: 30,
                                      color: Colors
                                          .white) // HotelAppTheme.buildLightTheme().backgroundColor),
                                  ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 1),
                            child: FloatingActionButton(
                              backgroundColor:
                                  model.check(model.receiverLocation)
                                      ? AppColors.btnColorBlue
                                      : AppColors.btnColorGrey,
                              heroTag: "receiver",
                              child: Icon(
                                model.check(model.receiverLocation)
                                    ? Icons.location_on
                                    : Icons.add_location,
                                size: 50,
                              ),
                              onPressed: () {
                                model.setPosition(context,
                                    whom: Const.receiver);
                              },
                            ),
                          ),
                        )
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
                Container(
                        decoration: BoxDecoration(
                          color: model.checkAllParams()
                              ? AppColors.btnColorBlue
                              : AppColors.btnColorGrey,
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
                            highlightColor: AppColors.btnColorBlue,
                            onTap: () {

                              if(!model.checkAllParams()) {
                                _showToast(context, 'Заполните все поля!\nУкажите точку отправки и получения!');
                              }else{
                                model.checkLogisticResult(context);
                              }
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
                        )),
                const SizedBox(height: 10),
                // Center(
                //
                //     child: Text(model.errMessage,
                //         textAlign: TextAlign.center,
                //         style: const TextStyle(color: AppColors.colorWarning))),
              ],
            ),
          ),
        )
      ],
    );
  }
  void _showToast(BuildContext context, String textToast) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(textToast),
        action: SnackBarAction(label: 'X', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
